#!/usr/bin/env bash

UTILS_PATH=/home/codespace/repos/personal/utils
mkdir -p "$UTILS_PATH"

################ CARGO ################

export CARGO_HOME=$UTILS_PATH/cargo

# https://github.com/bensadeh/despell
cargo install --locked despell

################ GO ################

export GOPATH=$UTILS_PATH/go

go install github.com/apache/mynewt-mcumgr-cli/mcumgr@latest
go install mynewt.apache.org/newt/newt@latest

################ PIPX ################

export R2ENV_PATH=$UTILS_PATH/r2env

export PIPX_HOME=$UTILS_PATH/pipx
export PIPX_BIN_DIR=$PIPX_HOME/bin
export PIPX_MAN_DIR=$PIPX_HOME/man

pipx install gdbgui \
&& pipx install flawfinder \
&& pipx install lizard \
&& pipx install codechecker \
&& pipx install ptpython \
&& pipx install bpython \
&& pipx install meson \
&& pipx install virtualenv \
&& pipx install poetry \
&& pipx install bumble \
&& pipx install git+https://github.com/randy3k/radian \
&& pipx install r2env \
&& r2env init \
&& r2env add radare2@git

################ DOTNET ################

DOTNET_TOOLS_LOCAL=$UTILS_PATH/dotnet

dotnet tool install --tool-path ${DOTNET_TOOLS_LOCAL}  dotnet-repl \
&& dotnet tool install --tool-path ${DOTNET_TOOLS_LOCAL}  dotnet-example \
&& dotnet tool install --tool-path ${DOTNET_TOOLS_LOCAL}  dotnet-sos \
&& dotnet tool install --tool-path ${DOTNET_TOOLS_LOCAL}  dotnet-dump \
&& dotnet tool install --tool-path ${DOTNET_TOOLS_LOCAL}  dotnet-symbol \
&& dotnet tool install --tool-path ${DOTNET_TOOLS_LOCAL}  dotnet-monitor \
&& dotnet tool install --tool-path ${DOTNET_TOOLS_LOCAL}  dotnet-gcdump \
&& dotnet tool install --tool-path ${DOTNET_TOOLS_LOCAL}  dotnet-suggest \
&& dotnet tool install --tool-path ${DOTNET_TOOLS_LOCAL}  dotnet-script \
&& dotnet tool install --tool-path ${DOTNET_TOOLS_LOCAL}  dotnet-counters \
&& dotnet tool install --tool-path ${DOTNET_TOOLS_LOCAL}  dotnet-trace \
&& dotnet tool install --tool-path ${DOTNET_TOOLS_LOCAL}  dotnet-ef \
&& dotnet tool install --tool-path ${DOTNET_TOOLS_LOCAL}  minicover \
&& dotnet tool install --tool-path ${DOTNET_TOOLS_LOCAL}  Husky \
&& dotnet tool install --tool-path ${DOTNET_TOOLS_LOCAL}  dotnet-reportgenerator-globaltool \
&& dotnet tool install --tool-path ${DOTNET_TOOLS_LOCAL}  csharprepl \
&& dotnet tool install --tool-path ${DOTNET_TOOLS_LOCAL}  docfx \
&& dotnet tool install --tool-path ${DOTNET_TOOLS_LOCAL}  Roslynator.DotNet.Cli

################ BINARIES ################

BIN_PATH=$UTILS_PATH/bin
mkdir -p "$BIN_PATH"

wget -nv -O "$BIN_PATH/hadolint" 'https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64' \
&& chmod +x "$BIN_PATH/hadolint"

TEMP_TAR_XZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_XZ" 'https://github.com/koalaman/shellcheck/releases/download/v0.9.0/shellcheck-v0.9.0.linux.x86_64.tar.xz' \
&& tar -xJf "$TEMP_TAR_XZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/shellcheck-v0.9.0/shellcheck" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_XZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/cantino/mcfly/releases/download/v0.8.4/mcfly-v0.8.4-x86_64-unknown-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$BIN_PATH" \
&& rm "$TEMP_TAR_GZ"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-x86_64-unknown-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/bat-v0.24.0-x86_64-unknown-linux-musl/bat" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/gcla/termshark/releases/download/v2.4.0/termshark_2.4.0_linux_x64.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/termshark_2.4.0_linux_x64/termshark" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/peco/peco/releases/download/v0.5.11/peco_linux_amd64.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/peco_linux_amd64/peco" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://dev.yorhel.nl/download/ncdu-2.2.1-linux-x86_64.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$BIN_PATH" \
&& rm "$TEMP_TAR_GZ"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/dandavison/delta/releases/download/0.16.5/delta-0.16.5-x86_64-unknown-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/delta-0.16.5-x86_64-unknown-linux-musl/delta" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/BurntSushi/ripgrep/releases/download/14.0.3/ripgrep-14.0.3-x86_64-unknown-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/ripgrep-14.0.3-x86_64-unknown-linux-musl/rg" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/muesli/duf/releases/download/v0.8.1/duf_0.8.1_linux_x86_64.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/duf" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_ZIP="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_ZIP" 'https://github.com/tstack/lnav/releases/download/v0.11.1/lnav-0.11.1-x86_64-linux-musl.zip' \
&& unzip -j "$TEMP_ZIP" -d "$TEMP_DIR" \
&& mv "${TEMP_DIR}/lnav" "$BIN_PATH" \
&& rm -rf "$TEMP_ZIP" "$TEMP_DIR"

