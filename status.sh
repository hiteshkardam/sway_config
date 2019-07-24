# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

# Returns date in 12hr
date_formatted=$(date +'%d-%m-%Y %l:%M:%S %p')

# Returns battery percent
bat_percent=$(cat /sys/class/power_supply/BAT0/capacity)

# Returns the battery status: "Full", "Discharging", or "Charging".
bat_status=$(cat /sys/class/power_supply/BAT0/status)

if [ $bat_status == "Discharging" ]
then
	bat_emoji="🔋 "
else
	bat_emoji="⚡"
fi

wifi_ssid=$(nmcli d wifi | grep "^\*" | grep -v "\*.*SSID" | awk '{ print $2 }')

wifi_str=$(nmcli d wifi | grep "^\*" | grep -v "\*.*SSID" | awk '{ print $7 }')

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
	
echo │ $wifi_ssid $wifi_symbol │ $bat_emoji$bat_percent% │ $date_formatted │
