# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# oh-my-posh

eval "$($HOME/.local/bin/oh-my-posh --init --shell bash --config ~/.poshthemes/onehalf.minimal.omp.json)"        

# add .local/bin to path
export PATH=$HOME/.local/bin:$PATH

# $EDITOR=vim
export EDITOR=/usr/bin/vim

# doom emacs bin path
export PATH=$HOME/.config/emacs/bin:$PATH

# .cargo bin path
export PATH=$HOME/.cargo/bin:$PATH

# open org-agenda with neovim
alias andaç="nvim $HOME/andaç"

# supergfxctl alias

alias Integrated="supergfxctl -m Integrated"
alias Hybrid="supergfxctl -m Hybrid"
alias AsusMuxDgpu="supergfxctl -m AsusMuxDgpu"
alias super="supergfxctl"
alias superg="supergfxctl -g"

# asusctl profile alias

alias profile="asusctl profile -p"
alias list-profile="asusctl profile -l"

alias Quiet="asusctl profile -P Quiet"
alias Balanced="asusctl profile -P Balanced"
alias Performance="asusctl profile -P Performance"

