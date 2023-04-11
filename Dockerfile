# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.245.2/containers/codespaces-linux/.devcontainer/base.Dockerfile

FROM mcr.microsoft.com/vscode/devcontainers/universal:2-focal

COPY library-scripts/*.sh /tmp/library-scripts/
# ** Install additional packages. **
USER root

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && bash /tmp/library-scripts/rust-debian.sh "${CARGO_HOME}" "${RUSTUP_HOME}" "${USERNAME}" "true" "true" \
    && apt-get -y install gnupg ca-certificates \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
    && apt-get update \
    && apt-get -y install mono-complete \
    && apt-get -y install policykit-1 libgtk2.0-0 uml-utilities gtk-sharp2 libc6-dev \
    && apt-get -y install screen zip unzip \
    && apt-get -y install picocom minicom \
    && apt-get -y install tshark termshark \
    && apt-get -y install fzf bat neofetch \
    && apt-get -y install asciinema \
    && apt-get -y install telnet netcat socat \
    && apt-get -y install gdb-multiarch htop \
    && apt-get -y install bubblewrap \
    && apt-get -y install libelf-dev libevent-dev ncurses-dev build-essential bison pkg-config \
    && curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly \
    && wget 'https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.deb' \
    && apt-get -y install ./nvim-linux64.deb && rm -f ./nvim-linux64.deb \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts

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
# These do not need sudo access to install

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    HOME=/home/codespace \
    SHELL=/usr/bin/zsh
RUN cargo install --locked broot exa starship fd-find navi lsd gitui hyperfine tokei du-dust grex pipr bottom gping below kmon

RUN go install github.com/jesseduffield/lazygit@latest \
    && go install github.com/jesseduffield/lazydocker@latest \
    && go install github.com/bensadeh/despell@latest \
    && go install github.com/antonmedv/fx@latest \
    && go install github.com/rs/curlie@latest \
    && go install github.com/arl/gitmux@latest \
    && go install github.com/noahgorstein/jqp@latest \
    && go install github.com/apache/mynewt-mcumgr-cli/mcumgr@latest \
    && go install github.com/bazelbuild/bazelisk@latest

RUN pipx install r2env \
    && r2env init \
    && r2env add radare2@git

RUN pipx install gdbgui ptpython bpython

RUN dotnet tool install -g dotnet-repl \
    dotnet tool install -g dotnet-example \ 
    dotnet tool install -g dotnet-sos \
    dotnet tool install -g dotnet-dump \
    dotnet tool install -g dotnet-symbol \ 
    dotnet tool install -g dotnet-monitor \
    dotnet tool install -g dotnet-gcdump \
    dotnet tool install -g dotnet-suggest \
    dotnet tool install -g dotnet-script \
    dotnet tool install -g dotnet-counters \ 
    dotnet tool install -g dotnet-trace \
    dotnet tool install -g csharprepl

RUN mkdir -p "$HOME/bin"

RUN TEMP_TAR="$(mktemp)" \
    TEMP_PECO_DIR="$(mktemp -d)" \
    && wget -O "$TEMP_TAR" 'https://github.com/peco/peco/releases/download/v0.5.11/peco_linux_amd64.tar.gz' \
    && tar -zxf "$TEMP_TAR" -C "$TEMP_PECO_DIR" \
    && mv "${TEMP_PECO_DIR}/peco" "$HOME/bin" \
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

# RUN wget https://github.com/Kitware/CMake/releases/download/v3.25.2/cmake-3.25.2-linux-x86_64.sh \
    # && chmod +x cmake-3.25.2-linux-x86_64.sh \
    # && ./cmake-3.25.2-linux-x86_64.sh --skip-license --include-subdir \
    # && rm -f cmake-3.25.2-linux-x86_64.sh

RUN chown -R codespace:codespace /home/codespace/
RUN chmod 755 /home/codespace/
USER codespace
WORKDIR /home/codespace

RUN pip3 install --user pynvim

ENV PATH="${PATH}:$HOME/.r2env/versions/radare2@git/bin/"

