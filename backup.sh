#!/bin/bash
# cria um diretorio vazio em um dispositivo e copia os arquivos
# do diretorio home para la
#
# adiciona o path do dispositivo em uma variavel e cria um
# diretorio no dispositivo

path=$1
mkdir -v  $path/backup

#copia os arquivos e diretorios do home do usuario
cp -riv ~/* $path/backup/
#teste