TEMP_ZIP="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_ZIP" 'https://github.com/Canop/broot/releases/download/v1.30.2/broot_1.30.2.zip' \
&& unzip "$TEMP_ZIP" -d "$TEMP_DIR" \
&& mv "${TEMP_DIR}/x86_64-unknown-linux-musl/broot" "$BIN_PATH" \
&& rm -rf "$TEMP_ZIP" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
&& wget -nv -nv -O "$TEMP_TAR_GZ" 'https://github.com/eza-community/eza/releases/download/v0.17.0/eza_x86_64-unknown-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$BIN_PATH" \
&& rm "$TEMP_TAR_GZ"

TEMP_TAR_GZ="$(mktemp)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/starship/starship/releases/download/v1.17.0/starship-x86_64-unknown-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$BIN_PATH" \
&& rm "$TEMP_TAR_GZ"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/sharkdp/fd/releases/download/v9.0.0/fd-v9.0.0-x86_64-unknown-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/fd-v9.0.0-x86_64-unknown-linux-musl/fd" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/denisidoro/navi/releases/download/v2.23.0/navi-v2.23.0-x86_64-unknown-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$BIN_PATH" \
&& rm "$TEMP_TAR_GZ"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/lsd-rs/lsd/releases/download/v1.0.0/lsd-v1.0.0-x86_64-unknown-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/lsd-v1.0.0-x86_64-unknown-linux-musl/lsd" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/extrawurst/gitui/releases/download/v0.24.3/gitui-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$BIN_PATH" \
&& rm "$TEMP_TAR_GZ"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/sharkdp/hyperfine/releases/download/v1.18.0/hyperfine-v1.18.0-x86_64-unknown-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/hyperfine-v1.18.0-x86_64-unknown-linux-musl/hyperfine" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/XAMPPRocky/tokei/releases/download/v13.0.0-alpha.0/tokei-x86_64-unknown-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$BIN_PATH" \
&& rm "$TEMP_TAR_GZ"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/bootandy/dust/releases/download/v0.8.6/dust-v0.8.6-x86_64-unknown-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/dust-v0.8.6-x86_64-unknown-linux-musl/dust" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/pemistahl/grex/releases/download/v1.4.4/grex-v1.4.4-x86_64-unknown-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$BIN_PATH" \
&& rm "$TEMP_TAR_GZ"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/ClementTsang/bottom/releases/download/0.9.6/bottom_x86_64-unknown-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/btm" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/orf/gping/releases/download/gping-v1.16.0/gping-x86_64-unknown-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$BIN_PATH" \
&& rm "$TEMP_TAR_GZ"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/orhun/kmon/releases/download/v1.6.4/kmon-1.6.4-x86_64-unknown-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/kmon-1.6.4/kmon" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/zellij-org/zellij/releases/download/v0.39.2/zellij-x86_64-unknown-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$BIN_PATH" \
&& rm "$TEMP_TAR_GZ"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/chmln/sd/releases/download/v1.0.0/sd-v1.0.0-x86_64-unknown-linux-musl.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/sd-v1.0.0-x86_64-unknown-linux-musl/sd" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

wget -nv -O "$BIN_PATH/bazelisk" 'https://github.com/bazelbuild/bazelisk/releases/download/v1.19.0/bazelisk-linux-amd64' \
&& chmod +x "$BIN_PATH/bazelisk"

wget -nv -O "$BIN_PATH/bombardier" 'https://github.com/codesenberg/bombardier/releases/download/v1.2.6/bombardier-linux-amd64' \
&& chmod +x "$BIN_PATH/bombardier"

wget -nv -O "$BIN_PATH/fx" 'https://github.com/antonmedv/fx/releases/download/31.0.0/fx_linux_amd64' \
&& chmod +x "$BIN_PATH/fx"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/noahgorstein/jqp/releases/download/v0.5.0/jqp_Linux_x86_64.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/jqp" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/arl/gitmux/releases/download/v0.10.3/gitmux_v0.10.3_linux_amd64.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/gitmux" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/rs/curlie/releases/download/v1.7.2/curlie_1.7.2_linux_amd64.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/curlie" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/jesseduffield/lazydocker/releases/download/v0.23.1/lazydocker_0.23.1_Linux_x86_64.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/lazydocker" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/jesseduffield/lazygit/releases/download/v0.40.2/lazygit_0.40.2_Linux_x86_64.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/lazygit" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/junegunn/fzf/releases/download/0.45.0/fzf-0.45.0-linux_amd64.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$BIN_PATH" \
&& rm "$TEMP_TAR_GZ"

