#!/bin/bash

#verificar se algum dispositivo foi conectado recentemente

disp=$(dmesg -k | tail | grep -E -o -m1 'sd[abcdef]')
echo dispositivo encontrada: $disp

#se o dispositivo estiver montado, localiza o ponto de montagem

part=$(mount | grep sda | cut -d' ' -f1)

echo partição montada: $part

#ponto de montagem

path_mont=$(mount | grep sda | cut -d' ' -f3)

echo montado em: $path_mont

#cria um diretorio de backup

mkdir $path_mont/backup

#copia os diretórios e arquivos

cp -r -v -p ~/D* $path_mont/backup
