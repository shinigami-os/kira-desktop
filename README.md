# kira-desktop
> Desktop environment configuration for Kira Linux.

Ships default config files for Kira desktop environments. Every config file is documented and meant to be read and modified.

## Repository Layout

One lowercase folder per desktop environment at the repo root, plus shared DE-agnostic scripts:

```
kira-desktop/
  swayfx/             SwayFX configs: sway, eww, foot, fuzzel, mako, swaylock, gtk-3.0, xdg-desktop-portal
  sleex/              Sleex configs: Hyprland, Kvantum, qt5ct/qt6ct, fontconfig, foot, fuzzel,
                      matugen, starship, kdeglobals, anyrun, wlogout, and more
  scripts/            shared across every DE: kira-run, kira-theme, kira-start-<de> launchers, audio.sh
```

The corresponding flux meta-package (`kira-desktop-swayFX`, `kira-desktop-sleex`) clones this repo fresh in its `%build` step and copies straight out of `<de>/` and `scripts/` - there's no static copy checked into `flux-recipes` to drift out of sync.

`scripts/audio.sh` starts the PipeWire stack (pipewire → wireplumber → pipewire-pulse, in that order) under the session bus, killing any stale instances first and waiting for the PipeWire socket to appear before continuing.

## Versioning

Same release-based scheme as `flux`/`kira-base`: `YY.MM`, optionally `-N` for a hotfix release in that month (current: `26.07-2`). Tag with `git tag <version> && git push --tags`, no GitHub Release object needed.

## Status
Both `swayfx/` and `sleex/` are populated and installed on real hardware via their respective flux meta-packages. See the [Kira Linux specification](https://github.com/shinigami-os) and the project roadmap.

## License
MIT
