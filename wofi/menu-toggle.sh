#!/bin/bash

wofi_pid=$(pgrep -f "wofi.*--show drun")

if [[ -n "$wofi_pid" ]]; then
    pkill -f "wofi.*--show drun"
else
    wofi -a --show drun &
fi
