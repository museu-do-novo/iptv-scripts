#!/bin/bash

chmod +x ./*.sh
# Função para configurar no Android
setup_android() {
  clear
  echo "Configurando o ambiente para Android..."

  # Verificar se o Termux está configurado corretamente
  if ! command -v termux-setup-storage &> /dev/null; then
    echo "Erro: Termux não está configurado corretamente. Configure o Termux antes de continuar."
    exit 1
  fi

  # Configurar permissões de armazenamento no Termux
  termux-setup-storage

  # Garantir que o curl e o termux-tools estão instalados
  echo "Verificando dependências no Termux..."
  pkg update -y
  pkg install -y curl termux-tools

  # Baixar o VLC APK do link atualizado no F-Droid
  echo "Baixando VLC APK..."
  apk_file=$TMPDIR/vlc.apk
  curl -L -o "$apk_file" https://f-droid.org/repo/org.videolan.vlc_13050736.apk

  # Instalar o VLC usando termux-open
  echo "Iniciando o instalador do VLC..."
  termux-open "$apk_file"

  # Solicitar ao usuário que finalize a instalação manualmente
  echo "Por favor, finalize a instalação do VLC na interface que foi aberta."
  echo "Pressione ENTER após concluir a instalação."
  read -r # Aguarda o usuário confirmar que finalizou a instalação

  # Remover o APK após a instalação
  rm -f "$apk_file"
  echo "Instalação do VLC finalizada."

  # Limpar a tela e chamar o script iptv-android.sh
  clear
  echo "Chamando o script IPTV para Android..."
  bash iptv_android.sh
}

# Função para configurar no Linux
setup_linux() {
  clear
  echo "Configurando o ambiente para Linux..."

  # Atualizar pacotes
  echo "Atualizando pacotes..."
  sudo apt update

  # Instalar VLC
  if ! command -v vlc &> /dev/null; then
    echo "Instalando VLC..."
    sudo apt install -y vlc
  else
    echo "VLC já instalado."
  fi

  # Instalar curl, se necessário
  if ! command -v curl &> /dev/null; then
    echo "Instalando curl..."
    sudo apt install -y curl
  fi

  # Limpar a tela e chamar o script iptv-linux.sh
  clear
  echo "Chamando o script IPTV para Linux..."
  bash iptv_linux.sh
}

# Menu para escolher o ambiente
clear
echo "Selecione o sistema operacional para configurar:"
echo "1) Android"
echo "2) Linux"
read -p "Escolha uma opção (1 ou 2): " choice

case $choice in
  1)
    setup_android
    ;;
  2)
    setup_linux
    ;;
  *)
    echo "Opção inválida. Saindo."
    exit 1
    ;;
esac
