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
# The commands below shall be read and executed by
# /usr/lib/lightdm/guest-session-auto when the latter has been
# autostarted at the end of a guest session launch process.
#
# At this stage the process is owned by user guest-??????.

# One guest-session-prefs-lightdm.mo file for each applicable language
# is needed for translation of gettexted strings.
export TEXTDOMAINDIR=/etc/guest-session
export TEXTDOMAIN=guest-session-prefs-lightdm

# An established textdomain is used to translate 'Desktop', since the
# shortcut below requires that string to be translated.
alias getstr='gettext'  # prevents that xgettext gets confused
desktop=$(getstr --domain=xdg-user-dirs 'Desktop')

# make the info dialog window become on focus
sleep 2

# info dialog
title=$(gettext 'Attenzione: sessione ospite')
text=$(gettext 'Questa è una sessione ospite. Tutti i dati saranno eliminati
automaticamente dopo la chiusura della sessione. Se intendi preservare i tuoi
documenti, assicurati di salvarli su una chiavetta.')
test -w /var/guest-data && text="$text"
zenity --warning --title="$title" --text="$text" &

# Automatic logout
shut
