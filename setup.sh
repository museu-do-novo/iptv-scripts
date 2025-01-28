#!/bin/bash

# Configurar permissões executáveis para scripts .sh no diretório atual
chmod +x ./*.sh

# Função para configurar o ambiente no Android
setup_android() {
  clear
  echo "Iniciando configuração para o ambiente Android..."

  # Verificar se o Termux está configurado corretamente
  if ! command -v termux-setup-storage &> /dev/null; then
    echo "Erro: Termux não encontrado ou não configurado corretamente."
    echo "Certifique-se de que o Termux está instalado e configurado antes de continuar."
    exit 1
  fi

  # Solicitar permissão de armazenamento no Termux
  echo "Solicitando permissões de armazenamento no Termux..."
  termux-setup-storage

  # Atualizar pacotes e instalar dependências necessárias
  echo "Atualizando pacotes e instalando dependências no Termux..."
  if ! pkg update -y && pkg upgrade -y; then
    echo "Erro ao atualizar pacotes no Termux."
    exit 1
  fi

  echo "Instalando dependências necessárias (curl, wget, termux-tools)..."
  if ! pkg install -y curl wget termux-tools termux-api; then
    echo "Erro ao instalar dependências no Termux."
    exit 1
  fi

  # Definir caminho para o arquivo APK do VLC
  VLC_APK_PATH=~/storage/downloads/vlc.apk
  VLC_DOWNLOAD_URL="https://f-droid.org/repo/org.videolan.vlc_13050736.apk"

  # Baixar o APK do VLC
  echo "Baixando o APK do VLC para a pasta Downloads..."
  if ! wget --no-check-certificate -O "$VLC_APK_PATH" "$VLC_DOWNLOAD_URL"; then
    echo "Erro ao baixar o APK do VLC. Verifique sua conexão com a Internet."
    exit 1
  fi

  # Informar o usuário sobre a instalação manual
  echo "O APK do VLC foi baixado na pasta Downloads:"
  echo "$VLC_APK_PATH"
  echo "Por favor, instale manualmente o APK do VLC."
  termux-toast "O APK do VLC foi baixado. Instale manualmente."

  # Confirmar que o processo de download foi concluído
  echo "Após instalar, pressione ENTER para continuar..."
  read -r # Aguarda o usuário confirmar que instalou o APK

  # Limpar a tela e chamar o script para IPTV no Android
  clear
  echo "Executando o script de IPTV para Android..."
  sleep 3
  bash iptv_android.sh || { echo "Erro ao executar o script iptv_android.sh."; exit 1; }
}

# Função para configurar o ambiente no Linux
setup_linux() {
  clear
  echo "Iniciando configuração para o ambiente Linux..."

  # Atualizar lista de pacotes e instalar atualizações
  echo "Atualizando pacotes do sistema..."
  if ! sudo apt update; then
    echo "Erro ao atualizar pacotes. Verifique sua conexão com a Internet."
    exit 1
  fi

  # Verificar e instalar o VLC
  if ! command -v vlc &> /dev/null; then
    echo "VLC não encontrado. Instalando VLC..."
    if ! sudo apt install -y vlc; then
      echo "Erro ao instalar VLC. Verifique sua conexão ou permissões."
      exit 1
    fi
  else
    echo "VLC já está instalado."
  fi

  # Verificar e instalar o curl
  if ! command -v curl &> /dev/null; then
    echo "curl não encontrado. Instalando curl..."
    if ! sudo apt install -y curl; then
      echo "Erro ao instalar curl. Verifique sua conexão ou permissões."
      exit 1
    fi
  else
    echo "curl já está instalado."
  fi

  # Limpar a tela e chamar o script para IPTV no Linux
  clear
  echo "Executando o script de configuração do IPTV para Linux..."
  bash iptv_linux.sh || { echo "Erro ao executar o script iptv_linux.sh."; exit 1; }
}

# Menu principal para seleção do sistema operacional
clear
echo "Bem-vindo ao script de configuração!"
echo "Selecione o sistema operacional para configurar:"
echo "1) Android"
echo "2) Linux"
read -p "Escolha uma opção (1 ou 2): " USER_CHOICE

case $USER_CHOICE in
  1)
    setup_android
    ;;
  2)
    setup_linux
    ;;
  *)
    echo "Opção inválida. Saindo do script."
    exit 1
    ;;
esac
