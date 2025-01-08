#!/bin/bash

# Limpar a tela
clear

# Definir o caminho do arquivo de canais
channels=$TMPDIR/iptv-channels.txt

# Cleanup (limpar lista antiga, se solicitado)
if [[ "$1" == "-c" ]]; then
  echo "Removendo lista antiga de canais..."
  rm "$channels"
fi

# Baixar ou usar uma lista de canais existente
if [ ! -f "$channels" ]; then
  echo "Baixando lista de canais..."
  curl -s https://ip-tv.app/ | grep -i "copy" | grep -i "https://" | \
  awk -F '(' '{print $2}' | awk -F ',' '{gsub(/'\''/, ""); print $1}' > "$channels"
fi

# Verificar se a lista está vazia
if [ ! -s "$channels" ]; then
  echo "Erro: Nenhum canal encontrado. Verifique a fonte ou a conexão."
  exit 1
fi

# Função para exibir o menu
function show_menu() {
  clear
  echo "========= MENU DE CANAIS ========="
  echo "Selecione um canal para abrir no VLC:"
  local index=1
  while IFS= read -r line; do
    echo "$index) $line"
    index=$((index + 1))
  done < "$channels"
  echo "0) Sair"
  echo "=================================="
}

# Loop infinito para o menu
while true; do
  show_menu
  read -p "Escolha uma opção: " choice

  if [[ "$choice" == "0" ]]; then
    echo "Saindo..."
    break
  fi

  # Validar se a escolha é válida
  total_channels=$(wc -l < "$channels")
  if [[ "$choice" -ge 1 && "$choice" -le "$total_channels" ]]; then
    selected_channel=$(sed -n "${choice}p" "$channels")

    # Forçar parada do VLC antes de iniciar
    echo "Forçando a parada do VLC..."
    am force-stop org.videolan.vlc

    echo "Abrindo: $selected_channel"
    am start -a android.intent.action.VIEW -d "$selected_channel" -n "org.videolan.vlc/.gui.video.VideoPlayerActivity"
    sleep 1
  else
    echo "Opção inválida. Tente novamente."
    sleep 1
  fi
done
