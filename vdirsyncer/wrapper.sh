#!/bin/bash

# Gnome Keyring'den verileri oku
CID=$(secret-tool lookup application vdirsyncer credential google_client_id)
CSEC=$(secret-tool lookup application vdirsyncer credential google_client_secret)
EMAIL=$(secret-tool lookup application vdirsyncer credential google_email)
HOL_ID=$(secret-tool lookup application vdirsyncer credential google_holiday_id)

# Güvenlik kontrolü
if [ -z "$CID" ] || [ -z "$CSEC" ] || [ -z "$EMAIL" ] || [ -z "$HOL_ID" ]; then
    echo "Hata: Gnome Keyring içerisinden gerekli kimlik bilgileri okunamadı!" >&2
    exit 1
fi

# envsubst için değişkenleri dışa aktar
export GOOGLE_CLIENT_ID="$CID"
export GOOGLE_CLIENT_SECRET="$CSEC"
export GOOGLE_EMAIL="$EMAIL"
export GOOGLE_HOLIDAY_ID="$HOL_ID"

RESOLVED_CONFIG="$HOME/.config/vdirsyncer/.config.resolved"

# Şablonu gerçek değerlerle doldur
envsubst '$GOOGLE_CLIENT_ID $GOOGLE_CLIENT_SECRET $GOOGLE_EMAIL $GOOGLE_HOLIDAY_ID' \
    < "$HOME/.config/vdirsyncer/config" > "$RESOLVED_CONFIG"

# Gerçek vdirsyncer binary'sini çözülmüş config ile çalıştır
exec /usr/bin/vdirsyncer -c "$RESOLVED_CONFIG" "$@"
