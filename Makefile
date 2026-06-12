CC = clang
CFLAGS = -Wall -Wextra -O2 -std=c11 -D_POSIX_C_SOURCE=200809L
CFLAGS_DEBUG = -Wall -Wextra -g -O0 -std=c11 -D_POSIX_C_SOURCE=200809L -fsanitize=address

SRC = src/main.c \
	src/de.c \
	src/util.c \
	src/commands/list.c \
	src/commands/install.c \
	src/commands/switch.c \
	src/commands/remove.c \
	src/commands/status.c

BIN     = build/kira-desktop
DESTDIR ?=

all: $(BIN)

$(BIN): $(SRC)
	mkdir -p build
	$(CC) $(CFLAGS) -o $@ $^

debug: $(SRC)
	mkdir -p build
	$(CC) $(CFLAGS_DEBUG) -o $(BIN) $^

install: $(BIN)
	install -Dm755 $(BIN)                    $(DESTDIR)/usr/bin/kira-desktop
	install -Dm755 scripts/kira-theme        $(DESTDIR)/usr/bin/kira-theme
	install -Dm755 scripts/kira-start-swayFX $(DESTDIR)/usr/bin/kira-start-swayFX
	install -Dm755 scripts/kira-run          $(DESTDIR)/usr/bin/kira-run
	install -dm755 $(DESTDIR)/usr/share/kira-desktop/templates
	install -dm755 $(DESTDIR)/usr/share/kira-desktop/themes
	install -dm755 $(DESTDIR)/usr/share/kira-desktop/descriptors
	cp -r templates/* $(DESTDIR)/usr/share/kira-desktop/templates/
	cp -r themes/*    $(DESTDIR)/usr/share/kira-desktop/themes/

clean:
	rm -rf build/

.PHONY: all debug clean install