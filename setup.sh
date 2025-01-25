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
  termux-setup-storage || { echo "Erro ao configurar armazenamento no Termux."; exit 1; }

  # Atualizar pacotes e instalar dependências no Termux
  echo "Atualizando pacotes e instalando dependências no Termux..."
  if ! pkg update -y && pkg install -y curl termux-tools termux-api; then
    echo "Erro ao instalar dependências no Termux."
    exit 1
  fi

  # Definir caminho para o arquivo APK do VLC
  VLC_APK_PATH=~/storage/downloads/vlc.apk
  VLC_DOWNLOAD_URL="https://f-droid.org/repo/org.videolan.vlc_13050736.apk"

  # Baixar o APK do VLC
  echo "Baixando o APK do VLC do F-Droid..."
  if ! wget --no-check-certificate -O "$VLC_APK_PATH" "$VLC_DOWNLOAD_URL"; then
    echo "Erro ao baixar o APK do VLC. Verifique sua conexão com a Internet."
    exit 1
  fi

  # Instalar o APK do VLC usando termux-open
  echo "Iniciando a instalação do VLC..."
  if ! termux-open "$VLC_APK_PATH"; then
    echo "Erro ao abrir o instalador do VLC. Verifique o APK baixado."
    exit 1
  fi

  # Avisar o usuário sobre a instalação manual
  termux-toast "Por favor, conclua a instalação do VLC na interface exibida."
  echo "Pressione ENTER após concluir a instalação manual do VLC."
  read -r # Aguarda o usuário confirmar que finalizou a instalação

  # Remover o arquivo APK após a instalação
  echo "Removendo arquivo APK do VLC..."
  rm -f "$VLC_APK_PATH"

  # Confirmar que a instalação foi finalizada
  echo "Instalação do VLC concluída com sucesso."

  # Limpar a tela e chamar o script para IPTV no Android
  clear
  echo "Executando o script de configuração do IPTV para Android..."
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
