#!/usr/bin/env bash

ENTRY=$(fuzzel --dmenu --prompt="🧠 Enter Note: " --width=50)

# Görünmez boşlukları temizle
ENTRY=$(echo "$ENTRY" | xargs)

# Girdi boşsa veya ESC'ye basıldıysa Emacs'e hiç dokunmadan çık
if [[ -z "$ENTRY" ]]; then
    exit 0
fi

# Emacsclient ile girdiyi string olarak iletiyoruz. 
# x-escape ve tırnak sorunlarını önlemek için tek satırlık temiz Elisp:
emacsclient --eval "(org-capture-string \"$ENTRY\" \"f\")" > /dev/null 2>&1

notify-send "Not Saved" "$ENTRY" -i org.gnu.emacs
