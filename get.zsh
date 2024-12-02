#!/bin/zsh

# Usage: ./get_input.zsh YEAR DAY

# Input arguments
YEAR=$1
DAY=$2

# Your Advent of Code session cookie
SESSION_COOKIE=$AOC_COOKIE  # Replace with your actual session cookie

# Validate input
if [[ -z "$YEAR" || -z "$DAY" ]]; then
  echo "Usage: ./get_input.zsh YEAR DAY"
  exit 1
fi

# Zero-pad the day for proper formatting
DAY=$(printf "%02d" $DAY)

# Create directory structure
DIR="year/$YEAR/$DAY"
mkdir -p "$DIR"

# Target file
TARGET_FILE="$DIR/input.txt"

# Check if input already exists
if [[ -f "$TARGET_FILE" ]]; then
  echo "Input for $YEAR Day $DAY already exists at $TARGET_FILE"
  exit 0
fi

# Download input
echo "Downloading input for $YEAR Day $DAY..."
curl -s --cookie "session=$SESSION_COOKIE" "https://adventofcode.com/$YEAR/day/$(printf "%01d" $DAY)/input" -o "$TARGET_FILE"

if [[ $? -ne 0 || ! -s "$TARGET_FILE" ]]; then
  echo "Failed to download input or file is empty."
  [[ -f "$TARGET_FILE" ]] && rm "$TARGET_FILE" # Cleanup if the file is empty
  exit 1
fi

echo "Input saved to $TARGET_FILE"
