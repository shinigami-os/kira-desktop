# kira-desktop
> Desktop environment configuration for Kira Linux.

Ships default config files for Kira desktop environments. Every config file is documented and meant to be read and modified.

## Repository Layout

One lowercase folder per desktop environment at the repo root, plus shared DE-agnostic scripts:

```
kira-desktop/
  swayfx/             SwayFX configs: sway, eww, foot, fuzzel, mako, hyprlock, gtk-3.0, xdg-desktop-portal
  scripts/            shared across every DE: kira-run, kira-theme, kira-start-<de> launchers
```

`kira-desktop-swayFX-config` clones this repo fresh in its `%build` step and copies straight out of `swayfx/` and `scripts/` - there's no static copy checked into `flux-recipes` to drift out of sync.

Sleex has no folder here: its user config is upstream's own `sleex-user-config`, installed by `kira-sleex`, with the few Kira-only tweaks applied as build-time patches in that recipe.

`swayfx/kira/audio.sh` starts the PipeWire stack (pipewire → wireplumber → pipewire-pulse, in that order) under the session bus, killing any stale instances first and waiting for the PipeWire socket to appear before continuing. sway/config's autostart calls it instead of starting the three daemons itself.

## Versioning

Same release-based scheme as `flux`/`kira-base`: `YY.MM`, optionally `-N` for a hotfix release in that month (current: `26.10-1`). Tag with `git tag <version> && git push --tags`, no GitHub Release object needed.

## Status
`swayfx/` is populated and installed on real hardware via its flux meta-package. See the [Kira Linux specification](https://github.com/shinigami-os) and the project roadmap.

## License
MIT
