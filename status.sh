# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

# Returns date and time in 12hr format.
date_formatted=$(date +'%d-%m-%Y %l:%M:%S %p')

# Returns battery percent.
bat_percent=$(cat /sys/class/power_supply/BAT0/capacity)

# Returns battery percent with color and percent symbol.
bat_percentc="$bat_percent%"

# Returns 1 if charger connected and if disconnected.
chrgr_status=$(cat /sys/class/power_supply/ADP1/online)

# Check if charger disconnected and use apt emoji.
if [ $chrgr_status -eq "0" ]
then
	bat_emoji="🔋"
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

# Current volume
vol_perc=$(amixer sget Master | grep 'Right:' | awk -F'[]['%']' '{ print $2 }')

# Master sink status
sink_stat=$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $4 }')

# Sound emoji
if [ $vol_perc -eq '0' -o $sink_stat == "off" ]
then
	vol_emoji="🔇"

else
	vol_emoji="🔉"
fi

# Low battery flasher and statusbar print.
if [ $bat_percent -le 20 -a $bat_percent -gt 10 ]
then
	bat_percentc="<span fgcolor='yellow' size='x-large'>$bat_percent%</span>"
	echo "│ $my_ip $wifi_ssid $wifi_symbol │ $vol_emoji$vol_perc% │ $bat_emoji$bat_percentc │ $date_formatted │"

elif [ $bat_percent -le 10 -a $bat_percent -gt 1 ]
then
	bat_percentc="<span fgcolor='yellow' size='x-large'>$bat_percent%</span>"
	echo "│ $my_ip $wifi_ssid $wifi_symbol │ $vol_emoji$vol_perc% │ $bat_emoji$bat_percentc │ $date_formatted │"
	sleep 0.5
	bat_percentc="<span fgcolor='red' size='x-large'>$bat_percent%</span>"
	echo "│ $my_ip $wifi_ssid $wifi_symbol │ $vol_emoji$vol_perc% │ $bat_emoji$bat_percentc │ $date_formatted │"
else
	echo "│ $my_ip $wifi_ssid $wifi_symbol │ $vol_emoji$vol_perc% │ $bat_emoji$bat_percentc │ $date_formatted │"
fi
