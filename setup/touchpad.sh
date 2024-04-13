sudo touch /etc/X11/xorg.conf.d/30-touchpad.conf


cat # Section "InputClass"
cat #     Identifier "touchpad"
cat #     Driver "libinput"
cat #     MatchIsTouchpad "on"
cat #     Option "Tapping" "on"
cat #     Option "TappingButtonMap" "lmr"
cat #     Option "NaturalScrolling" "true"
cat # EndSection

Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "TappingButtonMap" "lmr"
    Option "NaturalScrolling" "true"
EndSection
