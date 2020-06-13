#!/bin/sh

echo '''<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
<wallpapers>'''

## Find all files, expect git folder and this file
find ./ -maxdepth 1 -type f ! -path './.git/*' ! -path './debian/*' ! -path "$0" ! -name '*.sh' ! -name '.*' ! -name '*.md' -printf '%P\n' \
  | sort \
  | while read f; do

echo """  <wallpaper>
    <name>$( basename ${f} )</name>
    <filename>/usr/share/backgrounds/kali-community/${f}</filename>
    <options>zoom</options>
    <shade_type>solid</shade_type>
    <pcolor>#ffffff</pcolor>
    <scolor>#000000</scolor>
  </wallpaper>"""
done

echo "</wallpapers>"

echo "[i] Done" 1>&2
echo "[i] $0 > debian/gnome/kali-community-wallpapers.xml" 1>&2
