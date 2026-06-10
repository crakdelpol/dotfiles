#!/usr/bin/env bash
# Crea i symlink dei dotfiles verso la home.
# Idempotente: si può rilanciare in sicurezza.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$DOTFILES/$1"
  local dest="$HOME/$2"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "  backup: $dest -> $dest.bak"
    mv "$dest" "$dest.bak"
  fi
  ln -sfn "$src" "$dest"
  echo "  linked: $dest -> $src"
}

echo "Installazione dotfiles da $DOTFILES"

# Claude Code
link "claude/CLAUDE.md" ".claude/CLAUDE.md"

# zsh
link "zsh/.zshrc"        ".zshrc"
link "zsh/.zsh_aliases"  ".zsh_aliases"
link "zsh/.zprofile"     ".zprofile"

# bash
link "bash/.bash_profile" ".bash_profile"

# git
link "git/.gitconfig" ".gitconfig"
link "git/ignore"     ".config/git/ignore"

# vim
link "vim/.vimrc" ".vimrc"

# ghostty
link "ghostty/config" ".config/ghostty/config"

echo "Fatto."