TEMP_ZIP="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_ZIP" 'https://github.com/MordechaiHadad/bob/releases/download/v2.7.0/bob-linux-x86_64.zip' \
&& unzip "$TEMP_ZIP" -d "$TEMP_DIR" \
&& mv "${TEMP_DIR}/bob-linux-x86_64/bob" "$BIN_PATH" \
&& rm -rf "$TEMP_ZIP" "$TEMP_DIR" \
&& chmod +x "$BIN_PATH/bob"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/twpayne/chezmoi/releases/download/v2.42.3/chezmoi_2.42.3_linux-musl_amd64.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/chezmoi" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/arduino/arduino-cli/releases/download/v0.35.0/arduino-cli_0.35.0_Linux_64bit.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/arduino-cli" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/boyter/scc/releases/download/v3.2.0/scc_Linux_x86_64.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/scc" "$BIN_PATH" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

wget -nv -O "$BIN_PATH/websocat" 'https://github.com/vi/websocat/releases/download/v1.12.0/websocat.x86_64-unknown-linux-musl' \
&& chmod +x "$BIN_PATH/websocat"

################ STATIC BUILDS ################

STATIC_PATH=$UTILS_PATH/static
mkdir -p "$STATIC_PATH"

TEMP_TAR_XZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_XZ" 'https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz' \
&& tar -xJf "$TEMP_TAR_XZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/ffmpeg-git-20231229-amd64-static" "$STATIC_PATH/ffmpeg" \
&& rm -rf "$TEMP_TAR_XZ" "$TEMP_DIR"

TEMP_TAR_XZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_XZ" 'https://builder.blender.org/download/daily/blender-4.1.0-alpha+main.98c6bded9844-linux.x86_64-release.tar.xz' \
&& tar -xJf "$TEMP_TAR_XZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/blender-4.1.0-alpha+main.98c6bded9844-linux.x86_64-release" "$STATIC_PATH/blender" \
&& rm -rf "$TEMP_TAR_XZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://renderdoc.org/stable/1.30/renderdoc_1.30.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& mv "${TEMP_DIR}/renderdoc_1.30" "$STATIC_PATH/renderdoc" \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

################ AppImage ################

APP_PATH=$UTILS_PATH/app
mkdir -p "$APP_PATH"

wget -nv -O "$APP_PATH/nvim" 'https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage' \
&& chmod +x "$APP_PATH/nvim"

wget -nv -O "$APP_PATH/helix" 'https://github.com/helix-editor/helix/releases/download/23.10/helix-23.10-x86_64.AppImage' \
&& chmod +x "$APP_PATH/helix"

wget -nv -O "$APP_PATH/magick" 'https://github.com/ImageMagick/ImageMagick/releases/download/7.1.1-24/ImageMagick--clang-x86_64.AppImage' \
&& chmod +x "$APP_PATH/magick"

wget -nv -O "$APP_PATH/openscad" 'https://files.openscad.org/OpenSCAD-2021.01-x86_64.AppImage' \
&& chmod +x "$APP_PATH/openscad"

wget -nv -O "$APP_PATH/arduino-ide" 'https://github.com/arduino/arduino-ide/releases/download/2.2.1/arduino-ide_2.2.1_Linux_64bit.AppImage' \
&& chmod +x "$APP_PATH/arduino-ide"

wget -nv -O "$APP_PATH/audacity" 'https://github.com/audacity/audacity/releases/download/Audacity-3.4.2/audacity-linux-3.4.2-x64.AppImage' \
&& chmod +x "$APP_PATH/audacity"

wget -nv -O "$APP_PATH/cutter" 'https://github.com/rizinorg/cutter/releases/download/v2.3.2/Cutter-v2.3.2-Linux-x86_64.AppImage' \
&& chmod +x "$APP_PATH/cutter"

wget -nv -O "$APP_PATH/freecad" 'https://github.com/FreeCAD/FreeCAD/releases/download/0.21.1/FreeCAD_0.21.1-Linux-x86_64.AppImage' \
&& chmod +x "$APP_PATH/freecad"

wget -nv -O "$APP_PATH/krita" 'https://download.kde.org/stable/krita/5.2.2/krita-5.2.2-x86_64.appimage' \
&& chmod +x "$APP_PATH/krita"

wget -nv -O "$APP_PATH/imhex" 'https://github.com/WerWolv/ImHex/releases/download/v1.32.1/imhex-1.32.1-x86_64.AppImage' \
&& chmod +x "$APP_PATH/imhex"

wget -nv -O "$APP_PATH/inkscape" 'https://inkscape.org/gallery/item/44616/Inkscape-091e20e-x86_64.AppImage' \
&& chmod +x "$APP_PATH/inkscape"

wget -nv -O "$APP_PATH/nuclear" 'https://github.com/nukeop/nuclear/releases/download/v0.6.30/nuclear-v0.6.30.AppImage' \
&& chmod +x "$APP_PATH/nuclear"

################ VS Code / https://open-vsx.org/ ##############

