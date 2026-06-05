#include <stdio.h>
#include "../../include/de.h"
#include "../../include/util.h"

int cmd_install(const char *name) {
    DE de;
    if (de_find(name, &de) != 0) {
        fprintf(stderr, "kira-desktop: DE '%s' not found\n", name);
        return 1;
    }

    if (de_is_installed(&de)) {
        printf("'%s' is already installed.\n", de.name);
        return 0;
    }

    printf("Installing '%s' via flux...\n", de.name);

    const char *argv[] = { "flux", "install", de.package, NULL };
    int ret = run_cmd(argv);

    if (ret != 0) {
        fprintf(stderr, "kira-desktop: flux install failed (exit %d)\n", ret);
        return 1;
    }

    printf("'%s' installed successfully.\n", de.name);
    printf("Run 'kira-desktop switch %s' to activate it.\n", de.name);
    return 0;
}