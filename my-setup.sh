#!/bin/bash

# Verifica se o script está sendo executado com permissões de root
if [ "$(id -u)" -ne 0 ]; then
    echo "Este script precisa ser executado como root."
    echo "This script needs to be run as root."
    exit 1
fi

# Habilita o modo de falha imediata (interrompe o script se qualquer comando falhar)
set -e

# Função para verificar e instalar o eos-rankmirrors (Só irá instalar se for EndeavourOS)
verificar_e_instalar_eos_rankmirrors() {
    # Verifica se a distribuição é EndeavourOS
    if grep -q "EndeavourOS" /etc/os-release; then
        echo "Detected EndeavourOS. Proceeding with eos-rankmirrors setup..."
        
        # Verifica se o eos-rankmirrors está instalado
        if ! command -v eos-rankmirrors &> /dev/null; then
            echo "eos-rankmirrors not found. Installing..."
            sudo pacman -S eos-rankmirrors --noconfirm
            echo "eos-rankmirrors installed successfully!"
        else
            echo "eos-rankmirrors already installed."
        fi
        
        # Verifica novamente se o comando foi instalado com sucesso
        if ! command -v eos-rankmirrors &> /dev/null; then
            echo "eos-rankmirrors installation failed. Exiting."
            exit 1
        fi
}

# Funcao para verificar e instalar yay
verificar_e_instalar_yay() {
    if ! command -v yay &> /dev/null; then
        echo "YAY is not installed. Installing YAY..."
        sudo pacman -S yay --noconfirm
    else
        echo "YAY is already installed."
    fi
}

# Funcao para instalar o Flatpak e adicionar o repositorio Flathub
instalar_flatpak_e_adicionar_flathub() {
    # Verifica e instala o Flatpak
    if ! command -v flatpak &> /dev/null; then
        echo "Flatpak is not installed. Installing Flatpak..."
        sudo pacman -S flatpak --noconfirm
    fi
    # Verifica e adiciona o repositorio Flathub se ainda nao estiver adicionado
    if ! flatpak remote-list | grep -q flathub; then
        echo "Adding Flathub repository..."
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    else
        echo "Flathub repository already added."
    fi
}

# Funcao para instalar pacotes essenciais
instalar_pacotes_essenciais() {
    echo "Installing essential packages..."
    sudo pacman -S --noconfirm \
        git \
        nano \
        wget \
        curl \
        htop \
        fastfetch
}

# Funcao para instalar codecs de multimidia
instalar_codecs() {
    echo "Installing multimedia codecs..."
    sudo pacman -S --noconfirm \
        gstreamer \
        ffmpeg \
        gst-libav \
        gst-plugins-ugly \
        gst-plugins-good \
        gst-plugins-bad \
        gst-plugins-base
}

# Funcao para instalar drivers de video
instalar_drivers_video() {
    echo "Detecting graphics card..."
    
    # Verifica a GPU presente no sistema
    gpu_info=$(lspci | grep -E "VGA|3D")
    
    if echo "$gpu_info" | grep -i "NVIDIA" >/dev/null; then
        echo "NVIDIA GPU detected. Installing NVIDIA drivers..."
        sudo pacman -S --noconfirm \
            nvidia \
            nvidia-utils \
            nvidia-settings \
            lib32-nvidia-utils \
            vulkan-icd-loader \
            lib32-vulkan-icd-loader \
            gst-plugins-base \
            mesa-demos \
            mesa-utils \
            xorg-xdpyinfo

    elif echo "$gpu_info" | grep -i "AMD" >/dev/null; then
        echo "AMD GPU detected. Installing AMD drivers..."
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

    elif echo "$gpu_info" | grep -i "Intel" >/dev/null; then
        echo "Intel GPU detected. Installing Intel drivers..."
        sudo pacman -S --noconfirm \
            mesa \
            vulkan-intel \
            lib32-mesa \
            lib32-vulkan-intel \
            libva-intel-driver \
            gst-plugins-base \
            mesa-demos \
            mesa-utils \
            xorg-xdpyinfo

    else
        echo "GPU não detectada ou desativada, atualize manualmente."
        echo "No supported GPU detected or unable to determine the GPU."
        echo "Please check your hardware manually."
    fi
}

# Funcao para instalar softwares essenciais via pacman
instalar_softwares() {
    echo "Installing essential applications..."
    sudo pacman -S --noconfirm \
        chromium \
        obs-studio \
        timeshift \
        gparted \
        discord
}

# Funcao para instalar Github Desktop via yay
instalar_softwares_adicionais() {
    echo "Installing GitHub Desktop with YAY..."
    yay -S github-desktop-bin --noconfirm
}

# Funcao para instalar aplicativos Flatpak
instalar_flatpaks() {
    # Lista de aplicativos Flatpak a serem instalados
    aplicativos=("com.protonvpn.www" "org.gimp.GIMP" "com.visualstudio.code" "com.github.tchx84.Flatseal" "com.usebottles.bottles" "net.pcsx2.PCSX2" "com.snes9x.Snes9x" "org.inkscape.Inkscape" "nl.hjdskes.gcolor3" "org.kde.kdenlive")
    # Itera sobre a lista e instala cada aplicativo
    for app in "${aplicativos[@]}"; do
        echo "Installing $app with Flatpak..."
        flatpak install flathub "$app" --yes
    done
}

# Inicio do processo
echo "Starting the installation process..."

# Atualiza o Sistema
atualizar_sistema() {
    echo "Updating system..."
    sudo pacman -Syu --noconfirm
}

# Verifica e atualiza os Espelhos
verificar_e_instalar_eos_rankmirrors
echo "Ranking mirrors with eos-rankmirrors..."
eos-rankmirrors
echo "Mirrors Verified!"

echo "Updating the list of fastest mirrors with Reflector..."
sudo reflector --verbose --latest 25 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
echo "List updated successfully!"

verificar_e_instalar_yay
echo "Updating the system with YAY and sync mirrors..."
yay -Syyu --noconfirm

# Instalando pacotes e drivers
instalar_drivers_video
instalar_codecs
instalar_pacotes_essenciais
instalar_softwares
instalar_softwares_adicionais
instalar_flatpak_e_adicionar_flathub

# Instalando aplicativos Flatpak
instalar_flatpaks
echo "Flatpak applications installation completed!"

# Fim do processo
echo "Pós-instalação concluída! REINICIE O SISTEMA PARA QUE TODAS AS ALTERAÇÕES TENHAM EFEITO."
echo "Post-installation complete! PLEASE RESTART YOUT SYSTEM FOR ALL CHANGES TO TAKE EFFECT."