#!/bin/bash

# Limpar a tela
clear

# Definir o caminho do arquivo de canais
channels=$TMPDIR/iptv-channels.txt

# Cleanup
if [[ "$1" == "-c" ]]; then
  echo "Removendo lista antiga de canais..."
  rm "$channels"
fi

# Mensagem de carregamento
echo "Carregando lista..."

# Verificar se o arquivo de canais existe, caso contrário, criar
if [ ! -f "$channels" ]; then
  curl -s https://ip-tv.app/ | grep -i "copy" | grep -i "https://" | \
  awk -F '(' '{print $2}' | awk -F ',' '{gsub(/'\''/, ""); print $1}' > "$channels"
fi

# Verificar se o argumento -a foi passado
if [[ "$1" == "-a" ]]; then
  echo "Abrindo todos os canais no VLC via 'am'..."
  while read -r channel; do
    am start -a android.intent.action.VIEW -d "$channel" -n "org.videolan.vlc/.gui.video.VideoPlayerActivity"
    sleep 1 # Pausa entre os comandos para evitar sobrecarga
  done < "$channels"
else
  echo "Carregando todos os canais no VLC (modo padrão)..."
  vlc --fullscreen --random --nofile-logging "$channels"
fi
