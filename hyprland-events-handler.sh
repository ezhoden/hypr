#!/bin/bash

function handle {
  if [[ ${1:0:12} == "monitoradded" ]]; then
    if [[ ${1:14:5} != "eDP-1" ]] && [[ ${1:14:8} != "HEADLESS" ]]; then
      hyprctl keyword monitor "eDP-1, disable"
    fi
  fi
  if [[ ${1:0:14} == "monitorremoved" ]]; then
    if [[ ${1:16:5} != "eDP-1" ]] && [[ ${1:16:8} != "HEADLESS" ]]; then
      hyprctl keyword monitor "eDP-1, highrr, auto, auto"
    fi
  fi
}

socat - "UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