code-server --install-extension alefragnani.Bookmarks #https://github.com/alefragnani/vscode-bookmarks GPL-3
code-server --install-extension amodio.tsl-problem-matcher #https://github.com/eamodio/vscode-tsl-problem-matcher MIT
code-server --install-extension Angular.ng-template #https://github.com/angular/vscode-ng-language-service MIT
code-server --install-extension antfu.iconify #https://github.com/antfu/vscode-iconify MIT
code-server --install-extension anweber.vscode-httpyac #https://github.com/AnWeber/vscode-httpyac MIT
code-server --install-extension arcanis.vscode-zipfs #https://github.com/yarnpkg/berry BSD-2
code-server --install-extension asciidoctor.asciidoctor-vscode #https://github.com/asciidoctor/asciidoctor-vscode MIT
code-server --install-extension astro-build.astro-vscode #https://github.com/astrolang/astro-vscode Apache-2.0
code-server --install-extension BazelBuild.vscode-bazel #https://github.com/bazelbuild/vscode-bazel Apache-2.0
code-server --install-extension bierner.docs-view #https://github.com/mattbierner/vscode-docs-view MIT
code-server --install-extension bmalehorn.vscode-fish #https://github.com/bmalehorn/vscode-fish MIT
code-server --install-extension brunnerh.insert-unicode #https://github.com/brunnerh/insert-unicode MIT
code-server --install-extension caponetto.vscode-diff-viewer #https://github.com/caponetto/vscode-diff-viewer/ MIT
code-server --install-extension Cardinal90.multi-cursor-case-preserve #https://github.com/Cardinal90/multi-cursor-case-preserve MIT
code-server --install-extension charliermarsh.ruff #https://github.com/astral-sh/ruff-vscode MIT
code-server --install-extension christian-kohler.npm-intellisense #https://github.com/ChristianKohler/NpmIntellisense MIT
code-server --install-extension cmoog.sqlnotebook #https://github.com/cmoog/vscode-sql-notebook MIT
code-server --install-extension codechecker.codechecker #https://github.com/Ericsson/CodecheckerVSCodePlugin Apache-2.0
code-server --install-extension cweijan.dbclient-jdbc #https://github.com/database-client/jdbc-adapter-server MIT
code-server --install-extension cweijan.vscode-database-client2 #https://github.com/cweijan/vscode-database-client MIT
code-server --install-extension Dart-Code.dart-code #https://github.com/Dart-Code/Dart-Code MIT
code-server --install-extension Dart-Code.flutter #https://github.com/Dart-Code/Flutter MIT
code-server --install-extension DavidAnson.vscode-markdownlint #https://github.com/DavidAnson/vscode-markdownlint MIT
code-server --install-extension dbaeumer.vscode-eslint #https://github.com/microsoft/vscode-eslint MIT
code-server --install-extension dendron.dendron-markdown-shortcuts #https://github.com/mdickin/vscode-markdown-shortcuts MIT
code-server --install-extension eamodio.gitlens #https://github.com/gitkraken/vscode-gitlens MIT (besides Plus features)
code-server --install-extension esbenp.prettier-vscode #https://github.com/prettier/prettier-vscode MIT
code-server --install-extension espressif.esp-idf-extension #https://github.com/espressif/vscode-esp-idf-extension Apache-2.0
code-server --install-extension exiasr.hadolint #https://github.com/michaellzc/vscode-hadolint MIT
code-server --install-extension fabiospampinato.vscode-todo-plus #https://github.com/fabiospampinato/vscode-todo-plus MIT
code-server --install-extension fernandoescolar.vscode-solution-explorer #https://github.com/fernandoescolar/vscode-solution-explorer MIT
code-server --install-extension formulahendry.code-runner #https://github.com/formulahendry/vscode-code-runner MIT
code-server --install-extension foxundermoon.shell-format #https://github.com/foxundermoon/vs-shell-format MIT
code-server --install-extension fwcd.kotlin #https://github.com/fwcd/vscode-kotlin MIT
code-server --install-extension gera2ld.markmap-vscode #https://github.com/markmap/markmap-vscode MIT
code-server --install-extension GitHub.vscode-pull-request-github #https://github.com/microsoft/vscode-pull-request-github MIT
code-server --install-extension golang.go #https://github.com/golang/vscode-go MIT
code-server --install-extension Gruntfuggly.activitusbar #https://github.com/Gruntfuggly/activitusbar MIT
code-server --install-extension haskell.haskell #https://github.com/haskell/vscode-haskell MIT
code-server --install-extension hediet.vscode-drawio #https://github.com/hediet/vscode-drawio GPL-3
code-server --install-extension hoovercj.vscode-power-mode #https://github.com/hoovercj/vscode-power-mode MIT
code-server --install-extension humao.rest-client #https://github.com/Huachao/vscode-restclient MIT
code-server --install-extension Ionide.Ionide-fsharp #https://github.com/ionide/ionide-vscode-fsharp MIT
code-server --install-extension James-Yu.latex-workshop #https://github.com/James-Yu/LaTeX-Workshop MIT
code-server --install-extension janisdd.vscode-edit-csv #https://github.com/janisdd/vscode-edit-csv MIT
code-server --install-extension jbenden.c-cpp-flylint #https://github.com/jbenden/vscode-c-cpp-flylint MIT
code-server --install-extension jebbs.plantuml #https://github.com/qjebbs/vscode-plantuml MIT
code-server --install-extension josefpihrt-vscode.roslynator #https://github.com/dotnet/roslynator Apache-2.0
code-server --install-extension julialang.language-julia #https://github.com/julia-vscode/julia-vscode MIT
code-server --install-extension justusadam.language-haskell #https://github.com/JustusAdam/language-haskell BSD-3
code-server --install-extension kahole.magit #https://github.com/kahole/edamagit MIT
code-server --install-extension Kelvin.vscode-sshfs #https://github.com/SchoofsKelvin/vscode-sshfs GPL-3
code-server --install-extension langium.langium-vscode #https://github.com/eclipse-langium/langium MIT
code-server --install-extension Leathong.openscad-language-support #https://github.com/Leathong/openscad-support-vscode GPL-3
code-server --install-extension lextudio.restructuredtext #https://github.com/vscode-restructuredtext/vscode-restructuredtext MIT
code-server --install-extension llvm-vs-code-extensions.vscode-clangd #https://github.com/clangd/vscode-clangd MIT
code-server --install-extension LoyieKing.smalise #https://github.com/LoyieKing/Smalise MIT
code-server --install-extension mads-hartmann.bash-ide-vscode #https://github.com/bash-lsp/bash-language-server MIT
code-server --install-extension marp-team.marp-vscode #https://github.com/marp-team/marp-vscode MIT
code-server --install-extension marus25.cortex-debug #https://github.com/Marus/cortex-debug MIT
code-server --install-extension matepek.vscode-catch2-test-adapter #https://github.com/matepek/vscode-catch2-test-adapter MIT
code-server --install-extension mcu-debug.debug-tracker-vscode #https://github.com/mcu-debug/debug-tracker-vscode MIT
code-server --install-extension mcu-debug.memory-view #https://github.com/mcu-debug/memview MIT
code-server --install-extension mcu-debug.peripheral-viewer #https://github.com/mcu-debug/peripheral-viewer MIT
code-server --install-extension mcu-debug.rtos-views #https://github.com/mcu-debug/rtos-views MIT
code-server --install-extension meronz.manpages #https://github.com/meronz/vscode.manpages GPL-3
code-server --install-extension mesonbuild.mesonbuild #https://github.com/mesonbuild/vscode-meson Apache-2.0
code-server --install-extension mgt19937.typst-preview #https://github.com/Enter-tainer/typst-preview MIT
code-server --install-extension mike-lischke.vscode-antlr4 #https://github.com/mike-lischke/vscode-antlr4 MIT
code-server --install-extension mikestead.dotenv #https://github.com/mikestead/vscode-dotenv MIT
code-server --install-extension moshfeu.compare-folders #https://github.com/moshfeu/vscode-compare-folders MIT
code-server --install-extension ms-azuretools.vscode-docker #https://github.com/Microsoft/vscode-docker MIT
code-server --install-extension ms-dotnettools.vscode-dotnet-runtime #https://github.com/dotnet/vscode-dotnet-runtime MIT
code-server --install-extension ms-kubernetes-tools.vscode-kubernetes-tools #https://github.com/vscode-kubernetes-tools/vscode-kubernetes-tools Apache-2.0
code-server --install-extension ms-playwright.playwright #https://github.com/microsoft/playwright Apache-2.0
code-server --install-extension ms-pyright.pyright #https://github.com/microsoft/pyright MIT
code-server --install-extension ms-python.pylint #https://github.com/microsoft/vscode-pylint MIT
code-server --install-extension ms-python.python #https://github.com/microsoft/vscode-python MIT
code-server --install-extension ms-toolsai.jupyter #https://github.com/microsoft/vscode-jupyter MIT
code-server --install-extension ms-toolsai.jupyter-keymap #https://github.com/microsoft/vscode-jupyter-keymap MIT
code-server --install-extension ms-toolsai.jupyter-renderers #https://github.com/Microsoft/vscode-notebook-renderers MIT
code-server --install-extension ms-toolsai.vscode-jupyter-cell-tags #https://github.com/microsoft/vscode-jupyter-cell-tags MIT
code-server --install-extension ms-toolsai.vscode-jupyter-powertoys #https://github.com/microsoft/vscode-jupyter-powertoys MIT
code-server --install-extension ms-toolsai.vscode-jupyter-slideshow #https://github.com/microsoft/vscode-jupyter-slideshow MIT
code-server --install-extension ms-vscode.cmake-tools #https://github.com/microsoft/vscode-cmake-tools MIT
code-server --install-extension ms-vscode.hexeditor #https://github.com/microsoft/vscode-hexeditor MIT
code-server --install-extension ms-vscode.live-server #https://github.com/microsoft/vscode-livepreview MIT
code-server --install-extension ms-vscode.makefile-tools #https://github.com/microsoft/vscode-makefile-tools MIT
code-server --install-extension ms-vscode.mono-debug #https://github.com/microsoft/vscode-mono-debug MIT
code-server --install-extension ms-vscode.powershell #https://github.com/PowerShell/vscode-powershell MIT
code-server --install-extension ms-vscode.vscode-github-issue-notebooks #https://github.com/microsoft/vscode-github-issue-notebooks MIT
code-server --install-extension ms-vscode.vscode-selfhost-test-provider #https://github.com/microsoft/vscode-selfhost-test-provider MIT
code-server --install-extension mshr-h.veriloghdl #https://github.com/mshr-h/vscode-verilog-hdl-support MIT
code-server --install-extension msjsdiag.vscode-react-native #https://github.com/microsoft/vscode-react-native MIT
code-server --install-extension mtxr.sqltools #https://github.com/mtxr/vscode-sqltools MIT
code-server --install-extension muhammad-sammy.csharp #https://github.com/muhammadsammy/free-vscode-csharp MIT
code-server --install-extension Natizyskunk.sftp #https://github.com/Natizyskunk/vscode-sftp MIT
code-server --install-extension nvarner.typst-lsp #https://github.com/nvarner/typst-lsp MIT
code-server --install-extension Orta.vscode-jest #https://github.com/jest-community/vscode-jest MIT
code-server --install-extension peterj.proto #https://github.com/peterj/vscode-protobuf MIT
code-server --install-extension pflannery.vscode-versionlens #https://gitlab.com/versionlens/vscode-versionlens BSD-0
code-server --install-extension pierre-payen.gdb-syntax #https://github.com/pirpyn/gdb-syntax-vscode MIT
code-server --install-extension PKief.material-icon-theme #https://github.com/PKief/vscode-material-icon-theme MIT
code-server --install-extension pranaygp.vscode-css-peek #https://github.com/pranaygp/vscode-css-peek MIT
code-server --install-extension PrateekMahendrakar.prettyxml #https://github.com/pmahend1/PrettyXML MIT
code-server --install-extension qcz.text-power-tools #https://github.com/qcz/vscode-text-power-tools MIT
code-server --install-extension RDebugger.r-debugger #https://github.com/ManuelHentschel/VSCode-R-Debugger MIT
code-server --install-extension redhat.ansible #https://github.com/ansible/vscode-ansible MIT
code-server --install-extension redhat.java #https://github.com/redhat-developer/vscode-java EPL-2.0
code-server --install-extension redhat.vscode-xml #https://github.com/redhat-developer/vscode-xml EPL-2.0
code-server --install-extension redhat.vscode-yaml #https://github.com/redhat-developer/vscode-yaml MIT
code-server --install-extension REditorSupport.r #https://github.com/REditorSupport/vscode-R MIT
code-server --install-extension Remisa.shellman #https://github.com/yousefvand/shellman MIT
code-server --install-extension ritwickdey.LiveServer #https://github.com/ritwickdey/vscode-live-server MIT
code-server --install-extension robocorp.robotframework-lsp #https://github.com/robocorp/robotframework-lsp Apache-2.0
code-server --install-extension rogalmic.bash-debug #https://github.com/rogalmic/vscode-bash-debug MIT
code-server --install-extension rust-lang.rust-analyzer #https://github.com/rust-lang/rust-analyzer MIT
code-server --install-extension ryanluker.vscode-coverage-gutters #https://github.com/ryanluker/vscode-coverage-gutters MIT
code-server --install-extension samuelcolvin.jinjahtml #https://github.com/samuelcolvin/jinjahtml-vscode MIT
code-server --install-extension shd101wyy.markdown-preview-enhanced #https://github.com/shd101wyy/markdown-preview-enhanced UIUC
code-server --install-extension Shopify.ruby-lsp #https://github.com/Shopify/vscode-ruby-lsp MIT
code-server --install-extension sleistner.vscode-fileutils #https://github.com/sleistner/vscode-fileutils MIT
code-server --install-extension sndst00m.vscode-native-svg-preview #https://gitlab.com/SNDST00M/vscode-native-svg-preview MIT
code-server --install-extension SonarSource.sonarlint-vscode #https://github.com/SonarSource/sonarlint-vscode LGPL-3.0
code-server --install-extension sorbet.sorbet-vscode-extension #https://github.com/sorbet/sorbet Apache-2.0
code-server --install-extension stateful.runme #https://github.com/stateful/runme Apache-2.0
code-server --install-extension stkb.rewrap #https://github.com/stkb/Rewrap Apache-2.0
code-server --install-extension streetsidesoftware.code-spell-checker #https://github.com/streetsidesoftware/cspell MIT
code-server --install-extension stylelint.vscode-stylelint #https://github.com/stylelint/vscode-stylelint MIT
code-server --install-extension sumneko.lua #https://github.com/LuaLS/vscode-lua MIT
code-server --install-extension Surendrajat.apklab #https://github.com/APKLab/APKLab AGPL-3.0
code-server --install-extension tamasfe.even-better-toml #https://github.com/tamasfe/taplo MIT
code-server --install-extension teros-technology.teroshdl #https://github.com/TerosTechnology/vscode-terosHDL GPL-3
code-server --install-extension timonwong.shellcheck #https://github.com/vscode-shellcheck/vscode-shellcheck MIT
code-server --install-extension tintoy.msbuild-project-tools #https://github.com/tintoy/msbuild-project-tools-vscode MIT
code-server --install-extension trond-snekvik.simple-rst #https://github.com/trond-snekvik/vscode-rst MIT
code-server --install-extension twxs.cmake #https://github.com/twxs/vs.language.cmake MIT
code-server --install-extension usernamehw.errorlens #https://github.com/usernamehw/vscode-error-lens MIT
code-server --install-extension vadimcn.vscode-lldb #https://github.com/vadimcn/codelldb MIT
code-server --install-extension Vue.volar #https://github.com/vuejs/language-tools MIT
code-server --install-extension vscjava.vscode-java-debug #https://github.com/microsoft/vscode-java-debug MIT
code-server --install-extension vscjava.vscode-java-dependency #https://github.com/Microsoft/vscode-java-dependency MIT
code-server --install-extension vscjava.vscode-java-pack #https://github.com/Microsoft/vscode-java-pack MIT
code-server --install-extension vscjava.vscode-java-test #https://github.com/microsoft/vscode-java-test MIT
code-server --install-extension vscjava.vscode-maven #https://github.com/Microsoft/vscode-maven MIT
code-server --install-extension webfreak.debug #https://github.com/WebFreak001/code-debug Unlicense license
code-server --install-extension YoavBls.pretty-ts-errors #https://github.com/yoavbls/pretty-ts-errors MIT
code-server --install-extension yzhang.markdown-all-in-one #https://github.com/yzhang-gh/vscode-markdown MIT

