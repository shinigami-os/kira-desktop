#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include "../include/de.h"

static void strip(char *s) {
    /* strip leading whitespace */
    char *start = s;
    while (*start == ' ' || *start == '\t') start++;
    if (start != s) memmove(s, start, strlen(start) + 1);

    /* strip trailing whitespace and newline */
    char *end = s + strlen(s) - 1;
    while (end >= s && (*end == ' ' || *end == '\t' || *end == '\n' || *end == '\r')) *end-- = '\0';
}

int de_parse(const char *path, DE *out) {
    FILE *f = fopen(path, "r");
    if (!f) return -1;

    memset(out, 0, sizeof(DE));

    char line[512];
    while (fgets(line, sizeof(line), f)) {
        /* skip comments and blank lines */
        strip(line);
        if (line[0] == '#' || line[0] == '\0') continue;

        char *eq = strchr(line, '=');
        if (!eq) continue;

        *eq = '\0';
        char *key = line;
        char *val = eq + 1;
        strip(key);
        strip(val);

        if (strcmp(key, "name") == 0) strncpy(out->name, val, sizeof(out->name) - 1);
        else if (strcmp(key, "package") == 0) strncpy(out->package, val, sizeof(out->package) - 1);
        else if (strcmp(key, "launch") == 0) strncpy(out->launch, val, sizeof(out->launch) - 1);
        else if (strcmp(key, "description") == 0) strncpy(out->description, val, sizeof(out->description) - 1);
    }

    fclose(f);

    /* a valid descriptor must have at least name and package */
    if (out->name[0] == '\0' || out->package[0] == '\0') return -1;

    return 0;
}

int de_find(const char *name, DE *out) {
    char path[512];
    snprintf(path, sizeof(path), "%s%s.desktop-env", DE_PATH, name);
    return de_parse(path, out);
}

int de_is_installed(const DE *de) {
    char path[512];
    snprintf(path, sizeof(path), "%s%s", FLUX_INSTALL_PATH, de->package);
    struct stat st;
    return stat(path, &st) == 0 && S_ISDIR(st.st_mode);
}