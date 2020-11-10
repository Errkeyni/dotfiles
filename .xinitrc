# wal -r
# wal -i "$(< "${HOME}/.cache/wal/wal")"

setxkbmap -layout us,ru
setxkbmap -option 'grp:alt_shift_toggle'
     
# xrdb -load ~/.config/colors.Xresources
exec dbus-launch i3
exec twmnd