################ VS Code / Locally built extensions ##############

code-server --install-extension icsharpcode.ilspy-vscode #https://github.com/icsharpcode/ilspy-vscode MIT
code-server --install-extension ms-dotnettools.dotnet-interactive-vscode #https://github.com/dotnet/interactive MIT
code-server --install-extension AykutSarac.jsoncrack-vscode #https://github.com/AykutSarac/jsoncrack-vscode MIT
code-server --install-extension platformio.platformio-ide #https://github.com/platformio/platformio-vscode-ide Apache-2.0
code-server --install-extension nia40m.display-nums #https://github.com/nia40m/vscode-display-nums MIT
code-server --install-extension vscjava.vscode-gradle #https://github.com/microsoft/vscode-gradle MIT
code-server --install-extension eirikpre.systemverilog #https://github.com/eirikpre/VSCode-SystemVerilog MIT
code-server --install-extension dtsvet.vscode-wasm #https://github.com/wasmerio/vscode-wasm MIT

################ SETUP ################

sudo ln -fs /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
sudo dpkg-reconfigure -f noninteractive tzdata
sudo chsh -s /bin/zsh codespace
sudo passwd codespace # interactive, set password for ssh access

# Must be run from bash (not zsh) and in the home directory https://askubuntu.com/a/1159032
cd ~
sudo chown -R codespace:codespace !(repos)
sudo chmod 755 !(repos)

