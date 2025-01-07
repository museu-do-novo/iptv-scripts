#!/bin/bash

# Função para configurar no Android
setup_android() {
  echo "Configurando o ambiente para Android..."
  
  # Verificar se o Termux está instalado
  if ! command -v termux-setup-storage &> /dev/null; then
    echo "Erro: Termux não está configurado corretamente. Configure o Termux antes de continuar."
    exit 1
  fi

  # Permissões para acessar armazenamento
  termux-setup-storage

  # Baixar e instalar o VLC para Android
  echo "Baixando VLC APK..."
  apk_file=$TMPDIR/vlc.apk
  curl -L -o "$apk_file" https://get.videolan.org/vlc-android/3.5.4/VLC-android-3.5.4-armv7.apk
  
  echo "Instalando VLC..."
  pm install "$apk_file"

  # Remover o APK após a instalação
  rm -f "$apk_file"
  echo "VLC instalado com sucesso."

  # Garantir que o curl está instalado
  if ! command -v curl &> /dev/null; then
    pkg update && pkg install -y curl
  fi

  echo "Configuração para Android concluída."
}

# Função para configurar no Linux
setup_linux() {
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

  echo "Configuração para Linux concluída."
}

# Menu para escolher o ambiente
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
