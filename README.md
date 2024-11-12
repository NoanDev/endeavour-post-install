<p align="center">
<img width="700px" src="https://github.com/NoanDev/endeavour-post-install/blob/main/img/endos-img.jpg" align="center" alt="white" /><br><br>
 
<!-- (site para ícones: https://shields.io/ ) -->
 
<img alt="Maintained" src="https://img.shields.io/badge/Maintained%3F-Yes-green">
<img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/NoanDev/endeavour-post-install">

</p>

# AVISO

Ao usar este roteiro você assume que entende os riscos e assume total responsabilidade por suas ações. Todos os arquivos que fazem parte desse repositório são distribuídos livremente para serem adaptados para seu uso. Porém, não há nenhuma garantia implícita ou explícita do seu funcionamento. O intuito dele é facilitar minha instalação, mas resolvi deixa-lo mais completo caso alguem queira aprender ou usa-lo. Se ele te ajudar deixe uma Estrela.


---


# Objetivos

Esse roteiro funciona como um guia passo a passo para apoiar a pós-instalação e configuração de uma máquina de trabalho baseada no **ArchLinux** para atividades leves de Gameplays, Edição de Vídeo/Fotos, e Programação.

O objetivo deste roteiro **não é ser um script totalmente automatizado**, utilizo ele em meu ambiente, sendo  recomendado e testado apenas no **EndeavourOS** mas também funciona no **ArchLinux**. Caso você queira seguir este roteiro em distros com outras bases, lembre-se de modificar os pacotes e comandos necessários por conta e risco, moldando conforme necessário para o sistema escolhido.

A seleção de programas escolhidos, é a que utilizo em minha rotina atual, então remova ou adicione programas de acordo com sua necessidade. **NO FIM DESSE DOCUMENTO TEM UM SCRIPT PARA AUTOMATIZAR TODO ESSE PROCESSO**.


---


Neste roteiro considero que estamos partindo de uma instalação PADRÃO do **EndeavourOS** com todas as atualizações recomendadas instaladas ( **sudo pacman -Syu** ). A **instalação mínima** pode apresentar **ERROS** na instalação de algum aplicativo, fique atento nas mensagens de erro para instalar os pacotes extras que forem necessários.

Meu setup padrão utiliza uma **GPU AMD RADEON** e um processador **Intel**.


---


# 1º - Preparação do EndeavourOS

## 1.1 Atualizando Mirrors

Por garantia prefiro ter certeza que os Mirrors estão configurados e são os mais rápidos.

```shellscript
eos-rankmirrors
```
```shellscript
sudo reflector --verbose --latest 25 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
```
```shellscript
yay -Syyu
```

## 1.2 Editando o arquivo de configurações de Downloads (OPCIONAL):

Alterar numero de downloads simutâneos:
```shellscript
sudo nano /etc/pacman.conf
```

Aumentar o número de núcleos utilizados pelo sistema:
Descomentar a linha MAKEFLAGS e altere o numero presente em "-j1" para o número de núcleos do SEU processador:
```shellscript
sudo nano /etc/makepkg.conf
```

## 1.3 Repositórios extras de Codecs

São vários repositórios que disponibiliza Codecs para arquivos de Video, Musica e Ferramentas de Multimedia:
```shellscript
sudo pacman -S ffmpeg gst-plugins-ugly gst-plugins-good gst-plugins-base gst-plugins-bad gst-libav gstreamer
```

## 1.4 Instalação drivers de vídeo AMD

Os drivers da AMD/ATI estão disponíveis desde a instalação padrão do EndeavourOS, para instá-los geralmente não é preciso fazer manualmente, mas por garantia gosto de fazer.
```shellscript
sudo pacman -S vulkan-radeon libva-mesa-driver vulkan-icd-loader lib32-mesa lib32-vulkan-radeon lib32-vulkan-icd-loader lib32-libva-mesa-driver mesa-demos amd-ucode mesa-utils xorg-xdpyinfo
```


---


# 2º - Preparação do ambiente para Produtividade

## 2.1 Instalação dos Programas/Aplicativos

**Lembrete: Instale o suporte a Flatpak**
```shellscript
sudo pacman -S flatpak
```
```shellscript
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

O script abaixo instala Telegram Desktop, Chromium, Nano, Fastfetch, Discord, TimeShift, GParted, OBS Studio, HTop.

```shellscript
sudo pacman -S telegram-desktop chromium nano fastfetch discord timeshift gparted obs-studio htop
```

**Instala o ProtonVPN:**
```shellscript
flatpak install flathub com.protonvpn.www
```

**Instala o Github Desktop:**
```shellscript
flatpak install --user https://flathub.org/repo/appstream/io.github.shiftey.Desktop.flatpakref
```

**Instala o Visual Studio Code:**
```shellscript
flatpak install flathub com.visualstudio.code
```

**Instala o Bottles:**
```shellscript
flatpak install bottles
```

**Instala o FlatSeal:**
```shellscript
flatpak install flathub com.github.tchx84.Flatseal
```

**Instala a Steam**
```shellscript
flatpak install steam
```
Se for necessário, utilizando o FlatSeal libere as permissões do pacote flatpak do Steam para acessar outras Unidades de Disco. Atente-se a permissão de leitura e escrita está habilitada na Patição/Disco em questão.


---


**Instala o Emulador de PlayStation 2**
```shellscript
flatpak install pcsx2
```
Baixe a BIOS do PS2 (Japones, Europa e EUA):
```shellscript
https://drive.google.com/file/d/17b6sCwUxrnO0WVxqTGnWHCSGKeiG_5Lz/view?usp=sharing
```
Baixe TODOS os jogos de Ps2 .Torrent ( 2TB Completo ou selecione os Jogos que você quiser):
```shellscript
https://drive.google.com/file/d/1chVGDlyiP1WZ1xHhqNpHx23RpprDYJu6/view?usp=sharing
```


---


**Instala o Emulador de Super Nitendo**
```shellscript
flatpak install snes9x
```
Baixe 230 Jogos de SuperNitendo traduzidos para PT-BR ( 243MB ):
```shellscript
https://drive.google.com/file/d/1Sf-qYhBFOiKt94K3AfY7U1meXpNhPKWK/view?usp=sharing
```


---


## 2.2 Instalação de ferramentas gráficas: Gimp, Inskcape, ColorPicker e Kdenlive

Apps para criação de conteúdo, tratamento de imagens, desenho vetorial e edição de vídeo usando software livre.
```shellscript
flatpak install org.gimp.GIMP org.inkscape.Inkscape nl.hjdskes.gcolor3 org.kde.kdenlive
```

## 2.3 Hora de dar o visual desejado ao EndeavourOS
**Deixo esse tópico aberto pois é pessoal de cada um, eu particularmente uso Tile Windows Manager (i3wm) e na instalação do EndeavourOS já tem a opção de escolhe-la e já vem bem utilizável. Fique a vontade para fazer sua própria personalização a depender da Interface Gráfica de sua escolha.**

## 2.4 Partições montadas automaticamente ao iniciar o sistema (OPCIONAL)

Eu uso o GParted para gerenciar minhas Partições e Discos. Use o App que preferir que você preferir.

Veja as informações de suas Partições:
```shellscript
sudo fdisk -l
```

Cria a pasta onde será montado sua partição no seu sistema:
```shellscript
sudo mkdir /mnt/nomedapartição
```

Coloque suas partições para iniciarem junto ao sistema:
```shellscript
sudo nano /etc/fstab
```
Explicação: No fim do arquivo adicione uma linha referente a partição específica que você quer montar, se for mais de uma partição/disco adicione mais linhas, faça como o exemplo abaixo:
```shellscript
/dev/sd*X /mnt/nomedapartição ext4 defaults 0 0
```
* = Letra da partição/disco.
X = Número da partição/disco.
Onde tem “ext4” você altera para o formato em que seu HD/SSD foi formatado.

Aplique permissões de leitura e escrita na partição/disco com o comando abaixo:
```shellscript
sudo chmod 777 /mnt/nomedapartição
```


---


## 2.5 Instalando o XAMPP (OPCIONAL)

Baixe o XAMPP:
```shellscript
https://www.apachefriends.org/download.html
```
Instale o pacote "libxcrypt-compat" para funcionar corretamente:
```shellscript
yay -S libxcrypt-compat
```
Execute os seguintes comandos para instalar:
```shellscript
cd Downloads
```
```shellscript
sudo chmod +x nomedoarquivobaixado
```
```shellscript
sudo ./nomedoarquivogerado
```
DICA: No nome do arquivo basta por "xamp" e apertar TAB que o nome vai ser completado.

- Ao instalar você terá a Interface Gráfica mas ao fechar não terá mais. Sempre que precisar execute via terminal com o comando abaixo:
```shellscript
sudo /opt/lampp/lampp start
```
- Parar o XAMPP é o mesmo comando, porém no lugar de "start" coloque "stop".

---

# 3º - Manutenções de Uso (Fazer a cada 2 ou 4 meses)

**Limpa arquivos de configuração antigos:**
```shellscript
https://wiki.archlinux.org/title/System_maintenance#Old_configuration_files
```

**Limpar Cache:**
```shellscript
paccache -r
```

**Caso seja necessário atualizar o GitHub Desktop:**
```shellscript
flatpak --user update io.github.shiftey.Desktop
```

## 3.1 Mantendo as Mirrors atualizadas (Cada 1 semana/mês):
```shellscript
eos-rankmirrors
```
```shellscript
sudo reflector --verbose --latest 25 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

```
```shellscript
yay -Syyu
```

---

# !!! ATENÇÃO !!!
**Sempre ao iniciar seu sistema ou até mesmo antes de instalar qualquer aplicativo ou pacote use os comandos abaixo para evitar causar instabilidades ou até mesmo quebrar o sistema:**
**Mantenha seu sistema atualizado**
```shellscript
yay -Syyu
```
Não esqueça de mander os Pacotes Flatpak atualizados tambem:
```shellscript
flatpak update
```
**Na documentação do ArchLinux diz que o usuário deve sempre usar o exemplo abaixo ao instalar novos pacotes:**
```shellscript
sudo pacman -Syu nomedopacote
```

---

Fiz uma automatização para tudo isso (**Sim, Sou Preguiçoso!**), caso queira usar fique a vontade! Leia o Script **post-install.sh** para entender o que será feito, para resumir, o script executa os mesmos comandos desse Tutorial acima. Exceto todos os passos a partir do 2.3 até 3.1
```shellscript
git clone https://github.com/SirGuinna/endeavouros-post-install
```
```shellscript
cd endeavouros-post-install
```
```shellscript
chmod +x post_install.sh
```
```shellscript
./post_install.sh
```