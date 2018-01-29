#!/bin/bash

ps auxwww | grep vlc | grep -v sout | grep -v grep | awk '{print $2}' | xargs kill -9

PHONE_IP=192.168.1.11

cvlc http://$PHONE_IP:8080/audio.wav &

# vlc http://$PHONE_IP:8080/video &
