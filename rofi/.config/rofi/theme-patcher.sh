#!/bin/bash

# Target file
target_file="$HOME/.config/rofi/config.rasi"
theme_file="$HOME/.cache/dusk/pywal"

cp $target_file.in $target_file.tmp

theme="macchiato"

if grep -q '#eff1f5' "$theme_file"; then
    theme="latte" 
fi

sed -i "s/%s%/${theme}/g" $target_file.tmp

# Finally, replace target file with our updated one
rm $target_file
mv $target_file.tmp $target_file