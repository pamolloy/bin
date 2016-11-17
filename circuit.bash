#!/usr/bin/env bash
#
#   circuit.bash - Exercise circuit
#

START="~/bin/dialog-information.ogg"
END="~/bin/dialog-question.ogg"

EXERCISES=(
    "Wall sit"
    "Push-up"
    "Crunch"
    "Squat"
    "Glute bridge"
    "Triceps dip"
    "Star plank"
    "Bicycle crunch"
    "Diamond push-up"
    "Prone back extension"
    "Plank"
    "Lunge"
    "Side plank left"
    "Side plank right"
)

sleep 20    # Wait for human to get into position

for EXERCISE in "${EXERCISES[@]}"; do
    echo "${EXERCISE}"...
    espeak "${EXERCISE}"
    sleep 10
    espeak start
    sleep 35
    espeak "10 seconds" # real time 1.14s
    sleep 4
    espeak "5 seconds"  # real time 1.14s
    sleep 4
    espeak stop
    sleep 1
done

espeak "Good job human"

echo "$(date +%Y%m%d) Completed 1 circuit" >> ~/.pal/exercise.pal
pal -r 90-1     # Display recent activity

