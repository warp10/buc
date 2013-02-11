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


rm -f /usr/bin/shut.py

rm -f /usr/share/icons/hicolor/scalable/apps/shut.svg

rm -f /usr/lib/lightdm/guest-session-auto

rm -rf /etc/guest-session \
/usr/share/doc/lightdm/guest-session-prefs-lightdm
