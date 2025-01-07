#!/bin/bash

# Limpar a tela
clear

# Exibir cabeçalho
echo "===== CONFIGURAÇÃO PARA LINUX ====="

# Atualizar pacotes do sistema
echo "Atualizando pacotes do sistema..."
sudo apt update && sudo apt upgrade -y

# Instalar VLC e curl
echo "Instalando VLC e ferramentas necessárias..."
sudo apt install -y vlc curl bash

# Configurar script IPTV
echo "Configurando script IPTV..."
curl -o "/usr/local/bin/iptv_linux.sh" -L "https://example.com/iptv_linux.sh"
chmod +x "/usr/local/bin/iptv_linux.sh"

echo "===== INSTALAÇÃO CONCLUÍDA ====="
echo "Execute o script com: iptv_linux.sh"
