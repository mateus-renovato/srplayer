# SRPLAYER

Painel de boas-vindas (MOTD) para servidores Ubuntu/Debian. Mostra, a cada
login via SSH, um resumo visual do estado da máquina: CPU (total e por
núcleo), RAM, swap, disco, rede, temperatura, serviços, containers Docker e
atualizações pendentes.

```
┌────────────────────────────────────┐      ┌────────────────────────────────────┐
│ SISTEMA                            │      │ RECURSOS                            │
├────────────────────────────────────┤      ├────────────────────────────────────┤
│ OS        : Ubuntu 24.04 LTS       │      │ CPU   : [████████░░░░░░]  57%       │
│ Kernel    : 6.8.0-45-generic       │      │ RAM   : [██████░░░░░░░░]  41%       │
│ Uptime    : 12 dias, 4 horas       │      │ DISCO : [███░░░░░░░░░░░]  19%       │
└────────────────────────────────────┘      └────────────────────────────────────┘
```

Depois de instalado, o painel também fica disponível a qualquer momento
digitando `srplayer` no terminal.

## Requisitos

- Ubuntu ou Debian com `systemd`
- `bash` 4+
- Opcional (detectado automaticamente se presente): `docker`, `nginx`,
  `apache2`, `ufw`, sensores de temperatura via `hwmon`/`thermal_zone`

## Instalação

```bash
git clone https://github.com/SEU-USUARIO/srplayer.git
cd srplayer
sudo ./install.sh
```

O instalador **não** roda como `curl | bash` — clone o repositório e leia
`bin/srplayer-motd` e `install.sh` antes de executar com `sudo`, já que o
script precisa de privilégios de root para escrever em `/usr/local/bin` e
`/etc/update-motd.d`.

O que a instalação faz:

1. Copia `bin/srplayer-motd` para `/usr/local/bin/srplayer-motd`
2. Cria o atalho `srplayer` (symlink)
3. Registra o painel como MOTD (`/etc/update-motd.d/00-srplayer`)
4. Desativa — sem apagar — os MOTDs padrão do Ubuntu
5. Faz backup de qualquer instalação anterior em `/root/`

## Desinstalação

```bash
sudo ./uninstall.sh
```

Remove os arquivos instalados e reativa os MOTDs padrão do Ubuntu.

## Estrutura

```
srplayer/
├── bin/
│   └── srplayer-motd   # o script do painel em si
├── install.sh          # instalador
├── uninstall.sh         # desinstalador
├── LICENSE
└── README.md
```

## Licença

MIT — veja [LICENSE](LICENSE).
