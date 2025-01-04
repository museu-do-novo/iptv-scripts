#! /bin/bash

# Limpar a tela
clear;
# Puxar os links do site
curl -s https://ip-tv.app/ | grep -i "copy" | grep -i "https://" | awk -F '(' '{print $2}' | awk -F ',' '{gsub(/'\''/, ""); print $1}'

# depois de escolher um canal voce pode simplesmente rodar algo como:
# vlc [link que voce escolheu]

