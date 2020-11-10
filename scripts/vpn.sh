#!/bin/bash

button=$1

read -r remote_server remote_user remote_password < ~/.vpnconfig

online='<span color="#44C7EB"> Online</span>'
offline='<span color="#FFFFFF"> Offline </span>'
error='<span color="#EB1313"> Error </span>'

if [ -z "$remote_server" ] || [ -z "$remote_user" ] || [ -z "$remote_password" ]; then
    echo $error
    exit
fi

status=$(sudo ps aux | grep openconnect | grep $remote_user -c)

if [ -z $button ]; then
    if [ $status == 0 ]; then 
        echo $offline 
    else 
        echo $online
    fi
else
    {
        if [ $status == 0 ]; then 
            twmnc -c 'Connecting to '$remote_server
            sudo openconnect -b --user=$remote_user --passwd-on-stdin $remote_server <<< $(echo $remote_password)
        else 
            twmnc -c 'Disconnecting from '$remote_server
            sudo pkill -SIGINT openconnect
        fi
    } &> /dev/null
fi
exit