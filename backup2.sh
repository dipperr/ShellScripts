#!/bin/bash

#verificar se algum dispositivo foi conectado recentemente

filetmp=$(mktemp /tmp/backup.XXX)
dmesg -k | tail -n20 > $filetmp
if grep -E -q 'sd[abcdef]' $filetmp; then
        disp=$(grep -E -o -m1 'sd[abcdef]' $filetmp)
        echo dispositivo encontrado:
        lsblk -l -o VENDOR,NAME,SIZE,TYPE,MOUNTPOINT /dev/$disp
        echo -n 'utilizar esse dispositivo para backup?(s/n)'
        read resp1
        if [ "$resp1" = "n" ]; then
                echo -n 'listar dispositivos identificados pelo sistema(s/n)'
                read resp2
                if [ "$resp2" = "s" ]; then
                        lsblk -l -o VENDOR,NAME,SIZE,TYPE,MOUNTPOINT
                else
                        exit 0
                fi
        fi

else
        echo parece que nenhum dispositivo foi conectado recentemente.

fi

#verifica se o dispositivo tem um sistema de arquivos montado

path_mont=$(mount | grep sda | cut -d' ' -f3)
echo ponto de montagem: $path_mont

#cria um diretorio de backup caso ele não exista
mes=$(date +%m)

if [ ! -d $path_mont/backup_mes_$mes ]; then
	mkdir $path_mont/backup_mes_$mes
else
        echo já existe um diretório chamado backup_mes_$mes!
        echo -n 'deseja copiar os arquivos para ele?(s/n)'
        read resp1
        if [ "$resp1" = "n"  ]; then
                exit 1
        fi
fi


#copia os diretórios e arquivos

cp -rvpn ~/Documentos $path_mont/backup_mes_$mes

