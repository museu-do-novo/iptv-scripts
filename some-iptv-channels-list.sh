#! /bin/bash

# Limpar a tela
clear;

# Puxar os links do site
curl https://ip-tv.app/ | grep copy | grep https | awk -F "(" '{print $2}' | awk -F ',' '{print $1}'

# depois de escolher um canal voce pode simplesmente rodar algo como:
# vlc [link que voce escolheu]