sudo usermod -a -G kvm codespace
sudo usermod -a -G video codespace
sudo usermod -a -G audio codespace
sudo usermod -a -G pipewire codespace
sudo usermod -a -G wireshark codespace
sudo usermod -a -G dialout codespace
sudo usermod -a -G plugdev codespace
sudo usermod -a -G render codespace
sudo usermod -a -G libvirt codespace

# these groups do not exist yet
# sudo usermod -a -G pulse codespace
# sudo usermod -a -G pulse-access codespace
# sudo usermod -a -G cvdnetwork codespace

# Now logout (exit from container) and login again to reload changes.

################ APT ################

export DEBIAN_FRONTEND=noninteractive
sudo wget -nv -O "/usr/share/keyrings/xpra.asc" https://xpra.org/xpra.asc
sudo wget -nv -O "/etc/apt/sources.list.d/xpra.sources" https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/bookworm/xpra.sources
sudo wget -nv -O "/etc/apt/sources.list.d/xpra-beta.sources" https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/bookworm/xpra-beta.sources
sudo apt-get update
sudo apt-get -qq install \
xpra \
mono-complete \
r-base \
r-base-dev \
policykit-1 \
libgtk2.0-0 \
uml-utilities \
gtk-sharp2 \
libc6-dev \
libgtk-3-bin \
screen \
zip \
unzip \
picocom \
minicom \
tshark \
neofetch \
gifsicle \
asciinema \
bmon \
slurm \
tcptrack \
nethogs \
iputils-ping \
traceroute \
inxi \
usbutils \
adb \
glslang-tools \
texinfo \
pandoc \
novnc \
devscripts \
config-package-dev \
debhelper-compat \
golang \
protobuf-c-compiler \
cpio \
iperf \
tzdata \
cpu-checker \
telnet \
netcat-openbsd \
socat \
gdb-multiarch \
htop \
bubblewrap \
python3-pip \
iptables \
iproute2 \
dnsmasq \
net-tools \
ca-certificates \
nftables \
tcpdump \
procps \
xterm \
scons \
libncursesw5 \
python3-sphinx \
eslint \
python3-proselint \
spell \
rubocop \
libelf-dev \
libevent-dev \
ncurses-dev \
build-essential \
bison \
pkg-config \
patchelf \
device-tree-compiler \
flex \
ninja-build \
gperf \
xvfb \
flatpak \
nxagent \
clang \
clang-tidy \
cppcheck \
lzma \
apparmor \
qemu-kvm \
qemu-system-common \
qemu-utils \
libvirt-daemon-system \
libvirt-clients \
libxslt-dev \
libxml2-dev \
libvirt-dev \
zlib1g-dev \
ruby-dev \
ruby-libvirt \
ebtables \
dnsmasq-base \
xfce4 \
xfce4-goodies \
tightvncserver \
gvncviewer \
sysprof \
acpica-tools \
gcovr \
evtest \
nmap \
bwm-ng \
packaging-dev \
debian-keyring \
devscripts \
equivs \
mercurial \
mtools \
git-lfs \
gettext \
uncrustify \
sox \
isc-dhcp-client \
asciidoc \
xutils-dev \
kconfig-frontends \
dfu-util \
evtest \
doxygen \
openocd \
python3-serial \
rlwrap \
srecord \
mosquitto \
mosquitto-clients \
xorg-dev \
v4l-utils \
pulseaudio-utils \
pipewire-audio \
pipewire-audio-client-libraries \
pipewire-libcamera \
pipewire-v4l2 \
qsynth \
qjackctl \
wireplumber \
alsa-utils \
alsa-oss \
alsamixergui \
apulse \
fluidsynth \
fluid-soundfont-gm \
jack-tools \
drumstick-tools \
mpv \
libslirp-dev \
libfuse-dev \
libgtk-3-dev \
libnotify-dev \
libdrumstick-dev \
libasound2 \
libasound2-plugins \
libhidapi-hidraw0 \
libhidapi-libusb0 \
libmpfr-dev \
libisl-dev \
libudev-dev \
libftdi1-2 \
libgpiod2 \
libjaylink0 \
libjim0.81 \
libxapian30 \
libusb-1.0-0-dev \
&& sudo apt-get clean -y && sudo rm -rf /var/lib/apt/lists/*

# gcc-multilib \
# binutils-arm-linux-gnueabi \
# gcc-arm-linux-gnueabi \
# gcc-12-arm-linux-gnueabi \
# gcc-arm-none-eabi \

################ DEB ################

TEMP_DEB="$(mktemp)" \
&& wget -nv -O "$TEMP_DEB" 'https://github.com/coder/code-server/releases/download/v4.23.1/code-server_4.23.1_amd64.deb' \
&& sudo dpkg -i "$TEMP_DEB" \
&& rm -f "$TEMP_DEB"

TEMP_DEB="$(mktemp)" \
&& wget -nv -O "$TEMP_DEB" 'https://releases.hashicorp.com/vagrant/2.3.7/vagrant_2.3.7-1_amd64.deb' \
&& sudo dpkg -i "$TEMP_DEB" \
&& rm -f "$TEMP_DEB"

################ SRC ################

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/tmux/tmux/releases/download/3.4/tmux-3.4.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& cd "${TEMP_DIR}/tmux-3.4" \
&& ./configure && make && sudo make install \
&& cd - \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/jonas/tig/releases/download/tig-2.5.9/tig-2.5.9.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& cd "${TEMP_DIR}/tig-2.5.9" \
&& make prefix=/usr/local && sudo make install prefix=/usr/local \
&& cd - \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TBZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TBZ" 'https://github.com/aristocratos/btop/releases/download/v1.3.2/btop-x86_64-linux-musl.tbz' \
&& tar xvfj "$TEMP_TBZ" -C "$TEMP_DIR" \
&& cd "${TEMP_DIR}/btop" \
&& sudo make install && sudo make setuid \
&& cd - \
&& rm -rf "$TEMP_TBZ" "$TEMP_DIR"

################ DOTFILES ################

sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply mars-low

################ MISC ################

vagrant plugin install vagrant-libvirt \
&& python3 -m pip install --no-cache-dir pynvim

################ FLATPAK ################

LOCAL_FLATPAK_PATH=$UTILS_PATH/flatpak
FLATPAK_HOME=$UTILS_PATH/home/codespace

export FLATPAK_USER_DIR=$LOCAL_FLATPAK_PATH/user
export FLATPAK_SYSTEM_DIR=$LOCAL_FLATPAK_PATH/var/lib
export FLATPAK_SYSTEM_CACHE_DIR=$LOCAL_FLATPAK_PATH/var/tmp
export FLATPAK_CONFIG_DIR=$LOCAL_FLATPAK_PATH/etc
export FLATPAK_RUN_DIR=$LOCAL_FLATPAK_PATH/run

export XDG_DATA_HOME=$FLATPAK_HOME/.local/share
export XDG_CONFIG_HOME=$FLATPAK_HOME/.config
export XDG_CACHE_HOME=$FLATPAK_HOME/.cache

mkdir -p $FLATPAK_CONFIG_DIR $FLATPAK_RUN_DIR $FLATPAK_SYSTEM_CACHE_DIR $FLATPAK_SYSTEM_DIR $FLATPAK_USER_DIR $FLATPAK_SYSTEM_DIR/repo/objects $FLATPAK_SYSTEM_DIR/repo/tmp $XDG_CACHE_HOME $XDG_CONFIG_HOME $XDG_DATA_HOME

sudo tee $FLATPAK_SYSTEM_DIR/repo/config <<EOF
[core]
repo_version=1
mode=bare-user-only
min-free-space-size=500MB
EOF

HOME=$FLATPAK_HOME flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
HOME=$FLATPAK_HOME flatpak install --user org.chromium.Chromium
HOME=$FLATPAK_HOME flatpak install --user com.github.wwmm.easyeffects

HOME=$FLATPAK_HOME dbus-run-session -- flatpak run --user org.chromium.Chromium
HOME=$FLATPAK_HOME flatpak run --user com.github.wwmm.easyeffects