# See here for image contents: https://github.com/mars-low/devcontainer

FROM ghcr.io/mars-low/devcontainer:latest

ENV DOTNET_CLI_TELEMETRY_OPTOUT=1 \
    DOTNET_NOLOGO=1

ENV HOME=/home/codespace \
    SHELL=/usr/bin/zsh

ENV CARGO_HOME="$HOME/.cargo" \
    PATH="$HOME/.cargo/bin:${PATH}"

USER root

# ** Install additional packages. **
RUN export DEBIAN_FRONTEND=noninteractive \
    && wget -nv -O "/usr/share/keyrings/xpra.asc" https://xpra.org/xpra.asc \
    && wget -nv -O "/etc/apt/sources.list.d/xpra.sources" https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/bookworm/xpra.sources \
    && wget -nv -O "/etc/apt/sources.list.d/xpra-beta.sources" https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/bookworm/xpra-beta.sources \
    && apt-get update \
    && apt-get -y install xpra \
    && apt-get -y install mono-complete \
    && apt-get -y install policykit-1 libgtk2.0-0 uml-utilities gtk-sharp2 libc6-dev libgtk-3-bin \
    && apt-get -y install screen zip unzip \
    && apt-get -y install picocom minicom \
    && apt-get -y install tshark \
    && apt-get -y install neofetch gifsicle \
    && apt-get -y install asciinema \
    && apt-get -y install usbutils adb \
    && apt-get -y install glslang-tools texinfo pandoc novnc \
    && apt-get -y install bmon slurm tcptrack nethogs \
    && apt-get -y install config-package-dev debhelper-compat golang \
    && apt-get -y install iputils-ping traceroute inxi \
    && apt-get -y install cpio iperf tzdata cpu-checker \
    && apt-get -y install telnet netcat-openbsd socat \
    && apt-get -y install gdb-multiarch htop \
    && apt-get -y install bubblewrap python3-pip \
    && apt-get -y install iptables iproute2 dnsmasq net-tools ca-certificates nftables tcpdump procps \
    && apt-get -y install xterm scons libncursesw5 python3-sphinx \
    && apt-get -y install eslint python3-proselint spell rubocop \
    && apt-get -y install libelf-dev libevent-dev ncurses-dev build-essential bison pkg-config \
    && apt-get -y install patchelf device-tree-compiler flex ninja-build gperf \
    && apt-get -y install gcc-arm-linux-gnueabi binutils-arm-linux-gnueabi \
    && apt-get -y install openscad xvfb flatpak nxagent \
    && apt-get -y install clang clang-tidy cppcheck gcc-multilib lzma \
    && apt-get -y install apparmor qemu-kvm qemu-system-common qemu-utils libvirt-daemon-system libvirt-clients libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev ruby-libvirt ebtables dnsmasq-base \
    && apt-get -y install xfce4 xfce4-goodies tightvncserver \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

RUN TEMP_DEB="$(mktemp)" \
    && wget -nv -O "$TEMP_DEB" 'https://github.com/coder/code-server/releases/download/v4.20.0/code-server_4.20.0_amd64.deb' \
    && dpkg -i "$TEMP_DEB" \
    && rm -f "$TEMP_DEB"

RUN TEMP_DEB="$(mktemp)" \
    && wget -nv -O "$TEMP_DEB" 'https://releases.hashicorp.com/vagrant/2.3.7/vagrant_2.3.7-1_amd64.deb' \
    && dpkg -i "$TEMP_DEB" \
    && rm -f "$TEMP_DEB"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && cd "${TEMP_DIR}/tmux-3.3a" \
    && ./configure && make && make install \
    && cd - \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/jonas/tig/releases/download/tig-2.5.8/tig-2.5.8.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && cd "${TEMP_DIR}/tig-2.5.8" \
    && make prefix=/usr/local && make install prefix=/usr/local \
    && cd - \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_TBZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TBZ" 'https://github.com/aristocratos/btop/releases/download/v1.2.13/btop-x86_64-linux-musl.tbz' \
    && tar xvfj "$TEMP_TBZ" -C "$TEMP_DIR" \
    && cd "${TEMP_DIR}/btop" \
    && make install && make setuid \
    && cd - \
    && rm -rf "$TEMP_TBZ" "$TEMP_DIR"

RUN ln -fs /usr/share/zoneinfo/Europe/Warsaw /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata

# https://github.com/dotnet/runtime/issues/91987#issuecomment-1720233110
# https://github.com/dotnet/runtime/pull/90343#issue-1845914061
RUN rm -rf /tmp/.dotnet/shm/ /tmp/.dotnet/lockfiles/

RUN chown -R codespace:codespace /home/codespace/ && chmod 755 /home/codespace/
USER codespace
WORKDIR /home/codespace

# Set dotnet installed with apt as default
ENV PATH="/usr/bin:${PATH}" \
    DOTNET_ROOT="/usr/share/dotnet"

