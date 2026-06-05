#ifndef DE_H
#define DE_H

#include <stddef.h>

typedef struct {
    char name[64];          // "swayFX"
    char package[128];      // "kira-desktop-swayFX"
    char launch[256];       // "/usr/bin/kira-start-swayFX"
    char description[512];  // human-readable description
} DE;

#define DE_PATH "/usr/share/kira-desktop/"
#define FLUX_INSTALL_PATH "/var/lib/flux/installed/"

void kira_active_de_path(char *buf, size_t len);
void kira_current_theme_path(char *buf, size_t len);

int de_parse(const char *path, DE *out);
int de_find(const char *name, DE *out);
int de_is_installed(const DE *de);


#endif
