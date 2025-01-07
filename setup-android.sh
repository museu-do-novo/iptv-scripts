#!/bin/bash

# Limpar a tela
clear

# Exibir cabeçalho
echo "===== CONFIGURAÇÃO PARA ANDROID ====="

# Atualizar pacotes no Termux
echo "Atualizando pacotes do Termux..."
pkg update -y && pkg upgrade -y

# Instalar pacotes necessários
echo "Instalando ferramentas necessárias..."
pkg install -y curl bash

# Baixar VLC APK
apk_path="$TMPDIR/vlc.apk"
echo "Baixando VLC APK..."
curl -o "$apk_path" -L "https://get.videolan.org/vlc-android/3.5.4/VLC-android-3.5.4-arm64-v8a.apk"

# Instalar VLC
echo "Instalando VLC..."
pm install "$apk_path"

# Limpar arquivo APK baixado
echo "Limpando instalador VLC..."
rm "$apk_path"

# Configurar script IPTV
echo "Configurando script IPTV..."
curl -o "$PREFIX/bin/iptv_android.sh" -L "https://example.com/iptv_android.sh"
chmod +x "$PREFIX/bin/iptv_android.sh"

echo "===== INSTALAÇÃO CONCLUÍDA ====="
echo "Execute o script com: iptv_android.sh"
