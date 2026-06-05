#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "../../include/de.h"
#include "../../include/util.h"

int cmd_status(void) {
    /* active DE */
    char active[64] = {0};
    char active_path[512];
    kira_active_de_path(active_path, sizeof(active_path));

    if (read_first_line(active_path, active, sizeof(active)) != 0) {
        printf("Active DE:   (none set)\n");
    } else {
        printf("Active DE:   %s\n", active);
    }

    /* current theme */
    char theme[64] = {0};
    char theme_path[512];
    kira_current_theme_path(theme_path, sizeof(theme_path));

    if (read_first_line(theme_path, theme, sizeof(theme)) != 0) {
        printf("Theme:       (none set)\n");
    } else {
        printf("Theme:       %s\n", theme);
    }

    const char *swaysock = getenv("SWAYSOCK");
    if (swaysock) {
        printf("Compositor:  sway (SWAYSOCK=%s)\n", swaysock);
    } else {
        printf("Compositor:  (not running or not detectable)\n");
    }

    /* wayland display */
    const char *wayland = getenv("WAYLAND_DISPLAY");
    if (wayland) {
        printf("Wayland:     %s\n", wayland);
    } else {
        printf("Wayland:     (not set)\n");
    }

    return 0;
}