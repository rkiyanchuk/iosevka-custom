# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository builds custom Iosevka fonts with Nerd Font patches. It uses Docker containers to compile fonts from a custom build plan configuration.

## Build Commands

```bash
just                    # Full build: clone, build image, compile fonts, patch with Nerd Fonts
just clone              # Sparse checkout of Iosevka docker/ directory only
just build-fontcc-image # Build Docker image for font compilation
just compile-iosevka    # Compile Iosevka fonts using Docker
just patch-nerd-font    # Patch compiled fonts with Nerd Font glyphs
```

## Architecture

- `private-build-plans.toml` - Font customization configuration defining two font families:
  - `iosevka` - Normal spacing variant
  - `iosevka-term` - Terminal spacing variant (narrower symbols)
  - Both inherit from SS14 stylistic set with custom glyph variants
    (Jetbrains).

- `Iosevka/` - Sparse checkout containing only `docker/` directory for building fontcc image
- `dist/` - Output directory for compiled fonts (TTF-Unhinted subdirectories)

## Key Resources

- [Iosevka Customizer](https://typeof.net/Iosevka/customizer) - Interactive tool for designing build plans
- [Nerd Fonts Cheat Sheet](https://www.nerdfonts.com/cheat-sheet) - Icon lookup reference
- [Custom Build Documentation](https://github.com/be5invis/Iosevka/blob/master/doc/custom-build.md) - Full options reference
