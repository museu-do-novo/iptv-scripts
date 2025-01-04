#!/bin/bash

# Limpar a tela
clear

# Definir o caminho do arquivo de canais
channels=/tmp/iptv-channels.txt

# Mensagem de carregamento
echo "Carregando lista..."

# Verificar se o arquivo de canais existe, caso contrário, criar
if [ ! -f "$channels" ]; then
  curl -s https://ip-tv.app/ | grep -i "copy" | grep -i "https://" | \
  awk -F '(' '{print $2}' | awk -F ',' '{gsub(/'\''/, ""); print $1}' > "$channels"
fi

# Selecionar e abrir links aleatórios
shuf "$channels" | while read -r link; do
  clear
  cat $channels
  echo "Abrindo $link..."
  vlc --fullscreen --random "$link"
done
