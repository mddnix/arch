#!/bin/bash
# Arch Linux base install

chattr -R -f +C /var

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
timedatectl set-timezone Asia/Kolkata
timedatectl set-ntp true
hwclock --systohc --utc

sed -i 's/#en_IN UTF-8/en_IN UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_IN.UTF-8" > /etc/locale.conf

echo "arch.sysguides.box" > /etc/hostname

echo "" >> /etc/hosts
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.sysguides.box arch" >> /etc/hosts

sed -i '/^MODULES=()/ s/MODULES=()/MODULES=(btrfs)/' /etc/mkinitcpio.conf
mkinitcpio -P

echo "Add root password:"
passwd
echo

echo "Add Madhu password:"
groupadd madhu
useradd -c Madhu -m -g madhu -G users,wheel -s /bin/bash madhu
passwd madhu
echo

echo 'EDITOR=vim' >> /etc/environment
echo "Give wheel permission for sudo:"
visudo
echo

reflector --verbose --country 'India,' --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
sed -i 's/#Color/Color/' /etc/pacman.conf
sed -i 's/#CheckSpace/CheckSpace/' /etc/pacman.conf
sed -i 's/#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf

pacman -S grub efibootmgr networkmanager bash-completion
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager.service

## OUTPUT
echo "This are your changes..."
echo "-----------------------"
lsattr -d /var
echo
timedatectl
echo
hostnamectl
echo
cat /etc/hosts
echo

echo "Done. Now..." 
echo "exit"
echo "umount -vR /mnt"
echo "reboot"
echo

