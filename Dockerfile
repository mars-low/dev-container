# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.245.2/containers/codespaces-linux/.devcontainer/base.Dockerfile

FROM mcr.microsoft.com/devcontainers/universal:2.4.2-linux

COPY library-scripts/*.sh /tmp/library-scripts/

ENV DOTNET_CLI_TELEMETRY_OPTOUT=1

ENV HOME=/home/codespace \
    SHELL=/usr/bin/zsh

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME="$HOME/.cargo" \
    PATH="$HOME/.cargo/bin:${PATH}"

USER root

# ** Install additional packages. **
RUN export DEBIAN_FRONTEND=noninteractive \ 
    && dpkg --add-architecture i386 \
    && add-apt-repository --yes ppa:kicad/kicad-7.0-releases \
    && apt-get update \
    && bash /tmp/library-scripts/rust-debian.sh "${CARGO_HOME}" "${RUSTUP_HOME}" "${USERNAME}" "true" "true" \
    #  mono
    && apt-get -y install gnupg ca-certificates apt-transport-https software-properties-common \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
    # winehq
    && mkdir -pm755 /etc/apt/keyrings \
    && wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key \
    && wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources \
    # xpra
    && wget -O "/usr/share/keyrings/xpra.asc" https://xpra.org/xpra.asc \
    && wget -O "/etc/apt/sources.list.d/xpra.sources" https://xpra.org/repos/focal/xpra.sources \
    && wget -O "/etc/apt/sources.list.d/xpra-beta.sources" https://xpra.org/repos/focal/xpra-beta.sources

# Add the Microsoft package repository (to install dotnet in the next step)
RUN TEMP_DEB="$(mktemp)" \
    && wget -O "$TEMP_DEB" 'https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb' \
    && dpkg -i "$TEMP_DEB" \
    && rm -f "$TEMP_DEB"

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get -y install mono-complete \
    && apt-get -y install policykit-1 libgtk2.0-0 uml-utilities gtk-sharp2 libc6-dev libgtk-3-bin \
    && apt-get -y install --install-recommends kicad \
    && apt-get -y install --install-recommends winehq-staging \
    && apt-get -y install dotnet-sdk-8.0 dotnet-runtime-6.0 \
    && apt-get -y install xpra \
    && apt-get -y install screen zip unzip \
    && apt-get -y install picocom minicom \
    && apt-get -y install tshark termshark \
    && apt-get -y install bat neofetch ffmpeg gifsicle \
    && apt-get -y install asciinema \
    && apt-get -y install usbutils adb \
    && apt-get -y install glslang-tools texinfo pandoc novnc \
    && apt-get -y install bmon slurm tcptrack nethogs \
    && apt-get -y install config-package-dev debhelper-compat golang \
    && apt-get -y install iputils-ping traceroute inxi \
    && apt-get -y install imagemagick inkscape \
    && apt-get -y install cpio iperf tzdata cpu-checker \
    && apt-get -y install telnet netcat socat \
    && apt-get -y install gdb-multiarch htop \
    && apt-get -y install bubblewrap python3-pip \
    && apt-get -y install iptables iproute2 dnsmasq net-tools ca-certificates nftables tcpdump procps \
    && apt-get -y install xterm scons libncursesw5 python3-sphinx \
    && apt-get -y install eslint python3-proselint shellcheck spell rubocop \
    && apt-get -y install libelf-dev libevent-dev ncurses-dev build-essential bison pkg-config \
    && apt-get -y install patchelf device-tree-compiler flex ninja-build gperf \
    && apt-get -y install gcc-arm-linux-gnueabi binutils-arm-linux-gnueabi \
    && apt-get -y install openscad xvfb flatpak nxagent \
    && apt-get -y install clang clang-tidy cppcheck gcc-multilib lzma \
    && apt-get -y install apparmor qemu qemu-kvm qemu-system-common qemu-utils libvirt-daemon-system libvirt-clients libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev ruby-libvirt ebtables dnsmasq-base \
    && apt-get -y install xfce4 xfce4-goodies tightvncserver \
    && curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly \
    # && wget 'https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.deb' \
    # && apt-get -y install ./nvim-linux64.deb && rm -f ./nvim-linux64.deb \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts

RUN TEMP_DEB="$(mktemp)" \
    && wget -O "$TEMP_DEB" 'https://github.com/coder/code-server/releases/download/v4.20.0/code-server_4.20.0_amd64.deb' \
    && dpkg -i "$TEMP_DEB" \
    && rm -f "$TEMP_DEB"

RUN TEMP_DEB="$(mktemp)" \
    && wget -O "$TEMP_DEB" 'https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/powershell_7.4.0-1.deb_amd64.deb' \
    && dpkg -i "$TEMP_DEB" \
    && rm -f "$TEMP_DEB"

RUN TEMP_DEB="$(mktemp)" \
    && wget -O "$TEMP_DEB" 'https://releases.hashicorp.com/vagrant/2.3.7/vagrant_2.3.7-1_amd64.deb' \
    && dpkg -i "$TEMP_DEB" \
    && rm -f "$TEMP_DEB"

RUN TEMP_DEB="$(mktemp)" \
    && wget -O "$TEMP_DEB" 'https://github.com/dandavison/delta/releases/download/0.13.0/git-delta_0.13.0_amd64.deb' \
    && dpkg -i "$TEMP_DEB" \
    && rm -f "$TEMP_DEB"

RUN TEMP_GZ="$(mktemp)" \
    TEMP_TMUX_DIR="$(mktemp -d)" \
    && wget -O "$TEMP_GZ" 'https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz' \
    && tar -zxf "$TEMP_GZ" -C "$TEMP_TMUX_DIR" \
    && cd "${TEMP_TMUX_DIR}/tmux-3.3a" \
    && ./configure && make && make install \
    && cd - \
    && rm -rf "$TEMP_GZ" "$TEMP_TMUX_DIR"

RUN TEMP_DEB="$(mktemp)" \
    && wget -O "$TEMP_DEB" 'https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb' \
    && dpkg -i "$TEMP_DEB" \
    && rm -f "$TEMP_DEB"

RUN TEMP_TAR="$(mktemp)" \
    TEMP_TIG_DIR="$(mktemp -d)" \
    && wget -O "$TEMP_TAR" 'https://github.com/jonas/tig/releases/download/tig-2.5.8/tig-2.5.8.tar.gz' \
    && tar -zxf "$TEMP_TAR" -C "$TEMP_TIG_DIR" \
    && cd "${TEMP_TIG_DIR}/tig-2.5.8" \
    && make prefix=/usr/local && make install prefix=/usr/local \
    && cd - \
    && rm -rf "$TEMP_TAR" "$TEMP_TIG_DIR"

RUN TEMP_TAR="$(mktemp)" \
    TEMP_BTOP_DIR="$(mktemp -d)" \
    && wget -O "$TEMP_TAR" 'https://github.com/aristocratos/btop/releases/download/v1.2.13/btop-x86_64-linux-musl.tbz' \
    && tar xvfj "$TEMP_TAR" -C "$TEMP_BTOP_DIR" \
    && cd "${TEMP_BTOP_DIR}/btop" \
    && make install && make setuid \
    && cd - \
    && rm -rf "$TEMP_TAR" "$TEMP_BTOP_DIR"

RUN TEMP_DEB="$(mktemp)" \
    && wget -O "$TEMP_DEB" 'https://github.com/muesli/duf/releases/download/v0.8.1/duf_0.8.1_linux_amd64.deb' \
    && dpkg -i "$TEMP_DEB" \
    && rm -f "$TEMP_DEB"

RUN ln -fs /usr/share/zoneinfo/Europe/Warsaw /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata

RUN chown -R codespace:codespace /home/codespace/
RUN chmod 755 /home/codespace/
USER codespace
WORKDIR /home/codespace

# Set dotnet installed with apt as default
ENV PATH="/usr/bin:${PATH}" \
    DOTNET_ROOT="/usr/share/dotnet"

ENV GOPATH="$HOME/go"
RUN go env -w GOPATH=$GOPATH

RUN mkdir -p "$HOME/bin"

RUN TEMP_TAR="$(mktemp)" \
    TEMP_PECO_DIR="$(mktemp -d)" \
    && wget -O "$TEMP_TAR" 'https://github.com/peco/peco/releases/download/v0.5.11/peco_linux_amd64.tar.gz' \
    && tar -zxf "$TEMP_TAR" -C "$TEMP_PECO_DIR" \
    && mv "${TEMP_PECO_DIR}/peco_linux_amd64/peco" "$HOME/bin" \
    && rm -rf "$TEMP_TAR" "$TEMP_PECO_DIR"

RUN TEMP_TAR="$(mktemp)" \
    && wget -O "$TEMP_TAR" 'https://dev.yorhel.nl/download/ncdu-2.2.1-linux-x86_64.tar.gz' \
    && tar -zxf "$TEMP_TAR" -C "$HOME/bin" \
    && rm "$TEMP_TAR"

RUN TEMP_ZIP="$(mktemp)" \
    TEMP_LNAV_DIR="$(mktemp -d)" \
    && wget -O "$TEMP_ZIP" 'https://github.com/tstack/lnav/releases/download/v0.11.1/lnav-0.11.1-x86_64-linux-musl.zip' \
    && unzip -j "$TEMP_ZIP" -d "$TEMP_LNAV_DIR" \
    && mv "${TEMP_LNAV_DIR}/lnav" "$HOME/bin" \
    && rm -rf "$TEMP_ZIP" "$TEMP_LNAV_DIR"

RUN cargo install --locked broot exa starship fd-find navi lsd gitui hyperfine tokei du-dust grex pipr bottom gping kmon zellij despell bob-nvim

RUN go install github.com/jesseduffield/lazygit@latest \
    && go install github.com/jesseduffield/lazydocker@latest \
    && go install github.com/antonmedv/fx@latest \
    && go install github.com/rs/curlie@latest \
    && go install github.com/arl/gitmux@latest \
    && go install github.com/noahgorstein/jqp@latest \
    && go install github.com/apache/mynewt-mcumgr-cli/mcumgr@latest \
    && go install github.com/codesenberg/bombardier@latest \
    && go install github.com/bazelbuild/bazelisk@latest

RUN pipx install r2env \
    && r2env init \
    && r2env add radare2@git

ENV PATH="${PATH}:$HOME/.r2env/versions/radare2@git/bin/"

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

RUN git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf" \
    && $HOME/.fzf/install --no-update-rc --completion --key-bindings

RUN vagrant plugin install vagrant-libvirt
RUN python3 -m pip install virtualenv
RUN python3 -m pip install --user pynvim
RUN bob install v0.9.4 && bob use v0.9.4
