# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

# Returns date and time in 12hr format.
date_formatted=$(date +'%d-%m-%Y %l:%M:%S %p')

# Returns battery percent.
bat_percent=$(cat /sys/class/power_supply/BAT0/capacity)

# Returns 1 if charger connected and if disconnected.
chrgr_status=$(cat /sys/class/power_supply/ADP1/online)

# Check if charger disconnected and use apt emoji.
if [ $chrgr_status -eq "0" ]
then
	bat_emoji="🔋 "
else
	bat_emoji="⚡"
fi

# Returns SSID of connected wifi.
wifi_ssid=$(nmcli d wifi | grep "^\*" | grep -v "\*.*SSID" | awk '{ print $2 }')

# Returns signal strength 0-100.
wifi_str=$(nmcli d wifi | grep "^\*" | grep -v "\*.*SSID" | awk '{ print $7 }')

# Assign ip if only lan/wifi connected.
if [ $(hostname -i) != "127.0.0.2" ]
then
	my_ip=$(hostname -i)
fi

# Emojify wifi signal strength.
if [ $wifi_str -le 25 ]
then
	wifi_symbol="▂___"

elif [ $wifi_str -gt 25 -a $wifi_str -le 50 ]
then
	wifi_symbol="▂▄__"

elif [ $wifi_str -gt 50 -a $wifi_str -le 75 ]
then
	wifi_symbol="▂▄▆_"

elif [ $wifi_str -gt 75 -a $wifi_str -le 100 ]
then
	wifi_symbol="▂▄▆█"

else
	wifi_symbol="WIFI NOT CONNECTED"

fi	

# Statusbar print
echo │ $my_ip $wifi_ssid $wifi_symbol │ $bat_emoji$bat_percent% │ $date_formatted │
