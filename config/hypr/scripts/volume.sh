#!/bin/bash

case $1
in
     toggle_mute) 
        pamixer -t
	;;

     up) 
	pamixer -i 1
	;;

     down) 
	pamixer -d 1 
	;;
esac
