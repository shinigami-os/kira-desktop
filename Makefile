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

BIN = build/kira-desktop

all: $(BIN)

$(BIN): $(SRC)
	mkdir -p build
	$(CC) $(CFLAGS) -o $@ $^

debug: $(SRC)
	mkdir -p build
	$(CC) $(CFLAGS_DEBUG) -o $(BIN) $^

clean:
	rm -rf build/

.PHONY: all debug clean