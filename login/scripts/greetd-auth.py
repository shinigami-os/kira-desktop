#!/usr/bin/env python3
# Speaks greetd's IPC protocol directly (4-byte little-endian length prefix +
# JSON, over the unix socket at $GREETD_SOCK) since Kira Login replaces
# regreet entirely and nothing else in the greeter session does this for us.
# The whole create_session -> auth loop -> start_session exchange has to
# happen inside one connection, so it all lives in this one process instead
# of being split across shell script invocations.
import json
import os
import pwd
import socket
import struct
import subprocess
import sys

USERNAME = "kira"
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))


def send(sock, msg):
    data = json.dumps(msg).encode()
    sock.sendall(struct.pack("<I", len(data)) + data)


def recv(sock):
    hdr = b""
    while len(hdr) < 4:
        chunk = sock.recv(4 - len(hdr))
        if not chunk:
            raise ConnectionError("greetd closed the connection")
        hdr += chunk
    (length,) = struct.unpack("<I", hdr)
    data = b""
    while len(data) < length:
        chunk = sock.recv(length - len(data))
        if not chunk:
            raise ConnectionError("greetd closed the connection")
        data += chunk
    return json.loads(data)


def eww(*args):
    # without --config, eww falls back to $XDG_CONFIG_HOME/eww (nonexistent
    # for the greetd user) instead of the actual running daemon's config
    # dir, and just fails to connect
    subprocess.run(["eww", "--config", "/etc/greetd/kira-login", *args], check=False)


def resolve_session(name):
    sessions = json.loads(subprocess.run(
        [os.path.join(SCRIPT_DIR, "sessions.sh")],
        capture_output=True, text=True, check=True).stdout)
    session = next((s for s in sessions if s["name"] == name), sessions[-1])

    if session["cmd"] == ["__TTY__"]:
        shell = pwd.getpwnam(USERNAME).pw_shell or "/bin/sh"
        return [shell, "-l"], ["XDG_SESSION_TYPE=tty"]

    return session["cmd"], [
        "XDG_SESSION_TYPE=wayland",
        f"XDG_SESSION_DESKTOP={name}",
        f"XDG_CURRENT_DESKTOP={name}",
    ]


def main():
    if len(sys.argv) < 2:
        print("usage: greetd-auth.py <session-name>", file=sys.stderr)
        sys.exit(1)

    session_name = sys.argv[1]
    password = sys.stdin.readline().rstrip("\n")

    sock_path = os.environ.get("GREETD_SOCK")
    if not sock_path:
        print("greetd-auth: $GREETD_SOCK is unset", file=sys.stderr)
        sys.exit(1)

    cmd, env = resolve_session(session_name)

    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    try:
        sock.connect(sock_path)

        send(sock, {"type": "create_session", "username": USERNAME})
        resp = recv(sock)

        while resp.get("type") == "auth_message":
            answer = password if resp.get("auth_message_type") in ("visible", "secret") else None
            send(sock, {"type": "post_auth_message_response", "response": answer})
            resp = recv(sock)

        if resp.get("type") == "error":
            send(sock, {"type": "cancel_session"})
            sys.exit(1)

        # tell the UI to start its success animation now - StartSession itself
        # blocks until the real session takes over the display, which can take
        # a moment (compositor + shell startup)
        eww("update", "auth_state=success")

        send(sock, {"type": "start_session", "cmd": cmd, "env": env})
        resp = recv(sock)
        if resp.get("type") == "error":
            eww("update", "auth_state=error")
            sys.exit(1)
    except Exception as exc:
        print(f"greetd-auth: {exc}", file=sys.stderr)
        sys.exit(1)
    finally:
        sock.close()


if __name__ == "__main__":
    main()
