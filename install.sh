#!/usr/bin/env bash
#
# SRPLAYER — instalador
# Uso: sudo ./install.sh
#
# O que este script faz:
#   1. Copia bin/srplayer-motd para /usr/local/bin/srplayer-motd
#   2. Cria o atalho "srplayer" (symlink)
#   3. Registra o painel como MOTD (mensagem de login)
#   4. Desativa (sem apagar) os MOTDs padrão do Ubuntu
#
# Nada aqui é executado via "curl | bash" — clone o repositório,
# leia bin/srplayer-motd e este arquivo antes de rodar com sudo.

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "Este instalador precisa ser executado como root."
    echo "Uso: sudo ./install.sh"
    exit 1
fi

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$DIR/bin/srplayer-motd"
DEST="/usr/local/bin/srplayer-motd"

if [ ! -f "$SRC" ]; then
    echo "Não encontrei $SRC"
    echo "Rode este script a partir da raiz do repositório clonado."
    exit 1
fi

# ------------------------------------------------------------
# Backup da versão atual, se existir
# ------------------------------------------------------------

if [ -f "$DEST" ]; then
    BACKUP="/root/srplayer-motd-backup-$(date +%Y%m%d-%H%M%S)"
    cp "$DEST" "$BACKUP"
    echo "Backup criado: $BACKUP"
fi

# ------------------------------------------------------------
# Instala
# ------------------------------------------------------------

cp "$SRC" "$DEST"
chmod +x "$DEST"

# atalho: basta digitar "srplayer"
ln -sf "$DEST" /usr/local/bin/srplayer

# ------------------------------------------------------------
# MOTD
# ------------------------------------------------------------

cat > /etc/update-motd.d/00-srplayer <<'MOTD'
#!/bin/bash
/usr/local/bin/srplayer-motd
MOTD

chmod +x /etc/update-motd.d/00-srplayer

# Desativa MOTDs antigos, sem apagar
find /etc/update-motd.d/ \
    -type f \
    ! -name '00-srplayer' \
    -exec chmod -x {} \;

# ------------------------------------------------------------
# Teste de sintaxe + execução
# ------------------------------------------------------------

echo
echo "=============================================="
echo "       SRPLAYER INSTALADO"
echo "=============================================="
echo

bash -n "$DEST"
echo "Sintaxe: OK"
echo
echo "Executando painel..."
echo

"$DEST" --no-clear
