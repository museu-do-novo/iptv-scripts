#!/bin/bash

# Limpar a tela
clear

# Definir o caminho do arquivo de canais temporário
channels=$TMPDIR/iptv-channels.txt

# Função: Verifica se o argumento é uma URL válida
is_url() {
  local url_regex="^(http|https|ftp)://"
  [[ "$1" =~ $url_regex ]]
}

# Função: Verifica se o argumento é um arquivo válido
is_file() {
  [[ -f "$1" ]]
}

# Função: Baixa ou atualiza a lista de canais
download_channels() {
  echo "Baixando lista de canais..."
  curl -s https://ip-tv.app/ | grep -i "copy" | grep -i "https://" | \
  awk -F '(' '{print $2}' | awk -F ',' '{gsub(/'\''/, ""); print $1}' > "$channels"
}

# Função: Exibe o menu interativo para escolher um canal
show_menu() {
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

# Função: Lida com os argumentos recebidos
handle_arguments() {
  if [[ -n "$1" ]]; then
    case "$1" in
      -c) 
        # Remove a lista de canais existente
        echo "Removendo lista antiga de canais..."
        rm -f "$channels"
        download_channels
        ;;
      *)
        # Verifica se é uma URL válida
        if is_url "$1"; then
          echo "Abrindo link no VLC: $1"
          am start -a android.intent.action.VIEW -d "$1" -n "org.videolan.vlc/.gui.video.VideoPlayerActivity"
          exit 0
        # Verifica se é um arquivo válido
        elif is_file "$1"; then
          echo "Abrindo arquivo no VLC: $1"
          am start -a android.intent.action.VIEW -d "file://$1" -n "org.videolan.vlc/.gui.video.VideoPlayerActivity"
          exit 0
        else
          # Argumento inválido
          echo "Argumento inválido: $1"
          echo "Use um link, um caminho de arquivo, ou o argumento '-c' para limpar os canais."
          exit 1
        fi
        ;;
    esac
  fi
}

# Chamar a função para tratar os argumentos
handle_arguments "$1"

# Verifica se a lista de canais existe, caso contrário, baixa uma nova
if [ ! -f "$channels" ]; then
  download_channels
fi

# Verifica se a lista está vazia
if [ ! -s "$channels" ]; then
  echo "Erro: Nenhum canal encontrado. Verifique a fonte ou a conexão."
  exit 1
fi

# Loop infinito para exibir o menu e abrir canais
while true; do
  show_menu
  read -p "Escolha uma opção: " choice

  if [[ "$choice" == "0" ]]; then
    echo "Saindo..."
    break
  fi

  # Valida se a escolha é um número válido dentro do intervalo
  total_channels=$(wc -l < "$channels")
  if [[ "$choice" -ge 1 && "$choice" -le "$total_channels" ]]; then
    selected_channel=$(sed -n "${choice}p" "$channels")
    echo "Abrindo: $selected_channel"
    am start -a android.intent.action.VIEW -d "$selected_channel" -n "org.videolan.vlc/.gui.video.VideoPlayerActivity"
    sleep 1
  else
    echo "Opção inválida. Tente novamente."
    sleep 1
  fi
done
