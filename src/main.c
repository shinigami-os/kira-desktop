#include <stdio.h>
#include <string.h>

/* forward declarations */
int cmd_list(void);
int cmd_install(const char *name);
int cmd_switch(const char *name);
int cmd_remove(const char *name);
int cmd_status(void);

static void usage(void) {
    fprintf(stderr,
        "Usage: kira-desktop <command> [args]\n"
        "\n"
        "Commands:\n"
        "  list               List available desktop environments\n"
        "  install <de>       Install a desktop environment\n"
        "  switch  <de>       Set active desktop environment (next login)\n"
        "  remove  <de>       Remove a desktop environment\n"
        "  status             Show current DE and session info\n"
    );
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        usage();
        return 1;
    }

    const char *cmd = argv[1];

    if (strcmp(cmd, "list") == 0) {
        return cmd_list();
    } else if (strcmp(cmd, "install") == 0) {
        if (argc < 3) { fprintf(stderr, "Usage: kira-desktop install <de>\n"); return 1; }
        return cmd_install(argv[2]);
    } else if (strcmp(cmd, "switch") == 0) {
        if (argc < 3) { fprintf(stderr, "Usage: kira-desktop switch <de>\n"); return 1; }
        return cmd_switch(argv[2]);
    } else if (strcmp(cmd, "remove") == 0) {
        if (argc < 3) { fprintf(stderr, "Usage: kira-desktop remove <de>\n"); return 1; }
        return cmd_remove(argv[2]);
    } else if (strcmp(cmd, "status") == 0) {
        return cmd_status();
    } else {
        fprintf(stderr, "kira-desktop: unknown command '%s'\n", cmd);
        usage();
        return 1;
    }
}