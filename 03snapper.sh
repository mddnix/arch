#!/bin/bash
# Arch Linux snapper configuration

sudo pacman -S snapper snap-pac grub-btrfs
sudo umount /.snapshots
sudo rmdir /.snapshots
sudo snapper -c root create-config /
sudo btrfs subvolume delete /.snapshots
sudo mkdir /.snapshots
sudo systemctl daemon-reload
sudo mount -va
sudo snapper -c root set-config ALLOW_USERS=$USER SYNC_ACL=yes
sudo chown -R :$USER /.snapshots
sudo grub-mkconfig -o /boot/grub/grub.cfg

yay -S snap-pac-grub

sudo systemctl enable --now grub-btrfs.path

snapper ls
