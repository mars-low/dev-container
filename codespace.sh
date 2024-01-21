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
&& pipx install git+https://github.com/randy3k/radian \
&& pipx install r2env \
&& r2env init \
&& r2env add radare2@git

# pipx install bumble

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

################ MISC ################

vagrant plugin install vagrant-libvirt \
&& python3 -m pip install --no-cache-dir pynvim
