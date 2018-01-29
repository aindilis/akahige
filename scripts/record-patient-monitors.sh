#!/bin/bash

# https://wiki.videolan.org/Documentation:Streaming_HowTo/Receive_and_Save_a_Stream/

PHONE_IP=192.168.1.11
TIMESTAMP=`timestamp`

# ps auxwww | grep vlc | grep sout | grep -v grep | awk '{print $2}' | xargs kill -9

STORAGEDIR="<REDACTED>"
echo $STORAGEDIR
OUTFILE="<REDACTED>"

cvlc http://$PHONE_IP:8080/audio.wav --sout file/wav:$OUTFILE &
ln -s $OUTFILE ~/
