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

Esse roteiro funciona como um guia passo a passo para apoiar a pós-instalação e configuração de uma máquina de trabalho baseada no **ArchLinux**. Considero que estamos partindo de uma instalação PADRÃO do **EndeavourOS** com todas as atualizações recomendadas instaladas ( **sudo pacman -Syu** ). A **instalação mínima** pode apresentar **ERROS** na instalação de algum aplicativo, fique atento nas mensagens de erro para instalar os pacotes extras que forem necessários.

O objetivo deste roteiro **não é ser um script totalmente automatizado**, utilizo ele em meu ambiente, sendo  recomendado e testado apenas no **EndeavourOS** mas também funciona em qualquer Base  **ArchLinux**. Caso você queira seguir este roteiro em distros com outras bases, lembre-se de modificar os pacotes e comandos necessários, moldando conforme necessário para o sistema escolhido.

**NO FIM DESSE DOCUMENTO TEM UM SCRIPT PARA AUTOMATIZAR TODO ESSE PROCESSO**.


---


# 1º - Preparação do EndeavourOS

Atualize o sistema e instale o YAY
```shellscript
sudo pacman -Syu
```
```shellscript
sudo pacman -S yay
```

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

## 1.2 Instalação do Flatpak e repositório Flathub
```shellscript
sudo pacman -S flatpak
```
```shellscript
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

## 1.3 Instalação drivers de vídeo

Os drivers da AMD, INTEL e NVIDIA estão disponíveis desde a instalação padrão do EndeavourOS, para instá-los geralmente não é preciso fazer manualmente, mas por garantia gosto de fazer. **OBS: No script essa etapa é automatica, irá ver qual sua GPU e instalar os drivers!**

---
Para AMD:
```shellscript
sudo pacman -S vulkan-radeon libva-mesa-driver vulkan-icd-loader lib32-mesa lib32-vulkan-radeon lib32-vulkan-icd-loader lib32-libva-mesa-driver mesa-demos amd-ucode mesa-utils xorg-xdpyinfo
```

Para NVIDIA:
```shellscript
sudo pacman -S nvidia nvidia-utils nvidia-settings lib32-nvidia-utils vulkan-icd-loader lib32-vulkan-icd-loader gst-plugins-base mesa-demos mesa-utils xorg-xdpyinfo
```

Para INTEL:
```shellscript
sudo pacman -S vulkan-radeon libva-mesa-driver vulkan-icd-loader lib32-mesa lib32-vulkan-radeon lib32-vulkan-icd-loader lib32-libva-mesa-driver gst-plugins-base mesa-demos amd-ucode mesa-utils xorg-xdpyinfo
```


---


# 2º - Preparando ambiente (OPCIONAIS)

## 2.1 Editando o arquivo de configurações de Downloads (OPCIONAL):

Alterar numero de downloads simutâneos:
```shellscript
sudo nano /etc/pacman.conf
```

Aumentar o número de núcleos utilizados pelo sistema:
Descomentar a linha MAKEFLAGS e altere o numero presente em "-j1" para o número de núcleos do SEU processador:
```shellscript
sudo nano /etc/makepkg.conf
```

---


## 2.2 Partições montadas automaticamente ao iniciar o sistema (OPCIONAL)

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

# 3º - Manutenções de Uso (Fazer a cada 2 ou 4 meses)

**Limpa arquivos de configuração antigos:**
```shellscript
https://wiki.archlinux.org/title/System_maintenance#Old_configuration_files
```

**Limpar Cache:**
```shellscript
paccache -r
```

## 3.1 Mantendo as Mirrors atualizadas (Cada 1 semana/mês):
Caso esteja no EndeavourOS use o comando abaixo, senão ignore e use apenas os dois ultimos.
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

## BONUS
Baixe 230 Jogos de SuperNitendo traduzidos para PT-BR ( 243MB ):
```shellscript
https://drive.google.com/file/d/1Sf-qYhBFOiKt94K3AfY7U1meXpNhPKWK/view?usp=sharing
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


Fiz uma automatização para tudo isso, caso queira usar fique a vontade! Leia o Script **clean-post-install.sh** para entender o que será feito, para resumir, o script executa os mesmos comandos desse Tutorial acima, com exceção do passos **2** e **3** o arquivo **my-setup.sh** é o script que uso para gerenciar a pós instalação do meu sistema, fique a vontade para analisa-lo.
```shellscript
git clone https://github.com/SirGuinna/endeavouros-post-install
```
```shellscript
cd endeavouros-post-install
```
```shellscript
chmod +x clean-post-install.sh
```
```shellscript
sudo ./clean-post-install.sh
```