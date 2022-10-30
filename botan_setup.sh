#!/bin/bash

echo "Installing script prereqisites"
sudo pacman -S git
echo "Installing a AUR helper called aura"
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin
makepkg -si
cd

echo "Updating System"
sudo aura -Syu

# Install drivers script

echo "Next we need to install the Graphic Drivers for your Graphics Card (GPU). This is needed because we want to play some Video Games or other graphical tasks."

echo "Before we can contine we need to edit the /etc/pacman.conf file and remove the hashtags that are dirctly before the Multilib repos.
The Multilib should look like this when finished:
[multilib]
Include = /etc/pacman.d/mirrorlist
"
printf "%s" "Press enter to continue
"
read ans

echo Please select your graphic drivers:
PS3='Please enter your choice: '
OPTIONS=("AMD" "Intel" "Nvidia")
select opt in "${OPTIONS[@]}"
do
    case $opt in
        "AMD")
            echo "Now Installing AMD drivers."
            sudo aura -S lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader
            break
            ;;
        "Intel")
            echo "Now installing Intel Drviers"
            sudo aura -S lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader
            break
            ;;
        "Nvidia")
            echo "Now Installing Nvidia Drivers"
            sudo aura -S nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done

echo "Desktop or Laptop settings: "
PS3='Please enter your choice: '
OPTIONS=("Desktop" "Laptop")
select opt in "${OPTIONS[@]}"
do
    case $opt in
        "Desktop")
            echo "Now Installing Desktop settings."
            echo "No known desktop tools"
            wait 3
            break
            ;;
        "Laptop")
            echo "Now installing Laptop settings"
            sudo aura -S tlc
            sudo aura -A powertop-auto-tune
            systemctl enable --now auto-cpufreq.service
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done

echo "Installing Botan's packages list"
sudo aura -S --noconfirm filezilla wine-staging firefox android-tools zsh-theme-powerlevel10k neofetch steam lib32-gnutls gdu btop plasma-systemmonitor elisa spectacle discord telegram-desktop lutris zstd lib32-zstd bleachbit
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --import -
sudo aura -A --noconfirm vscodium-bin spotify spotify-adblock mangohud goverlay protonup-qt-bin brave-bin an-anime-game-launcher-gtk-bin oh-my-zsh-git oh-my-zsh-plugin-syntax-highlighting oh-my-zsh-plugin-autosuggestions cpufetch github-desktop-bin heroic-games-launcher-bin dxvk-bin zsh-theme-powerlevel10k-git ttf-meslo-nerd-font-powerlevel10k

setup_dxvk install

