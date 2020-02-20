#!/bin/bash
#path de destino
path_dest=/home/motoko/backup

#quantidade de linhas do arquivo de path
linh=$(wc -l < diretorios.txt)

#verifica se já existe um diretorio de backup. caso não exista, cria um
if [ ! -d $path_dest ]; then
	mkdir $path_dest
fi

#testa a variavel especial para ver se o comando anterior foi executado sem erros
#caso tenha sido executado sem erros, copias os diretorios do path de origem
#para o path de destino
if [ $? -eq 0 ]; then
	for var in $(seq $linh); do
		path_orig=$(grep $var diretorios.txt | cut -d ' ' -f2)
		cp -rnv $path_orig $path_dest
	done
	echo ultimo backup: $(date +%d:%m) >> $path_dest/log_backup.txt
else
	echo arquivos não copiados!
fi

