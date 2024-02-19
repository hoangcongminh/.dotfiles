#!/bin/bash

EMULATOR=~/Library/Android/sdk/tools/emulator

if [ $# -ne 1 ]; then
    echo "ERROR: Please specify the target AVD from the list below" 1>&2
    $EMULATOR -list-avds 1>&2
    exit 1
fi
emulator -avd $1 -dns-server "8.8.8.8,8.8.4.4"
