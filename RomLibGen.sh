#!/bin/bash

# --- Load config file ---
source config/config

# --- Generate lists of available platforms and ROMs ---
echo "Scanning Library..."
mkdir -p cache
rm cache/devices 2> cache/log
for devdir in $romdir/*
do	
	dir=${devdir%*/}
	echo "${devdir##*/}" >> cache/devices
	rm "cache/${devdir##*/}" 2> cache/log
	ls $devdir >> "cache/${devdir##*/}"
done

# --- Generate startpage ---
echo "Generating Startpage..."
rm cache/devlist 2> cache/log
while read device
do
	href='<a href="'"${device}"'/index.html">'
	echo '<div class="card">' >> cache/devlist
	echo $href >> cache/devlist
	thumb=$thumbdir/$device.png
	webthumb=$webthumbdir/$device.png
		if [ -f "$thumb" ]; then
			img='<img src="'"$webthumb"'">'
			echo $img >> cache/devlist
		else
			img='<img src="notfound.png">'
			echo $img >> cache/devlist
		fi
	echo '<div class="container">' >> cache/devlist
	echo $device >> cache/devlist
	echo '</div>' >> cache/devlist
	echo '</a>' >> cache/devlist
	echo '</div>' >> cache/devlist
	echo '' >> cache/devlist
done < cache/devices

devlist=$(cat cache/devlist)

mkdir -p $sitename
cp templates/notfound.png $sitename/
cp templates/styles.css $sitename/
eval "echo \"$(cat templates/startpage)\"" > $sitename/index.html

# --- Generate device pages ---
rm cache/*.romlist 2> cache/log
while read device
do
	echo "Generating $device List... (this might take a while)"
	mkdir -p $sitename/$device
	while read rom
	do
		href='<a href="'"${webromdir}"'/'"${device}"'/'"${rom}"'">'
		rom="${rom%.*}"
		echo '<div class="card">' >> cache/$device.romlist
		echo $href >> cache/$device.romlist
		thumb=$thumbdir/$device/Named_Boxarts/$rom.png
		webthumb=$webthumbdir/$device/Named_Boxarts/$rom.png
			if [ -f "$thumb" ]; then
				img='<img src="'"$webthumb"'">'
				echo $img >> cache/$device.romlist
			else
				img='<img src="../notfound.png">'
				echo $img >> cache/$device.romlist
			fi
		rom=$(echo $rom | sed -e 's|^|'"${href}"'|')
		rom=$(echo $rom | sed -e 's|$|</a>|')
		echo '<div class="container">' >> cache/$device.romlist
		echo $rom >> cache/$device.romlist
		echo '</div>' >> cache/$device.romlist
		echo '</a>' >> cache/$device.romlist
		echo '</div>' >> cache/$device.romlist
		echo '' >>cache/$device.romlist
	done < cache/$device
	romlist=$(cat cache/$device.romlist)
	eval "echo \"$(cat templates/devicepage)\"" > $sitename/$device/index.html
done < cache/devices

# --- Finish ---
rm -r cache

echo "Done!"
