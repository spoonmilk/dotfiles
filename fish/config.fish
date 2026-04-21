# User specific environment
set -gx EDITOR "nvim"
set -gx VISUAL "nvim"

# CUDA Environment Variables
set -gx CUDAHOSTCXX /usr/bin/g++-14
set -gx CC /usr/bin/gcc-14
set -gx CXX /usr/bin/g++-14
set -gx NVCC_CCBIN /usr/bin/g++-14

set -p CPATH /usr/include/openmpi-x86_64
set -p CPATH /usr/local/cuda-12.9/targets/x86_64-linux/include
set -p LD_LIBRARY_PATH /usr/local/cuda-12.9/targets/x86_64-linux/lib

set -gx SDKMAN_DIR "$HOME/.sdkman"

# Path stuff
fish_add_path $HOME/.local/bin
fish_add_path $HOME/bin
fish_add_path /usr/lib64/openmpi/bin
fish_add_path /usr/local/cuda-12.9/bin
fish_add_path /home/spoonmilk/Applications/WebStorm-251.26927.40/bin
fish_add_path /home/spoonmilk/scripts
fish_add_path /home/spoonmilk/.opencode/bin
fish_add_path /usr/local/go/bin
fish_add_path /home/spoonmilk/.config/herd-lite/bin

alias zed 'flatpak run dev.zed.Zed'
alias nvim-new 'env NVIM_APPNAME="nvim-new" nvim'
alias nvim-old 'env NVIM_APPNAME="nvim-old" nvim'
alias hws 'hws.sh'
alias ls 'eza'
alias Sioyek 'si'
alias gram 'flatpak run app.liten.Gram'

# Yazi integration to cd on quit
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

# Ncspot flatpak runner
function ns
    flatpak run io.github.hrkfdn.ncspot
end

# Source user-specific scripts (equivalent to ~/.bashrc.d)
if test -d ~/.config/fish/conf.d
    for rc in ~/.config/fish/conf.d/*.fish
        if test -f "$rc"
            source "$rc"
        end
    end
end

# GHCup
if test -f "$HOME/.ghcup/env"
    bass source "$HOME/.ghcup/env"
end

# SDKMAN
if test -s "$HOME/.sdkman/bin/sdkman-init.sh"
    bass source "$HOME/.sdkman/bin/sdkman-init.sh"
end

# LEAN 4
if test -s "$HOME/.elan/env"
    bass source "$HOME/.elan/env"
end

if status is-interactive
    starship init fish | source
    zoxide init fish | source
    atuin init fish | source
end

fish_add_path /home/spoonmilk/.spicetify

# pnpm
set -gx PNPM_HOME "/home/spoonmilk/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
