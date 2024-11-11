#!/bin/bash

# Verifica se o eos-rankmirrors está instalado
if ! command -v eos-rankmirrors &> /dev/null
    then
        echo "eos-rankmirrors not found. Installing..."
        sudo pacman -S eos-rankmirrors --noconfirm
    else
        echo "eos-rankmirrors already installed."
    fi

# Atualiza os espelhos com eos-rankmirrors
echo "Ranking mirrors with eos-rankmirrors..."
eos-rankmirrors

# Atualiza a lista de espelhos com Reflector (pega os 25 mais rápidos, usa https e classifica por taxa de transferência)
echo "Updating the list of mirrors with Reflector..."
sudo reflector --verbose --latest 25 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Verifica se o yay está instalado
if ! command -v yay &> /dev/null
then
    echo "YAY it's not installed. Installing YAY..."
    sudo pacman -S yay --noconfirm
fi

# Atualiza o sistema usando yay
echo "Updating the system with YAY..."
yay -Syyu --noconfirm

# Instala pacotes essenciais
echo "Installing essential packages..."
sudo pacman -S --noconfirm \
    git \
    nano \
    wget \
    curl \
    htop \
    fastfetch

# Instala codecs de multimídia
echo "Installing multimedia codecs..."
sudo pacman -S --noconfirm \
    gstreamer \
    ffmpeg \
    gst-libav \
    gst-plugins-ugly \
    gst-plugins-good \
    gst-plugins-bad \
    gst-plugins-base

# Instala Drivers de Video AMD
echo "Installing AMD video drivers..."
sudo pacman -S --noconfirm \
    vulkan-radeon \
    libva-mesa-driver \
    vulkan-icd-loader \
    lib32-mesa \
    lib32-vulkan-radeon \
    lib32-vulkan-icd-loader \
    lib32-libva-mesa-driver \
    gst-plugins-base \
    mesa-demos \
    amd-ucode \
    mesa-utils \
    xorg-xdpyinfo

# Instala o suporte a Flatpak e adiciona o Repositório Flathub
echo "Installing Flatpak support..."
sudo pacman -S flatpak --noconfirm
echo "Adding Flathub repository..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Instala softwares
echo "Installing applications..."
sudo pacman -S --noconfirm \
    chromium \
    obs-studio \
    timeshift \
    gparted \
    discord

# Instala softwares adicionais
echo "Installing additional applications..."
yay -S github-desktop-bin --noconfirm

# Instalando aplicativos Flatpak
instalar_flatpaks() {
    # Lista de aplicativos Flatpak a serem instalados
    aplicativos=("com.protonvpn.www" "org.gimp.GIMP" "com.visualstudio.code" "com.github.tchx84.Flatseal" "com.usebottles.bottles" "net.pcsx2.PCSX2" "com.snes9x.Snes9x" "org.inkscape.Inkscape" "nl.hjdskes.gcolor3" "org.kde.kdenlive")
    # Itera sobre a lista e instala cada aplicativo
    for app in "${aplicativos[@]}"; do
        echo "Installing $app with Flatpak..."
        flatpak install flathub "$app" --yes
    done
}
# Executa a instalação dos aplicativos Flatpak
instalar_flatpaks
echo "Instalação dos aplicativos Flatpak concluída!"

# Fim
echo "Pós Instalação Completa! REINICIE O SISTEMA."
echo "Post Installation Complete! PLEASE RESTART THE SYSTEM."