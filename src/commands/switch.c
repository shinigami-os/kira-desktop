#include <stdio.h>
#include "../../include/de.h"
#include "../../include/util.h"

int cmd_switch(const char *name) {
    DE de;
    if (de_find(name, &de) != 0) {
        fprintf(stderr, "kira-desktop: DE '%s' not found\n", name);
        return 1;
    }

    if (!de_is_installed(&de)) {
        fprintf(stderr, "kira-desktop: '%s' is not installed.\n", de.name);
        fprintf(stderr, "Run 'kira-desktop install %s' first.\n", de.name);
        return 1;
    }

    /* apply theme for this DE */
    char theme_path[512];
    kira_current_theme_path(theme_path, sizeof(theme_path));

    char theme[64] = "kira-default";
    read_first_line(theme_path, theme, sizeof(theme));

    printf("Applying theme '%s' for '%s'...\n", theme, de.name);
    const char *theme_argv[] = { "kira-theme", "apply", theme, NULL };
    run_cmd(theme_argv);

    /* write active DE */
    char active_path[512];
    kira_active_de_path(active_path, sizeof(active_path));

    if (write_file(active_path, de.name) != 0) {
        fprintf(stderr, "kira-desktop: failed to write active-de\n");
        return 1;
    }

    printf("Switched to '%s'. Changes take effect on next login.\n", de.name);
    return 0;
}