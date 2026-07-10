#!/bin/sh
if ip route get 1.1.1.1 >/dev/null 2>&1; then echo 1; else echo 0; fi
