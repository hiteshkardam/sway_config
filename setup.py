#!/usr/bin/python3

import os

os.system("yay -Syu && yay -S sway swayidle swaylock dmenu screenfetch vim xorg-server-xwayland nautilus grim wl-clipboard nomacs termite-nocsd light google-chrome ")

# Paths
homepath = os.environ['HOME'] + "/" 
filebashrc = homepath + ".bashrc"
termitedir = homepath + ".config/termite"

# Autostart sway if logging in from tty1
with open(filebashrc, 'r') as f:
    if "exec sway" not in f.read():
        f.close()
        with open(filebashrc,'a') as g:
            g.write("""\n\n# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
	exec sway
fi""")
            g.close()

# Termite infite scrollback
if os.path.exists(homepath+".config/termite") == False:
    os.system("mkdir $HOME/.config/termite")
    os.system("touch $HOME/.config/termite/config")
    os.system("echo scrollback_lines = -1 > $HOME/.config/termite/config")

# Fancy, eh!
print("\n############################")
print("### ALL SET UP FOR SWAY! ###")
print("############################\n")
