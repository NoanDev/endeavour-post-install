<p align="center">
<img width="700px" src="https://github.com/NoanDev/endeavour-post-install/blob/main/img/endos-img" align="center" alt="white" /><br><br>
 
<!-- (site para ícones: https://shields.io/ ) -->
 
<img alt="Maintained" src="https://img.shields.io/badge/Maintained%3F-Yes-green">
<img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/NoanDev/endeavour-post-install">

</p>


# AVISO

Ao usar este roteiro você assume que entende os riscos e assume total responsabilidade por suas ações. Todos os arquivos que fazem parte desse repositório são distribuídos livremente para serem adaptados. Porém, não há nenhuma garantia implícita ou explícita do seu funcionamento.


---


# Objetivos

Esse roteiro funciona como um guia passo a passo para apoiar a pós-instalação/configuração de uma máquina de trabalho baseada no ArchLinux para atividades de Gameplays, Edição de Vídeo/Fotos, e Programação.

O objetivo deste roteiro **não é ser um script totalmente automatizado**, utilizo ele em meu ambiente, sendo  recomendado e testado apenas no EndeavourOS. Caso você queira seguir este roteiro em distros com outras bases, lembre-se de modificar os pacotes e comandos necessários por conta e risco, moldando conforme necessário para seu sistema.

A seleção de programas escolhidos, é a que utilizo em minha rotina atual, então remova ou adicione programas de acordo com sua necessidade.


---


Neste roteiro considero que estamos partindo de uma instalação PADRÃO do EndeavourOS com o ambiente KDE Plasma, com todas as atualizações recomendadas instaladas. A **instalação mínima** pode apresentar erros na instalação de algum aplicativo, fique atento nas mensagens de erro para instalar os pacotes extras que forem necessários.

Meu setup padrão utiliza uma GPU AMD RADEON 520 e um processador Intel®Core™ i7-8565U 1.80GHz. Prefiro utilizar o formato flatpak sempre que possível, adapte conforme suas preferências/necessidades.


---


# Preparação do EndeavourOS

## Atualizando Mirrors

Por garantia prefiro ter certeza que os Mirrors estão configurados e são os mais rápidos.

```shellscript
sudo reflector --verbose --latest 25 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
```
```shellscript
eos-rankmirrors
```
```shellscript
yay -Syyu
```

**Editando o arquivo de configurações de Downloads (OPCIONAL):**

Alterar numero de downloads simutâneos:
```shellscript
sudo nano /etc/pacman.conf
```

Aumentar o número de núcleos utilizados pelo sistema:
Descomentar a linha MAKEFLAGS e altere o numero presente em "-j1" para o número de núcleos do SEU processador:
```shellscript
sudo nano /etc/makepkg.conf
```

## Repositórios extras de Codecs

São vários repositórios que disponibiliza Codecs para arquivos de Video, Musica e Ferramentas de Multimedia:
```shellscript
sudo pacman -Syu ffmpeg gst-plugins-ugly gst-plugins-good gst-plugins-base gst-plugins-bad gst-libav gstreamer
```

## Instalação drivers de vídeo AMD

Os drivers da AMD/ATI estão disponíveis desde a instalação padrão do EndeavourOS, para instá-los geralmente não é preciso fazer manualmente, mas por garantia gosto de fazer.
```shellscript
sudo pacman -Syu vulkan-radeon libva-mesa-driver vulkan-icd-loader lib32-mesa lib32-vulkan-radeon lib32-vulkan-icd-loader lib32-libva-mesa-driver mesa-demos amd-ucode mesa-utils xorg-xdpyinfo
```

---

# Preparação do ambiente para Produtividade

## Instalação dos Programas/Aplicativos (OPCIONAL)

**Lembrete: Suporte a Flatpak no sistema já é NATIVO**

O script abaixo instala Telegram Desktop, Nano, Neofetch, Discord, TimeShift, GParted, OBS Studio, BTop.

```shellscript
sudo pacman -Syu telegram-desktop nano neofetch discord timeshift gparted obs-studio btop
```

**Instala o Browser Vivaldi:**
```shellscript
yay -S vivaldi
```

**Instala o Bottles:**
```shellscript
flatpak instal bottles
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

**Instala o Emulador de PlayStation 2**
```shellscript
flatpak install pcsx2
```
Baixe a BIOS do PS2 (Tem Japones, Europa e EUA): https://drive.google.com/file/d/17b6sCwUxrnO0WVxqTGnWHCSGKeiG_5Lz/view?usp=sharing

-

Baixe TODOS os jogos de Ps2 ( 2TB ): https://drive.google.com/file/d/1chVGDlyiP1WZ1xHhqNpHx23RpprDYJu6/view?usp=sharing

**Instala o Emulador de Super Nitendo**
```shellscript
flatpak install snes9x
```
Baixe 230 Jogos de SuperNitendo traduzidos para PT-BR --> https://drive.google.com/file/d/1Sf-qYhBFOiKt94K3AfY7U1meXpNhPKWK/view?usp=sharing

**Instala o Github Desktop:**
```shellscript
flatpak install --user https://flathub.org/repo/appstream/io.github.shiftey.Desktop.flatpakref
```

**Instala o Visual Studio Code:**
```shellscript
flatpak install flathub com.visualstudio.code
```


## Instalação de ferramentas gráficas: Gimp, Inskcape, ColorPicker.

Apps para criação de conteúdo, tratamento de imagens, desenho vetorial e edição de vídeo usando software livre.
```shellscript
flatpak install org.gimp.GIMP com.obsproject.Studio nl.hjdskes.gcolor3 org.inkscape.Inkscape 
```

## Hora de dar o visual desejado ao EndeavourOS
**Deixo esse tópico aberto pois é pessoal de cada um, eu particularmente altero algumas opções do KDE Plasma e já acho suficiente. Fique a vontade para fazer/criar sua própria personalização**

## Partições montadas automaticamente ao iniciar o sistema (OPCIONAL)

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

# Manutenções de uso (Fazer a cada 2 ou 4 meses)

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

## Mantendo as Mirrors atualizadas (Cada 1 mês):
```shellscript
sudo reflector --verbose --latest 25 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

```
```shellscript
eos-rankmirrors
```
```shellscript
yay -Syyu
```

# !!! ATENÇÃO !!!
**Sempre ao iniciar seu sistema ou até mesmo antes de instalar qualquer aplicativo ou pacote use o script abaixo para evitar causar instabilidades ou até mesmo quebrar o sistema:**
**Mantenha seu sistema atualizado**
```shellscript
yay -Syyu
```
**Na documentação do ArchLinux diz que o usuário deve sempre usar o exemplo abaixo ao instalar novos pacotes:**
```shellscript
sudo pacman -Syu nomedopacote
```