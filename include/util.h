#ifndef UTIL_H
#define UTIL_H

#include <stddef.h>

void die(const char *fmt, ...);
int read_first_line(const char *path, char *buf, size_t len);
int write_file(const char *path, const char *content);
int run_cmd(const char **argv);

#endif