#!/bin/bash
# Arch Linux base post install

xdg-user-dirs-update

sudo pacman -S acpi acpi_call acpid base-devel cups dnsutils firewalld gdisk inetutils ipset iptables-nft linux-headers man-db man-pages nfs-utils nmap ntfs-3g openssh os-prober p7zip progress ps_mem reflector rsync tar texinfo unrar wpa_supplicant xdg-user-dirs xdg-utils zstd

sudo systemctl enable acpid.service
sudo systemctl enable cups.service
sudo systemctl enable firewalld.service

git clone https://aur.archlinux.org/yay.git
#bash yay/makepkg -si
sh -c "cd yay && makepkg -si"

echo 'alias ll="ls -lhs"' | sudo tee -a /etc/bash.bashrc
source /etc/bash.bashrc
