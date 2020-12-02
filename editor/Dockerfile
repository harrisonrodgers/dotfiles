FROM ubuntu:18.04

ENV LC_ALL=C.UTF-8 LANG=C.UTF-8

# Undo all the minimification stuff (e.g. get man pages back)
RUN yes | unminimize

# Install stuff required for subsequent steps, and more man page stuff
RUN apt-get update \
    && apt-get -y install sudo gcc git openssh-client man-db git-man manpages manpages-dev manpages-posix manpages-posix-dev plantuml tzdata curl gawk ncurses-term \
    && apt-get -y autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log

# Miniconda
RUN curl -SsLo miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && sh miniconda.sh -bfp /opt/conda/ \
    && rm miniconda.sh \
    && /opt/conda/bin/conda clean --all --yes \
    # configure conda channels and settings
    && /opt/conda/bin/conda config --set show_channel_urls True \
    && /opt/conda/bin/conda config --set anaconda_upload False \
    && /opt/conda/bin/conda config --set auto_update_conda False \
    && /opt/conda/bin/conda config --set report_errors False \
    # prompt already shows this for me
    && /opt/conda/bin/conda config --set changeps1 False \
    # make the .condarc a system level configuration
    && mv /root/.condarc /opt/conda/ \
    && /opt/conda/bin/conda install -y "conda>=4.9.2,4.9.*" python=3.6.8 \
    # clean conda to reduce image bloat
    && /opt/conda/bin/conda clean --all --yes \
    # give other users ability to use root conda
    && mkdir /.conda \
    && chmod 777 /.conda

# Docker in Docker
RUN apt-get update \
    && apt-get -y install git docker.io \
    && mkdir /.docker \
    && chmod 777 /.docker \
    && apt-get -y autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log

# User
ENV USER=harrison.rodgers \
    GROUP=harrison.rodgers \
    UID=501211 \
    GID=1001
ENV HOME=/home/$USER
RUN groupadd -g $GID $GROUP \
    && useradd -u $UID -g $GID -d $HOME -s /bin/sh $USER --create-home -k /dev/null \
    # password-less sudo inside the container
    && echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
#   && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER

USER $UID:$GID
WORKDIR $HOME

# Nix
ENV PATH=$HOME/.nix-profile/bin:$PATH \
    NIXPKGS_ALLOW_UNFREE=1
RUN curl -L https://nixos.org/nix/install | sh \
    && nix-channel --update \
    && nix-env -iA \
# reference
    # nixpkgs.man \
    # nixpkgs.manpages \
    # nixpkgs.posix_man_pages \
# shell
    nixpkgs.zsh \
# prompt
    nixpkgs.starship \
# multiplexer
    nixpkgs.tmux \
# nvim-lsp
    nixpkgs.nodejs \
# python
    # nixpkgs.python27Full \
    # nixpkgs.python37Full \
# editor
    nixpkgs.neovim  \
# misc
    # nixpkgs.git \
    nixpkgs.fzf \
    nixpkgs.ripgrep \
    nixpkgs.ripgrep-all \
    nixpkgs.fd \
    nixpkgs.tree \
    nixpkgs.bat \
    nixpkgs.exa \
    nixpkgs.lnav \
    nixpkgs.less \
# cleanup
    && nix-env -u \
    && nix-env --delete-generations old \
    && nix-store --gc \
    && nix-store --optimize \
    && nix-store --verify --check-contents

# Vim
COPY --chown=$UID:$GID ["plug.vim", "${HOME}/.config/nvim/"]
COPY --chown=$UID:$GID ["init.vim", "${HOME}/.config/nvim/"]

COPY --chown=$UID:$GID ["lsp.vim", "${HOME}/.config/nvim/"]

COPY --chown=$UID:$GID ["coc.vim", "${HOME}/.config/nvim/"]
COPY --chown=$UID:$GID ["coc-settings.json", "${HOME}/.config/coc/"]
COPY --chown=$UID:$GID ["python", "${HOME}/.config/nvim/"]
COPY --chown=$UID:$GID ["isort", "${HOME}/.config/nvim/"]

# nvim npm and yarn for coc
ENV PATH=$HOME/.npm-packages/bin:$PATH
RUN  echo 'prefix=~/.npm-packages' > $HOME/.npmrc \
    && npm install -g neovim yarn  \
    && npm cache clean --force \
    && rm -r $HOME/.npm

# Vim
RUN mkdir -p $HOME/.local/share/nvim/site/autoload \
    && curl -o $HOME/.local/share/nvim/site/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    && nvim --headless -u "${HOME}/.config/nvim/plug.vim" -c "PlugInstall" -c "qa"
# nvim-lsp jsonls (use ; to not fail on npm warnings)
    #&& nvim --headless -c "LspInstall jsonls" -c "qa" ; \
# nvim-lsp yamlls (use ; to not fail on npm warnings)
    #nvim --headless -c "LspInstall yamlls" -c "qa" ; \
# nvim-lsp pyls (all + extras)
    # sudo pip3 install 'python-language-server[all]' pyls-mypy pyls-isort pyls-black \
# nvim provider python3
    # && sudo pip3 install neovim

# Man & Completion (update DBs after all the above installs)
RUN sudo mandb --create


# Python development stuff
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTEST_ADDOPTS="-p no:cacheprovider"

# Shell
ENV ZDOTDIR=$HOME/.config/zsh \
    ZPLUG_HOME=/home/harrison.rodgers/.config/zsh/zplug
RUN git clone https://github.com/zplug/zplug $HOME/.config/zsh/zplug
COPY --chown=$UID:$GID ["zshrc", "${HOME}/.config/zsh/.zshrc"]
COPY --chown=$UID:$GID ["profile", "${HOME}/.profile"]
COPY --chown=$UID:$GID ["bashrc", "${HOME}/.bashrc"]
COPY --chown=$UID:$GID ["bash_profile", "${HOME}/.bash_profile"]

# FZF
COPY --chown=$UID:$GID ["completion.zsh", "${HOME}/.config/zsh/fzf/completion.zsh"]
COPY --chown=$UID:$GID ["key-bindings.zsh", "${HOME}/.config/zsh/fzf/key-bindings.zsh"]

# Prompt
COPY --chown=$UID:$GID ["starship.toml", "${HOME}/.config/starship/"]

# Multiplexer
COPY --chown=$UID:$GID ["tmux.conf", "${HOME}/.config/tmux/"]

# Lnav
COPY --chown=$UID:$GID ["lnav", "${HOME}/.lnav/config.json"]

# Bat
COPY --chown=$UID:$GID ["bat", "${HOME}/.config/bat/config"]

# Testing
COPY --chown=$UID:$GID ["flatwhite.vim", "${HOME}/.config/nvim/colors/"]

# TERM ouside of tmux (important even to tmux which does read it)
ENV TERM=xterm-256color

RUN sudo apt-get remove -y python3 python3.6 python3.6-minimal

CMD ["tmux"]
