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
    && apt-get -y install xvfb flatpak nxagent \
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