#!/usr/bin/python3

import os

os.system("yay -Syu && yay -S sway swayidle swaylock dmenu screenfetch vim xorg-server-xwayland nautilus grim wl-clipboard nomacs termite light google-chrome ")

filebashrc = os.environ['HOME'] + "/" + ".bashrc"

with open(filebashrc, 'r') as f:
    if "exec sway" not in f.read():
        f.close()
        with open(filebashrc,'a') as g:
            g.write("""\n\n# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
	exec sway
fi""")
            g.close()


print("\n############################")
print("### ALL SET UP FOR SWAY! ###")
print("############################\n")
