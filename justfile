# Iosevka customizer: https://typeof.net/Iosevka/customizer
# Nerd fonts cheat sheet: https://www.nerdfonts.com/cheat-sheet

set script-interpreter := ['uv', 'run', '--script']

default: clone build-image compile-iosevka nerd-font-patch

# Clone Iosevka and nerd-fonts repositories at latest release
[script]
clone:
    import subprocess, os

    def get_latest_tag(repo_url):
        result = subprocess.run(
            ["git", "ls-remote", "--tags", "--sort=-version:refname", repo_url],
            capture_output=True, text=True, check=True
        )
        first_line = result.stdout.strip().split("\n")[0]
        return first_line.split()[1].replace("refs/tags/", "")

    def clone_or_update(name, repo_url):
        tag = get_latest_tag(repo_url)
        print(f"{name}: latest release is {tag}")
        if os.path.isdir(name):
            subprocess.run(["git", "-C", name, "fetch", "--depth", "1", "origin", "tag", tag], check=True)
            subprocess.run(["git", "-C", name, "checkout", tag], check=True)
        else:
            subprocess.run(["git", "clone", "--depth", "1", "--branch", tag, repo_url], check=True)

    clone_or_update("Iosevka", "https://github.com/be5invis/Iosevka.git")
    clone_or_update("nerd-fonts", "https://github.com/ryanoasis/nerd-fonts.git")

# Build Docker images for font compilation and patching
build-image:
    docker build -t=nerdfonts/patcher nerd-fonts
    docker build -t=fontcc Iosevka/docker

# Build Iosevka font distribution
compile-iosevka:
    docker run -it --rm -v ${PWD}:/work fontcc ttf-unhinted::iosevka ttf-unhinted::iosevka-term

# Patch fonts with Nerd Font glyphs
nerd-font-patch:
    docker run --rm -v ./dist/iosevka-term/TTF-Unhinted/:/in:Z -v ./dist:/out:Z nerdfonts/patcher --careful --complete
    docker run --rm -v ./dist/iosevka/TTF-Unhinted/:/in:Z -v ./dist:/out:Z nerdfonts/patcher --careful --complete