ENV GO111MODULE=on \
    GOPATH="$HOME/go" \
    PATH="$HOME/go/bin:${PATH}"

RUN go env -w GOPATH="$GOPATH"

RUN pipx install r2env \
    && r2env init \
    && r2env add radare2@git

ENV PATH="${PATH}:$HOME/.r2env/versions/radare2@git/bin/"

RUN git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf" \
    && $HOME/.fzf/install --no-update-rc --completion --key-bindings

RUN vagrant plugin install vagrant-libvirt \
    && python3 -m pip install --no-cache-dir virtualenv pynvim

RUN mkdir -p "$HOME/bin"

RUN wget -nv -O "$HOME/bin/hadolint" 'https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64' \
    && chmod +x "$HOME/bin/hadolint"

RUN TEMP_TAR_XZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_XZ" 'https://github.com/koalaman/shellcheck/releases/download/v0.9.0/shellcheck-v0.9.0.linux.x86_64.tar.xz' \
    && tar -xJf "$TEMP_TAR_XZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/shellcheck-v0.9.0/shellcheck" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_XZ" "$TEMP_DIR"

RUN TEMP_TAR_GZ="$(mktemp)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/cantino/mcfly/releases/download/v0.8.4/mcfly-v0.8.4-x86_64-unknown-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$HOME/bin" \
    && rm "$TEMP_TAR_GZ"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-x86_64-unknown-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/bat-v0.24.0-x86_64-unknown-linux-musl/bat" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/gcla/termshark/releases/download/v2.4.0/termshark_2.4.0_linux_x64.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/termshark_2.4.0_linux_x64/termshark" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/peco/peco/releases/download/v0.5.11/peco_linux_amd64.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/peco_linux_amd64/peco" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_TAR_GZ="$(mktemp)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://dev.yorhel.nl/download/ncdu-2.2.1-linux-x86_64.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$HOME/bin" \
    && rm "$TEMP_TAR_GZ"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/dandavison/delta/releases/download/0.16.5/delta-0.16.5-x86_64-unknown-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/delta-0.16.5-x86_64-unknown-linux-musl/delta" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/BurntSushi/ripgrep/releases/download/14.0.3/ripgrep-14.0.3-x86_64-unknown-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/ripgrep-14.0.3-x86_64-unknown-linux-musl/rg" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/muesli/duf/releases/download/v0.8.1/duf_0.8.1_linux_x86_64.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/duf" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_ZIP="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_ZIP" 'https://github.com/tstack/lnav/releases/download/v0.11.1/lnav-0.11.1-x86_64-linux-musl.zip' \
    && unzip -j "$TEMP_ZIP" -d "$TEMP_DIR" \
    && mv "${TEMP_DIR}/lnav" "$HOME/bin" \
    && rm -rf "$TEMP_ZIP" "$TEMP_DIR"

# https://github.com/bensadeh/despell
RUN cargo install --locked despell

RUN TEMP_ZIP="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_ZIP" 'https://github.com/Canop/broot/releases/download/v1.30.2/broot_1.30.2.zip' \
    && unzip "$TEMP_ZIP" -d "$TEMP_DIR" \
    && mv "${TEMP_DIR}/x86_64-unknown-linux-musl/broot" "$HOME/bin" \
    && rm -rf "$TEMP_ZIP" "$TEMP_DIR"

RUN TEMP_TAR_GZ="$(mktemp)" \
    && wget -nv -nv -O "$TEMP_TAR_GZ" 'https://github.com/eza-community/eza/releases/download/v0.17.0/eza_x86_64-unknown-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$HOME/bin" \
    && rm "$TEMP_TAR_GZ"

