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

# go/bin bin path
export PATH=$HOME/go/bin:$PATH

# alias stajnvim="cd $HOME/programming/staj/esp32-mpu9520/ && nvim ."
# alias staj="cd $HOME/programming/staj/"

# open org-agenda with neovim
alias andaç="nvim $HOME/andaç"

# supergfxctl alias

alias Integrated="supergfxctl -m Integrated"
alias Hybrid="supergfxctl -m Hybrid"
alias AsusMuxDgpu="supergfxctl -m AsusMuxDgpu"
alias super="supergfxctl"
alias superg="supergfxctl -g"

# asusctl profile alias

alias profile="asusctl profile get"
alias list-profile="asusctl profile list"

alias Quiet="asusctl profile set Quiet"
alias Balanced="asusctl profile set Balanced"
alias Performance="asusctl profile set Performance"
alias oneshot="asusctl battery oneshot"
alias batinfo="asusctl battery info"

limit() {
  asusctl battery limit $1
}

# bat aliases

alias man="batman"
# alias grep="batgrep"
# alias diff="batdiff --color"

export PATH=$PATH:~/.spoofdpi/bin
export PATH=${PATH}:/usr/local/cuda-13.1/bin

# ysa() {
#   cd "$HOME/workspace/ysa/$1"
# }

# git aliases

commit() {
  git commit "$1" "$2"
}

push() {
  git push
}

add(){
  git add $@
}

init() {
  git init
}

fetch() {
  git fetch
}

status() {
  git status
}

checkout() {
  git checkout "$1"
}

branch() {
  git branch "$1"
}

wg-nl() {
  sudo wg-quick up NL-FREE-216
}
wg-down() {
 sudo wg-quick down NL-FREE-216
}

warp() {
  warp-cli connect
  sleep 0.2
  curl https://www.cloudflare.com/cdn-cgi/trace/
}
warp-disconnect() {
  warp-cli disconnect
  sleep 0.2
  curl https://www.cloudflare.com/cdn-cgi/trace/
}

obsidian() {
    local host_sock="/run/user/$(id -u)/.obsidian-cli.sock"
    local flatpak_sock="/run/user/$(id -u)/.flatpak/md.obsidian.Obsidian/xdg-run/.obsidian-cli.sock"

    # Symlink the sandboxed socket to the host location if it exists
    if [ -S "$flatpak_sock" ]; then
        ln -sf "$flatpak_sock" "$host_sock"
    fi

    # Call the flatpak application directly, passing all arguments ($@)
    flatpak run md.obsidian.Obsidian "$@"
}

antigravity-ide() {
  ( /opt/antigravity-ide/antigravity-ide "$@"  >/dev/null 2>&1 & )
}

vdirsyncer() {
    ~/.config/vdirsyncer/wrapper.sh "$@"
}

# ssh agent socket
# Dynamically import SSH socket from the user systemd environment
# if systemctl --user is-active --quiet ssh-agent; then
#     export SSH_AUTH_SOCK=$(systemctl --user show-environment | grep '^SSH_AUTH_SOCK=' | cut -d= -f2)
# fi

# Define the standard systemd ssh-agent socket path
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

# Check if the systemd socket file exists and is active
if [ -S "$SSH_AUTH_SOCK" ]; then
    # If the agent doesn't have keys loaded yet, find and add the first valid key
    if ! ssh-add -l >/dev/null 2>&1; then
        # Search ~/.ssh for any valid private OpenSSH/RSA/ED25519 key file
        local_key=$(find ~/.ssh -maxdepth 1 -type f ! -name "*.pub" ! -name "config" -exec grep -l "PRIVATE KEY" {} \+ | head -n 1)
        
        if [ -n "$local_key" ]; then
            ssh-add "$local_key" 2>/dev/null
        fi
    fi
fi

