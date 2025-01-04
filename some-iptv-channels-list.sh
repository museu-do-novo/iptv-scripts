#!/bin/bash

# Caminho para o arquivo temporário
CHANNELS_FILE="/tmp/iptv-channels.txt"

# Mensagem inicial
clear
echo "Carregando lista de canais..."

# Verifica se o arquivo de canais já existe; caso contrário, baixa e processa a lista
if [ ! -f "$CHANNELS_FILE" ]; then
    echo "Baixando e processando a lista de canais..."
    curl -s https://ip-tv.app/ \
        | grep -i "copy" \
        | grep -i "https://" \
        | awk -F '(' '{print $2}' \
        | awk -F ',' '{gsub(/'\''/, ""); print $1}' > "$CHANNELS_FILE"
fi

# Escolhe e abre links aleatoriamente
shuf "$CHANNELS_FILE" | while read -r LINK; do
    clear
    echo "Verificando $LINK..."

    # Verifica se o link está acessível
    if curl -s -o /dev/null -w "%{http_code}" "$LINK" | grep -q "200"; then
        echo "Abrindo $LINK no VLC..."
        vlc --fullscreen -q "$LINK"
    else
        echo "❌ Link inválido: $LINK"
    fi

    # Mensagem de saída
    echo "Pressione Ctrl+C para sair ou aguarde para abrir o próximo canal."
    sleep 5

done
