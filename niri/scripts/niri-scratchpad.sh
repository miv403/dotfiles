#!/bin/bash

# Sabit tmux oturum adı
SESSION_NAME="scratchpad"
# Niri penceresini yakalamak için kullanacağımız app-id
APP_ID="scratchpad"

# Eğer terminal olarak Alacritty kullanıyorsan:
TERM_CMD="alacritty -T Scratchpad --class $APP_ID -e tmux new-session -A -s $SESSION_NAME"

# Eğer Foot kullanıyorsan (alternatif):
# TERM_CMD="foot --app-id=$APP_ID tmux new-session -A -s $SESSION_NAME"

# Niri'de şu an bu app-id ile açık bir pencere var mı kontrol et
PID=$(niri msg windows | grep -B 2 "app-id: \"$APP_ID\"" | grep "id:" | awk '{print $2}')

if [ -z "$PID" ]; then
    # Pencere açık değilse, terminali başlat
    # 'tmux new-session -A -s name' komutu: Oturum yoksa açar, varsa var olana bağlanır (attach).
    eval $TERM_CMD &
else
    # Pencere zaten açıksa: Niri'nin toggle-window-floating veya close mantığı çalıştırılabilir.
    # En temiz scratchpad deneyimi için: Görünürse kapat/gizle mantığı.
    # Şimdilik direkt odağı oraya taşımak veya pencereyi kapatmak için:
    niri msg action focus-window --id "$PID" || niri msg action close-window --id "$PID"
fi
