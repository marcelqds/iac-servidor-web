#!/bin/bash
#author: Marcelo Queiroz de Santana

title(){
    echo -e "\n:: ===== $1 ===== ::\n"
}

update(){
    clear
    title Atualizar\ Sistema
    apt update && apt upgrade -y
}

install(){
    clear
    title "Instalar Apache e Unzip"
    #apt install apache2 unzip -y
}

download(){
    title "Download da Aplicação e Salvar no /tmp"
    wget -nv $1 -P $2
}

removeDownload(){
    #title "Remover arquivo baixado"
    rm -rf $1
}

bk(){    
    title "Efetuar backup arquivos anteriores no /tmp/backups/"
    date_=`date +"%s"`
    destiny="$1/web-$date_"
    origin=$2
    path_copy="$origin/* $destiny/"
    mkdir $destiny -p
    cp -R $path_copy
    `rm -rf "$origin/*"`
    echo -e "Backup efetuado em: $destiny\n"
}

extract(){    
    title "Extraindo arquivos da aplicação no diretório do servidor web"
    unzip -qq -o $1 -d $2/
}

path_html=/var/www/html
path_file=/tmp/iac-app-web-server
path_bkp=/tmp/backups
url_down=https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip

title "Iniciando criação de estrutura"
update
install
removendoDownload $path_file
download $url_down $path_file
bk $path_bkp $path_html
extract "$path_file/main.zip" $path_html
title "Estrutura criada com sucesso"