RUN TEMP_TAR_GZ="$(mktemp)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/starship/starship/releases/download/v1.17.0/starship-x86_64-unknown-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$HOME/bin" \
    && rm "$TEMP_TAR_GZ"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/sharkdp/fd/releases/download/v9.0.0/fd-v9.0.0-x86_64-unknown-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/fd-v9.0.0-x86_64-unknown-linux-musl/fd" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_TAR_GZ="$(mktemp)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/denisidoro/navi/releases/download/v2.23.0/navi-v2.23.0-x86_64-unknown-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$HOME/bin" \
    && rm "$TEMP_TAR_GZ"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/lsd-rs/lsd/releases/download/v1.0.0/lsd-v1.0.0-x86_64-unknown-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/lsd-v1.0.0-x86_64-unknown-linux-musl/lsd" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_TAR_GZ="$(mktemp)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/extrawurst/gitui/releases/download/v0.24.3/gitui-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$HOME/bin" \
    && rm "$TEMP_TAR_GZ"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/sharkdp/hyperfine/releases/download/v1.18.0/hyperfine-v1.18.0-x86_64-unknown-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/hyperfine-v1.18.0-x86_64-unknown-linux-musl/hyperfine" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_TAR_GZ="$(mktemp)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/XAMPPRocky/tokei/releases/download/v13.0.0-alpha.0/tokei-x86_64-unknown-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$HOME/bin" \
    && rm "$TEMP_TAR_GZ"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/bootandy/dust/releases/download/v0.8.6/dust-v0.8.6-x86_64-unknown-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/dust-v0.8.6-x86_64-unknown-linux-musl/dust" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_TAR_GZ="$(mktemp)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/pemistahl/grex/releases/download/v1.4.4/grex-v1.4.4-x86_64-unknown-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$HOME/bin" \
    && rm "$TEMP_TAR_GZ"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/ClementTsang/bottom/releases/download/0.9.6/bottom_x86_64-unknown-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/btm" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_TAR_GZ="$(mktemp)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/orf/gping/releases/download/gping-v1.16.0/gping-x86_64-unknown-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$HOME/bin" \
    && rm "$TEMP_TAR_GZ"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/orhun/kmon/releases/download/v1.6.4/kmon-1.6.4-x86_64-unknown-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/kmon-1.6.4/kmon" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_TAR_GZ="$(mktemp)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/zellij-org/zellij/releases/download/v0.39.2/zellij-x86_64-unknown-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$HOME/bin" \
    && rm "$TEMP_TAR_GZ"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/chmln/sd/releases/download/v1.0.0/sd-v1.0.0-x86_64-unknown-linux-musl.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/sd-v1.0.0-x86_64-unknown-linux-musl/sd" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_ZIP="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_ZIP" 'https://github.com/MordechaiHadad/bob/releases/download/v2.7.0/bob-linux-x86_64.zip' \
    && unzip "$TEMP_ZIP" -d "$TEMP_DIR" \
    && mv "${TEMP_DIR}/bob-linux-x86_64/bob" "$HOME/bin" \
    && rm -rf "$TEMP_ZIP" "$TEMP_DIR" \
    && chmod +x "$HOME/bin/bob"

# RUN go install github.com/apache/mynewt-mcumgr-cli/mcumgr@latest

RUN wget -nv -O "$HOME/bin/bazelisk" 'https://github.com/bazelbuild/bazelisk/releases/download/v1.19.0/bazelisk-linux-amd64' \
    && chmod +x "$HOME/bin/bazelisk"

RUN wget -nv -O "$HOME/bin/bombardier" 'https://github.com/codesenberg/bombardier/releases/download/v1.2.6/bombardier-linux-amd64' \
    && chmod +x "$HOME/bin/bombardier"

RUN wget -nv -O "$HOME/bin/fx" 'https://github.com/antonmedv/fx/releases/download/31.0.0/fx_linux_amd64' \
    && chmod +x "$HOME/bin/fx"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/noahgorstein/jqp/releases/download/v0.5.0/jqp_Linux_x86_64.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/jqp" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/arl/gitmux/releases/download/v0.10.3/gitmux_v0.10.3_linux_amd64.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/gitmux" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/rs/curlie/releases/download/v1.7.2/curlie_1.7.2_linux_amd64.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/curlie" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/jesseduffield/lazydocker/releases/download/v0.23.1/lazydocker_0.23.1_Linux_x86_64.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/lazydocker" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN TEMP_TAR_GZ="$(mktemp)" \
    TEMP_DIR="$(mktemp -d)" \
    && wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/jesseduffield/lazygit/releases/download/v0.40.2/lazygit_0.40.2_Linux_x86_64.tar.gz' \
    && tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
    && mv "${TEMP_DIR}/lazygit" "$HOME/bin" \
    && rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

RUN pipx install gdbgui \
    && pipx install flawfinder \
    && pipx install lizard \
    && pipx install codechecker \
    && pipx install ptpython \
    && pipx install bpython \
    && pipx install bumble \
    && pipx install meson

RUN dotnet tool install -g dotnet-repl \
    && dotnet tool install -g dotnet-example \ 
    && dotnet tool install -g dotnet-sos \
    && dotnet tool install -g dotnet-dump \
    && dotnet tool install -g dotnet-symbol \ 
    && dotnet tool install -g dotnet-monitor \
    && dotnet tool install -g dotnet-gcdump \
    && dotnet tool install -g dotnet-suggest \
    && dotnet tool install -g dotnet-script \
    && dotnet tool install -g dotnet-counters \ 
    && dotnet tool install -g dotnet-trace \
    && dotnet tool install -g dotnet-ef \
    && dotnet tool install -g minicover \
    && dotnet tool install -g Husky \
    && dotnet tool install -g dotnet-reportgenerator-globaltool \
    && dotnet tool install -g csharprepl \
    && dotnet tool install -g docfx \
    && dotnet tool install -g Roslynator.DotNet.Cli

RUN bob install v0.9.4 && bob use v0.9.4
ENV PATH="${PATH}:$HOME/.local/share/bob/nvim-bin"