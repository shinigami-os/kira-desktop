#include <stdio.h>
#include <string.h>
#include <dirent.h>
#include "../../include/de.h"
#include "../../include/util.h"

int cmd_list(void) {
    char active[64] = {0};
    char active_path[512];
    kira_active_de_path(active_path, sizeof(active_path));
    read_first_line(active_path, active, sizeof(active));

    DIR *dir = opendir(DE_PATH);
    if (!dir) {
        fprintf(stderr, "kira-desktop: cannot open DE directory: %s\n", DE_PATH);
        return 1;
    }

    printf("Available desktop environments:\n\n");

    struct dirent *ent;
    while ((ent = readdir(dir)) != NULL) {
        char *dot = strstr(ent->d_name, ".desktop-env");
        if (!dot) continue;

        char path[512];
        snprintf(path, sizeof(path), "%s%s", DE_PATH, ent->d_name);

        DE de;
        if (de_parse(path, &de) != 0) continue;

        int is_active = (strcmp(de.name, active) == 0);
        printf("  %s %-20s  %s\n", is_active ? "*" : " ", de.name, de.description);
    }

    closedir(dir);
    printf("\n* = currently active\n");
    return 0;
}