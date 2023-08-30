# !!!IMPORTANT!!!
## This project (along with everything else on my profile) has moved over to gitlab! 
## Any future updates will be pushed to https://gitlab.com/justjulez420/RomLibGen

# RomLibGen

A static html rom library generator written in bash
![](https://raw.githubusercontent.com/justjulez420/RomLibGen/main/example-images/ex1.png)
![](https://raw.githubusercontent.com/justjulez420/RomLibGen/main/example-images/ex2.png)
![](https://raw.githubusercontent.com/justjulez420/RomLibGen/main/example-images/ex3.png)

## Usage

### Preparation
first, you have to organize your roms in a folder structure like this:
```
ROMs
 |-GBA
 |   |-Pokemon Firered.gba
 |   |-Pokemon Emerald.gba
 |   |-etc...
 |
 |-GBC
 |   |-Pokemon Crystal.gbc
 |   |-Pokemon Gold.gbc
 |   |-etc...
 |
 |-NDS
 |   |-Pokemon Diamond.nds
 |   |-Pokemon Platin.nds
 |   |-etc...
 |
 |-etc..
```
you also have to get your own preview images. 
Check out this repo to find a lot of them neatly organized: 
https://github.com/libretro-thumbnails/libretro-thumbnails

you can place the images and roms wherever you want. however, if you want to host this on a server. it obviously needs to be somewhere readable by your http user

the images need to be pngs and their folders must use the same name as the rom folders and follow this folder structure:
```
thumbnails
|-GBA
|   |-Named_Boxarts
|         |-Pokemon Firered.png
|         |-Pokemon Emerald.png
|         |-etc..
|-GBC
|   |-Named_Boxarts
|         |-Pokemon Crystal.png
|         |-Pokemon Gold.png
|         |-etc...
|-NDS
|   |-Named_Boxarts
|         |-Pokemon Diamond.png
|         |-Pokemon Platin.png
|         |-etc...
```
last, you will need icons. i found these that look nice: https://www.reddit.com/r/RetroArch/comments/lepqdl/anyone_know_how_to_replace_every_icon_in_retroarch/
but i don't know if they are licensed or something like that, so i currently dont include them here.
if you know who made these, please let me know so i can hopefully include them in the future.
alternatively, just get the ones from retroarch assets

you should put your icons as pngs at the root of your thumbnail folder and name them the same as your associated rom folder.

so, thumbnails/GBA.png will be used for the GBA folder, etc.

### Configuration
dont worry, the hard part is over. just open the config/config file in a text editor of your choice and point romdir to your rom directory and thumbdir to your thumbnail directory.
if you just want to run this on your local machine, set webromdir und webthumbdir to be the same as romdir and thumbdir.

if you want to deploy this on a server, point them the same folders but relative from their webroot.


so, if you roms are stored at
```
/var/www/games/roms
```
and your thumbnails at
```
/var/www/games/thumbnails
```
with your webroot being 
```
/var/www/
```
set webromdir to
```
/games/roms
```
and webthumbdir to
```
/games/thumbnails
```

you can also give your library a name by setting the sitename variable
### Running
simply run the scipt. 

a new folder will be created named RomLib (or the name you gave it in the config) that contains your static html pages. either launch index.html in a browser or put the whole thing in your webroot or whatever you want. it's your's now, have fun!
