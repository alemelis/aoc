#!/bin/zsh

############################
SESSION_COOKIE=$AOC_COOKIE #
############################

YEAR=$1
DAY=$2

DAY=$(printf "%02d" $DAY)
DIR="year/$YEAR/$DAY"
mkdir -p "$DIR"

TARGET_FILE="$DIR/input.txt"

echo "Downloading input for $YEAR Day $DAY..."
curl -s --cookie "session=$SESSION_COOKIE" "https://adventofcode.com/$YEAR/day/$(printf "%01d" $DAY)/input" -o "$TARGET_FILE"

echo "Input saved to $TARGET_FILE"

cd "$DIR"
