#!/bin/bash

# Limpar a tela
clear

# Definir o caminho do arquivo de canais
channels=/tmp/iptv-channels.txt

# Cleanup
if [[ "$1" == "-c" ]]; then
  echo "removendo lista antiga de canais..."
  rm "$channels"
fi

# Mensagem de carregamento
echo "Carregando lista..."

# Verificar se o arquivo de canais existe, caso contrário, criar
if [ ! -f "$channels" ]; then
  curl -s https://ip-tv.app/ | grep -i "copy" | grep -i "https://" | \
  awk -F '(' '{print $2}' | awk -F ',' '{gsub(/'\''/, ""); print $1}' > "$channels"
fi

echo "Carregando todos os canais..."
vlc --fullscreen --random --nofile-logging "$channels"
