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

# $EDITOR=vim
export EDITOR=/usr/bin/vim

# doom emacs bin path
export PATH=$HOME/.config/emacs/bin:$PATH

# .cargo bin path
export PATH=$HOME/.cargo/bin:$PATH

# go/bin bin path
export PATH=$HOME/go/bin:$PATH

export PATH=$PATH:~/.spoofdpi/bin
export PATH=${PATH}:/usr/local/cuda-13.1/bin

# rofi-tdk database
export DATABASE="$HOME/.local/share/rofi-tdk.tar.gz"

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
  asusctl battery limit "$1"
}

export BAT_THEME="gruvbox-dark"

# bat aliases
alias man="batman"
# export MANPAGER="bat -plman"
# alias grep="batgrep"
# alias diff="batdiff --color"
alias bathelp="bat --plain --language=help --theme $BAT_THEME"

# alias copybara="java -jar $HOME/.local/bin/copybara_deploy.jar"

# git aliases

commit() {
  git commit "$@"
}

push() {
  git push
}

add(){
  git add "$@"
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
  git checkout "$@"
}

branch() {
  git branch "$@"
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

date() {
  if [[ $1 = "YMD" ]]
  then
    /usr/bin/env date +%Y-%m-%d
    return 0
  elif [[ -z "$1" ]]
  then
    /usr/bin/env date +%Y-%m-%dT%H:%M:%S%Z
    return 0
  fi

  echo "Use YMD as option or use without option."
  return 1
}

trace-and-notify() {
  [ -z "$1" ] && echo "Provide PID: 'trace-and-notify 12345'" && return 1
  
  local PID="$1"
  
  # Fetch the name before the process dies
  local PROC_NAME
  if [ -f "/proc/$PID/comm" ]; then
    PROC_NAME=$(cat "/proc/$PID/comm")
  else
    PROC_NAME="Unknown Process"
  fi

  echo "Waiting for $PROC_NAME (PID: $PID) to finish..."

  while kill -0 "$PID" 2>/dev/null; do 
    sleep 1
  done
  
  notify-send "Process Finished" "$PROC_NAME (PID: $PID) has ended or was killed. $(date)"
}

rsync() {
  # --recursive,
  # --partial & --progress,
  # --archive,
  # --verbose
  # --human-readable
  /usr/bin/env rsync -rPavh "$@"
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



eval "$(zoxide init bash)"
