#!/bin/bash
set -e  # exit immediately if any command fails

echo "Compiling..."
rm -f *.bin boot.img

nasm -f bin stage1.asm -o stage1.bin
nasm -f bin stage2.asm -o stage2.bin

cat stage1.bin stage2.bin > boot.img
echo "Done"
