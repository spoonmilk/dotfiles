#!/bin/bash

# Define the dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"

# Array of files and directories to symlink
declare -A FILES_TO_SYMLINK=(
  ["$DOTFILES_DIR/kitty"]="$HOME/.config/kitty"
  ["$DOTFILES_DIR/lazygit"]="$HOME/.config/lazygit"
  ["$DOTFILES_DIR/nvim"]="$HOME/.config/nvim"
  ["$DOTFILES_DIR/.tmux"]="$HOME/.tmux"
  ["$DOTFILES_DIR/.tmux.conf"]="$HOME/.tmux.conf"
  ["$DOTFILES_DIR/starship.toml"]="$HOME/.config/starship.toml"
)

# Function to create symlinks
create_symlinks() {
  for src in "${!FILES_TO_SYMLINK[@]}"; do
    dest="${FILES_TO_SYMLINK[$src]}"

    # Create parent directories if they don't exist
    mkdir -p "$(dirname "$dest")"

    # Remove existing files/directories
    if [ -e "$dest" ]; then
      echo "Removing existing file or directory at $dest"
      rm -rf "$dest"
    fi

    # Create the symlink
    ln -s "$src" "$dest"
    echo "Symlinked $src to $dest"
  done
}

# Run the symlink creation
create_symlinks

echo "Dotfiles have been installed successfully!"
