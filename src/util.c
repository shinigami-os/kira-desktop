#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <unistd.h>
#include <sys/wait.h>
#include "../include/util.h"

void die(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    fprintf(stderr, "kira-desktop: error: ");
    vfprintf(stderr, fmt, ap);
    fprintf(stderr, "\n");
    va_end(ap);
    exit(1);
}

int read_first_line(const char *path, char *buf, size_t len) {
    FILE *f = fopen(path, "r");
    if (!f) return -1;

    if (!fgets(buf, (int)len, f)) {
        fclose(f);
        return -1;
    }
    fclose(f);

    /* strip newline */
    char *nl = strchr(buf, '\n');
    if (nl) *nl = '\0';

    return 0;
}

int write_file(const char *path, const char *content) {
    FILE *f = fopen(path, "w");
    if (!f) return -1;
    fprintf(f, "%s\n", content);
    fclose(f);
    return 0;
}

int run_cmd(const char **argv) {
    pid_t pid = fork();
    if (pid < 0) return -1;

    if (pid == 0) {
        execvp(argv[0], (char *const *)argv);
        /* execvp only returns on failure */
        fprintf(stderr, "kira-desktop: failed to exec '%s'\n", argv[0]);
        exit(1);
    }

    int status;
    waitpid(pid, &status, 0);

    if (WIFEXITED(status)) return WEXITSTATUS(status);
    return -1;
}

void kira_active_de_path(char *buf, size_t len) {
    const char *home = getenv("HOME");
    if (!home) home = "/root";
    snprintf(buf, len, "%s/.config/kira-desktop/active-de", home);
}

void kira_current_theme_path(char *buf, size_t len) {
    const char *home = getenv("HOME");
    if (!home) home = "/root";
    snprintf(buf, len, "%s/.config/kira-desktop/current-theme", home);
}