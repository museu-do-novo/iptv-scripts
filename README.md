# IPTV Scripts para Android e Linux

Este repositório contém dois scripts interativos para gerenciar e reproduzir playlists de IPTV diretamente no VLC Media Player. Ele é projetado para funcionar em dispositivos Android via Termux e em sistemas Linux (baseados em Debian, como Ubuntu).

Ambos os scripts oferecem menus interativos para selecionar e reproduzir canais de uma playlist baixada automaticamente. 

---

## 📂 Estrutura do Repositório
- `setup.sh`: Script de configuração que instala todas as dependências necessárias para Android e Linux.
- `iptv_android.sh`: Script exclusivo para dispositivos Android.
- `iptv_linux.sh`: Script exclusivo para sistemas Linux.
- `README.md`: Documentação do projeto.

---

## 📱 **Configuração no Android**

### Requisitos
Para executar os scripts no Android, é necessário:
- **[Termux](https://termux.com/):** Um emulador de terminal para Android.
- **Permissões de armazenamento no Termux:** Certifique-se de executar `termux-setup-storage` para permitir o acesso ao armazenamento.
- **Conexão com a Internet:** Para baixar a lista de canais IPTV e o VLC APK.

### Instalação
1. Clone este repositório no Termux:
   ```bash
   git clone https://github.com/seu-repositorio/iptv-scripts.git
   cd iptv-scripts

2. Execute o script de configuração:

bash setup.sh

O script baixa o APK do VLC Media Player e o instala automaticamente.

Também verifica e instala o curl, caso não esteja disponível.



3. Após a configuração, o ambiente estará pronto para uso.



Uso

1. Execute o script de IPTV:

bash iptv_android.sh


2. Você verá um menu interativo exibindo os canais disponíveis:

Selecione o número correspondente ao canal desejado para reproduzir no VLC.

Pressione 0 para sair do menu.




Funções Especiais

Use o argumento -c para limpar a lista de canais e forçar o download de uma nova:

bash iptv_android.sh -c



---

🖥️ Configuração no Linux

Requisitos

Para executar os scripts no Linux, é necessário:

Sistema baseado em Debian (Ubuntu, Mint, etc.): Outros sistemas podem funcionar, mas não foram testados.

Conexão com a Internet: Para baixar a lista de canais IPTV.

Permissões administrativas: Necessárias para instalar dependências, como VLC e curl.


Instalação

1. Clone este repositório:

git clone https://github.com/seu-repositorio/iptv-scripts.git
cd iptv-scripts


2. Execute o script de configuração:

bash setup.sh

O script instala o VLC e o curl, caso não estejam disponíveis.



3. Após a configuração, o ambiente estará pronto para uso.



Uso

1. Execute o script de IPTV:

bash iptv_linux.sh


2. O menu interativo será exibido:

Escolha um canal pelo número para reproduzir no VLC.

Pressione 0 para sair.




Funções Especiais

Use o argumento -c para limpar a lista de canais e baixar uma nova:

bash iptv_linux.sh -c



---

🔧 Como Funciona

Lista de Canais

Ambos os scripts baixam automaticamente uma lista de canais IPTV do site ip-tv.app. Os links são processados e armazenados em um arquivo temporário.

Menu Interativo

O menu exibe os canais disponíveis com base na lista baixada. O usuário pode:

Selecionar um canal pelo número.

Pressionar 0 para sair.


Reproduzindo no VLC

No Android: Os links são abertos com o comando am start, que inicia o VLC Media Player.

No Linux: O VLC é chamado diretamente no terminal com a URL do canal.



---

⚠️ Avisos

1. Lista de Canais: Certifique-se de que a fonte da lista é confiável e respeita os direitos autorais.


2. Permissões no Android: Conceda ao Termux acesso ao armazenamento para que os scripts possam funcionar corretamente.


3. Compatibilidade: O VLC precisa estar instalado e funcional no dispositivo ou sistema.




---

📄 Licença

Este projeto é licenciado sob a MIT License. Sinta-se à vontade para usar, modificar e distribuir, respeitando os termos da licença.


---

📞 Suporte

Caso tenha dúvidas ou problemas, abra uma issue no repositório GitHub ou entre em contato pelo e-mail de suporte fornecido.

Esse README contém explicações detalhadas, requisitos, instruções de instalação e uso, além de avisos importantes. Está formatado para ser facilmente utilizável no GitHub. Alguma parte que você gostaria de melhorar ou expandir?

