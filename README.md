# Iosevka Custom

Build custom [Iosevka](https://typeof.net/Iosevka/) font and add glyphs (icons) by patching it with 
[Nerd Font](https://www.nerdfonts.com/).

## Features

- Custom glyph variants based on SS14 stylistic set (Jetbrains)
- Two font families: **Iosevka** (normal) and **Iosevka Term** (terminal-optimized)
- Nerd Font icons included
- Always builds from latest Iosevka and NerdFonts releases.

## Requirements

- [Docker](https://www.docker.com/)
- [Just](https://github.com/casey/just) command runner

## Usage

Build everything:

```bash
just
```

Or run individual steps:

```bash
just clone              # Fetch Iosevka Dockerfile (sparse checkout)
just build-fontcc-image # Build Docker image for compilation
just compile-iosevka    # Compile fonts
just patch-nerd-font    # Add Nerd Font icons
```

Output fonts are in `dist/`.

## Customization

Use the [Iosevka Customizer](https://typeof.net/Iosevka/customizer) to design your build plan interactively.

## Resources

- [Iosevka Custom Build Docs](https://github.com/be5invis/Iosevka/blob/master/doc/custom-build.md)
- [Nerd Fonts Cheat Sheet](https://www.nerdfonts.com/cheat-sheet)
