sudo cat << EOF >> /boot/grub/grub.cfg
menuentry "Windows" {
  insmod part_gpt
  insmod fat
  insmod chain
  search --label --set=root BOOT
  chainloader ($root)/EFI/Microsoft/Boot/bootmgfw.efi
}
EOF
