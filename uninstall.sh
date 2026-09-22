#!/usr/bin/env bash
#
# SRPLAYER — desinstalador
# Uso: sudo ./uninstall.sh

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "Este desinstalador precisa ser executado como root."
    echo "Uso: sudo ./uninstall.sh"
    exit 1
fi

rm -f /usr/local/bin/srplayer-motd
rm -f /usr/local/bin/srplayer
rm -f /etc/update-motd.d/00-srplayer

# Reativa os MOTDs padrão do Ubuntu que o SRPLAYER havia desativado
if [ -d /etc/update-motd.d ]; then
    chmod +x /etc/update-motd.d/* 2>/dev/null || true
fi

echo "SRPLAYER removido. Os MOTDs padrão do Ubuntu foram reativados."
