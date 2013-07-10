# BUC Customizer
#
# Copyright (C) 2011-2012 Gunnar Hjalmarsson
# Copyright (C) 2012 Andrea Colangelo
#
# Authors: Gunnar Hjalmarsson
#          Andrea Colangelo <warp10@ubuntu.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 3 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see: http://www.gnu.org/licenses/gpl-3.0.txt
#
####
#
# The commands below shall be read and executed by /usr/sbin/guest-account.
# They set local guest session preferences in addition to what else is
# done in /usr/sbin/guest-account.
#
# While the $USER variable is guest-??????, the process is owned by root.

# function for disabling services
disable_app() {
    if [ -f $2/$1 ]; then
        cd $2
        cp $1 $HOME/.config/autostart
        echo "X-GNOME-Autostart-enabled=false" >> $HOME/.config/autostart/$1
    fi
}

# disable login-sound
disable_app libcanberra-login-sound.desktop /usr/share/gnome/autostart

# disable Mail Notification
disable_app mail-notification.desktop /usr/share/applications

# run the commands in /etc/guest-session/auto.sh via autostart
echo "[Desktop Entry]\nType=Application\nName=Misc. startup preferences\n\
Exec=/usr/lib/lightdm/guest-session-auto\nNoDisplay=true" \
> $HOME/.config/autostart/misc-preferences.desktop

chown $USER:$USER $HOME/.config/autostart/*

# prepare for setting Firefox user prefs
profiledir="$HOME/.mozilla/firefox"
mkdir -p $profiledir/JlplCMtb.default
echo "[General]\nStartWithLastProfile=1\n\n[Profile0]\nName=default\n\
IsRelative=1\nPath=JlplCMtb.default\n" > $profiledir/profiles.ini
profiledir="$profiledir/JlplCMtb.default"
touch $profiledir/user.js
chown -R $USER:$USER $HOME/.mozilla
chmod -R go-rwx $HOME/.mozilla

# no Firefox prompts about remembering password
echo 'user_pref("signon.rememberSignons", false);' >> $profiledir/user.js

# set Firefox startpage
echo 'user_pref("browser.startup.homepage", "/usr/share/buc/home.html");' >> $profiledir/user.js

