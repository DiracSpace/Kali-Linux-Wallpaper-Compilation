#!/bin/sh

## Check for package
if ! dpkg -l | grep -q exiftool; then
  echo "[-] Missing: exiftool"
  ## Install packages
  sudo apt update
  sudo apt install -y exiftool
fi


## Find all files, expect git folder and this file
find ./ -maxdepth 1 -type f ! -path './.git/*' ! -path "$0" ! -name '*.sh' ! -name '*.md' ! -name '.*' \
  | sort \
  | while read f; do
  oldfilename="${f}"

  ## Remove screen resolution from filename, spaces and underscores
  newfilename="$( echo "${f}" \
    | sed '
           s/[0-9]\+x[0-9]\+//g;
           s/wp//gI
           s/wallpaper//gI
           s/bg//gI
           s/background//gI
           s/\s/-/g;
           s/_/-/g;
           s/--/-/g;
           s/-\././g;
          '; )"
  mv -n "${oldfilename}" "${newfilename}" \
    || echo "[-] Couldn't rename: ${f}"

  ## Add your screen res to end of filename
  exiftool '-filename<%f-${ImageSize}.%le' "${newfilename}"
  echo
done

echo "[i] Done"
