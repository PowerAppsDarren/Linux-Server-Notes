# Neovim

Neovim is a modern, extensible text editor that builds upon the legacy of Vim, offering a more powerful and flexible environment for developers. It supports plugins, asynchronous execution, and has a vibrant community contributing to its ecosystem.

- [https://neovim.io/](Neovim): A highly extensible text editor that is a fork of Vim, designed for modern development workflows.
  - [Neovim in 100 Seconds](https://youtu.be/c4OyfL5o7DU)
  - [Official Install Guide](https://github.com/neovim/neovim/blob/master/INSTALL.md)
  - Installation: `sudo apt install neovim`

```bash
# =======================================================================
# Install Neovim on Ubuntu
# The Releases page provides pre-built binaries for Linux systems.
#
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
#
# =======================================================================
# To expose nvim globally
mkdir -p /opt/nvim
mv nvim-linux-x86_64.appimage /opt/nvim/nvim
# =======================================================================
# Add Neovim to PATH (To expose nvim globally)
# Then add this to your shell config (~/.bashrc, ~/.zshrc, ...):
export PATH="$PATH:/opt/nvim/"
#
# =======================================================================
mkdir -p /opt/nvim
mv nvim-linux-x86_64.appimage /opt/nvim/nvim
