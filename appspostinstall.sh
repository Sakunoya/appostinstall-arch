#!/bin/b#!/bin/bash

# Vérifie si l'utilisateur est root
if [[ $EUID -ne 0 ]]; then
    echo "❌ Ce script doit être exécuté avec les droits root (sudo)."
    exit 1
fi

# Liste des applications à installer
appspacman=(
    curl
    wget
    prismlauncher
    flameshot
    steam
    java8-openjdk
    java17-openjdk
    java20-openjdk
    mangohud
)

appsyay=(
    cider-bin
    heroic-games-launcher-bin
)

appsflatpak=(
    com.discordapp.Discord
    xyz.xclicker.xclicker
    net.davidotek.pupgui2
)

echo "🔄 Mise à jour des paquets"
yay -Syu --noconfirm && flatpak update --noconfirm

echo "🚀 Début de l'installation des applications"

for app in "${appspacman[@]}"; do
    echo "📦 Installation de : $app"
    if pacman -Qi "$app" &> /dev/null; then
        echo "✅ $app est déjà installé."
    else
        pacman -S --noconfirm "$app"
        if [ $? -eq 0 ]; then
            echo "✅ $app installé avec succès."
        else
            echo "❌ Échec de l'installation de $app."
        fi
    fi
done

for app in "${appsyay[@]}"; do
    echo "📦 Installation de : $app"
    if yay -Qi "$app" &> /dev/null; then
        echo "✅ $app est déjà installé."
    else
        yay -S --noconfirm "$app"
        if [ $? -eq 0 ]; then
            echo "✅ $app installé avec succès."
        else
            echo "❌ Échec de l'installation de $app."
        fi
    fi
done

for app in "${appsflatpak[@]}"; do
    echo "📦 Installation Flatpak de : $app"
    if flatpak list | grep -q "$app"; then
        echo "✅ $app est déjà installé."
    else
        flatpak install -y "$app"
        if [ $? -eq 0 ]; then
            echo "✅ $app installé avec succès."
        else
            echo "❌ Échec de l'installation de $app."
        fi
    fi
done

echo "✅ Installation terminée !"
