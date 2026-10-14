#!/bin/bash

# Опции меню
shutdown="  Выключить"
reboot="  Перезагрузить"
lock="  Блокировать"
suspend="  Сон"
logout="  Выйти"

# Список опций
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

# Показываем Rofi
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Меню питания" \
    -theme ~/.config/rofi/powermenu.rasi \
    -selected-row 0)

# Выполняем действие
case "$chosen" in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        hyprlock
        ;;
    $suspend)
        systemctl suspend
        ;;
    $logout)
        hyprctl dispatch exit
        ;;
esac