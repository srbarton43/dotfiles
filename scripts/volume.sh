#!/bin/bash
# NAME
#     volume.sh - Increase/decrease/mute volume
# SYNOPSIS 
#     volume.sh <raise|lower|mute>
# Suggested location: ~/scripts/volume.sh
# 
# 02/09/2025
# https://ejmastnak.com/tutorials/arch/volume/#kernel-level-drivers-and-sound-servers

if [ $# != 2 ]; then
  echo "Exactly two commands should be passed."
  echo "Usage should be: volume.sh <raise|lower|mute>"
  exit 1
fi

step=$2

if [[ ! $step =~ ^[0-9]+$ ]] || [[ $step -gt 20 ]] || [[ $step -le 0 ]]; then
  echo "Unrecognized parameter: ${1}. Bad step value"
  echo "Step value should be an integer in [1,20]"
  echo "Usage should be: volume.sh <raise|lower|mute>"
  exit 2
fi

# Select EITHER the `amixer` or the `pactl` command in each case
if [ $1 == "raise" ]; then
  pactl set-sink-volume @DEFAULT_SINK@ "+${step}%"
elif [ $1 == "lower" ]; then
  pactl set-sink-volume @DEFAULT_SINK@ "-${step}%"
elif [ $1 == "mute" ]; then
  pactl set-sink-mute @DEFAULT_SINK@ toggle
else
  echo "Unrecognized parameter: ${1}"
  echo "Usage should be: volume.sh <raise|lower|mute>"
  exit 1
fi

