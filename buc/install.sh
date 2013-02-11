#!/bin/sh -e

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

umask 0022

mkdir -p /etc/guest-session/sv/LC_MESSAGES \
/usr/share/doc/lightdm/guest-session-prefs-lightdm

# ensure that current directory is the directory where this file is located
cd $( dirname $0 )

cp -n --preserve=timestamps prefs.sh auto.sh /etc/guest-session

cp --preserve=timestamps README /usr/share/doc/lightdm/guest-session-prefs-lightdm

cp --preserve=timestamps guest-session-auto /usr/lib/lightdm

cp shut.py /usr/bin

cp shut.svg /usr/share/icons/hicolor/scalable/apps

chmod a+x /usr/lib/lightdm/guest-session-auto
