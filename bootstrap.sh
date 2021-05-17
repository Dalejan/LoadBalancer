#!/bin/bash
name=$1
updateFiles=$2

## Instalación de LXD y encendido de contenedor

if [[ $(lxd --version) ]];
then
    echo "-- [LXD] lxd ya instalado version: $(lxd --version)"
else
    apt-get update
    echo "-- [LXD] Instalando LXD --"
    sudo snap install lxd --channel=4.0/stable

    echo "-- [LXD] Loguearnos al grupo creado --"
    newgrp lxd

    echo "-- [LXD] Iniciamos LXD --"
    lxd init --auto

    if [[ $(lxc info $name) ]];
    then
        echo "-- [LXD] El contenedor $name ya existe"
    else
        echo "-- [LXD] Creamos el contenedor $name con ubuntu:18.04 --"
        lxc launch ubuntu:18.04 $name
        sleep 7
    fi
fi

## Configuración de los servicios
if [[ "$name" == "haproxy" ]];
then

    if [[ $(lxc exec haproxy -- haproxy -v) ]];
    then
        echo "-- [HAPROXY] Haproxy ya instalado version: $(lxc exec haproxy -- haproxy -v)"]
    else
        echo "-- [HAPROXY] Se instala haproxy --"
        no n | lxc exec $name -- apt update && apt upgrade
        yes Y | lxc exec $name -- apt install haproxy -y
        lxc exec $name -- systemctl enable haproxy
    fi

    if [[ "$updateFiles" == "updateFiles" ]];
    then
        echo "-- [HAPROXY] Se configura haproxy.cfg --"
        sudo lxc file push /content/haproxy.cfg $name/etc/haproxy/haproxy.cfg

        echo "-- [HAPROXY] Se configura pagina de errores --"
        sudo lxc file push /content/error.http $name/etc/haproxy/errors/custom-error.http

        echo "-- [HAPROXY] Se reinicia el servicio haproxy --"
        lxc exec $name -- systemctl restart haproxy
    fi

else  
    echo "-- [APACHE] Se instala apache en el contenedor --"
    no n | lxc exec $name -- apt update && apt upgrade
    yes Y | lxc exec $name -- apt install apache2

    echo "-- [APACHE] Se inicia el servicio de apache --"
    lxc exec $name -- systemctl enable apache2

    if [[ "$updateFiles" == "updateFiles" ]];
    then
        echo "-- [APACHE] Se asigna el index.html al contenedor $name --"
        lxc file push /content/index.html $name/var/www/html/index.html
    fi

    echo "-- [APACHE] Se reinicia el servicio apache --"
    lxc exec $name -- systemctl restart apache2    
fi

if [[ $(lxc config device list haproxy) = http* ]];
then
    echo "-- [LXD] Ya se hace port forwarding --"
else
    echo "-- [LXD] Se realiza un portforwarding del contenedor --"
    lxc config device add $name http proxy listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80
fi