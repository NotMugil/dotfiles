#!/bin/bash

# Array containing multiple lines of text
lines=(
    "This is line 1"
    "This is line 2"
    "Hola $USER"
    "Enter password $USER"
    "Hey $USER"
)

# Get the number of lines in the array
num_lines=${#lines[@]}

# Generate a random index
index=$((RANDOM % num_lines))

# Print the randomly selected line
echo "${lines[index]}"
export "${lines[index]}"
