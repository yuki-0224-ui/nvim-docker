# Use the official Arch Linux image as a parent image
FROM --platform=linux/amd64 archlinux:latest

# Update the system and install necessary packages
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    base-devel \
    git \
    neovim \
    nodejs \
    npm \
    curl \
    unzip \
    fish

# Install Deno
RUN curl -fsSL https://deno.land/x/install/install.sh | sh
ENV DENO_INSTALL="/root/.deno"
ENV PATH="$DENO_INSTALL/bin:$PATH"

# Set up Neovim configuration directory
RUN mkdir -p ~/.config/

# Install dpp.vim and related plugins
RUN mkdir -p ~/.cache/dpp/repos/github.com/Shougo ~/.cache/dpp/repos/github.com/vim-denops && \
    cd ~/.cache/dpp/repos/github.com/Shougo && \
    git clone https://github.com/Shougo/dpp.vim && \
    git clone https://github.com/Shougo/dpp-ext-installer && \
    git clone https://github.com/Shougo/dpp-protocol-git && \
    git clone https://github.com/Shougo/dpp-ext-lazy && \
    git clone https://github.com/Shougo/dpp-ext-toml && \
    cd ~/.cache/dpp/repos/github.com/vim-denops && \
    git clone https://github.com/vim-denops/denops.vim

RUN chsh -s /usr/bin/fish

# Set working directory
WORKDIR /workspace
