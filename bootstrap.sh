#!/bin/bash
name=$1

apt-get update
echo "-- Instalando LXD --"
sudo snap install lxd --channel=4.0/stable
echo "-- Loguearnos al crupo creado --"
newgrp lxd
echo "-- Iniciamos LXD --"
lxd init --auto
echo "-- Creamos el contenedor con ubuntu:18.04 --"
lxc launch ubuntu:18.04 $name
sleep 7

if [[ "$name" == "haproxy" ]];
then
    echo "-- Se instala haproxy --"
    no n | lxc exec $name -- apt update && apt upgrade
    yes Y | lxc exec $name -- apt install haproxy -y
    lxc exec $name -- systemctl enable haproxy
    echo "-- Se configura haproxy --"
    sudo lxc file pull $name/etc/haproxy/haproxy.cfg .
    cat /vagrant/content/$name/config.txt >> haproxy.cfg
    echo "lxc file push haproxy.cfg $name/etc/haproxy/"
    echo "-- Se reinicia el servicio haproxy --"
    lxc exec $name -- systemctl restart haproxy
else  
    echo "-- Se instala apache en el contenedor --"
    no n | lxc exec $name -- apt update && apt upgrade
    yes Y | lxc exec $name -- apt install apache2
    echo "-- Se inicia el servicio de apache --"
    lxc exec $name -- systemctl enable apache2
    echo "-- Se asigna el index.html al contenedor web --"
    lxc file push /vagrant/content/$name/index.html $name/var/www/html/index.html
    echo "-- Se reinicia el servicio apache --"
    lxc exec $name -- systemctl restart apache2    
fi

echo "-- Se realiza un portforwarding del contenedor --"
lxc config device add $name http proxy listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80