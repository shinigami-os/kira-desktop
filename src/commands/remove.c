#include <stdio.h>
#include <string.h>
#include "../../include/de.h"
#include "../../include/util.h"

int cmd_remove(const char *name) {
    DE de;
    if (de_find(name, &de) != 0) {
        fprintf(stderr, "kira-desktop: DE '%s' not found\n", name);
        return 1;
    }

    /* refuse to remove the active DE */
    char active[64] = {0};
    char active_path[512];
    kira_active_de_path(active_path, sizeof(active_path));
    read_first_line(active_path, active, sizeof(active));

    if (active[0] != '\0' && strcmp(de.name, active) == 0) {
        fprintf(stderr, "kira-desktop: cannot remove the active DE '%s'.\n", de.name);
        fprintf(stderr, "Switch to another DE first.\n");
        return 1;
    }

    if (!de_is_installed(&de)) {
        fprintf(stderr, "kira-desktop: '%s' is not installed.\n", de.name);
        return 1;
    }

    printf("Removing '%s'...\n", de.name);
    const char *argv[] = { "flux", "remove", de.package, NULL };
    int ret = run_cmd(argv);

    if (ret != 0) {
        fprintf(stderr, "kira-desktop: flux remove failed (exit %d)\n", ret);
        return 1;
    }

    printf("'%s' removed.\n", de.name);
    return 0;
}