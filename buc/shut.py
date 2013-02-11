#!/usr/bin/python

# BUC Customizer
#
# Copyright (C) 2012 Andrea Colangelo
#
# Authors: Andrea Colangelo <warp10@ubuntu.com>
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


from gi.repository import AppIndicator3 as appindicator
from gi.repository import Gtk
from gi.repository import GLib
from gi.repository import Notify
from os import system
from time import time, sleep


class Shut():
    def __init__(self):
        self.start = time()

        self.show_notice_30()
        GLib.timeout_add_seconds(1200, self.show_notice_10)
        GLib.timeout_add_seconds(1740, self.show_notice_1)
        GLib.timeout_add_seconds(1800, self.show_notice_0)

        self.load_indicator()

    def load_indicator(self):
        ind = appindicator.Indicator.new("shut",
                             "/usr/share/icons/hicolor/scalable/apps/shut.svg",
                             appindicator.IndicatorCategory.APPLICATION_STATUS)
        ind.set_status(appindicator.IndicatorStatus.ACTIVE)

        menu = Gtk.Menu()

        buf = "Termina sessione"
        menu_items = Gtk.MenuItem(buf)
        menu.append(menu_items)
        menu_items.connect("activate", self.logout, buf)
        menu_items.show()

        buf = "Minuti disponibili"
        menu_items = Gtk.MenuItem(buf)
        menu.append(menu_items)
        menu_items.connect("activate", self.remaining, buf)
        menu_items.show()

        menu_items = Gtk.SeparatorMenuItem()
        menu.append(menu_items)
        menu_items.show()

        buf = "Info"
        menu_items = Gtk.MenuItem(buf)
        menu.append(menu_items)
        menu_items.connect("activate", self.about, buf)
        menu_items.show()

        #buf = "Chiudi"
        #menu_items = Gtk.MenuItem(buf)
        #menu.append(menu_items)
        #menu_items.connect("activate", Gtk.main_quit, buf)
        #menu_items.show()

        menu.show()

        ind.set_menu(menu)

        Gtk.main()

    def show_notice_30(self):
        notice = "Questa sessione sara' terminata automaticamente tra 30 minuti."
        self.show_notice(notice)
        return False

    def show_notice_10(self):
        notice = "Questa sessione sara' terminata automaticamente tra 10 minuti."
        self.show_notice(notice)
        return False

    def show_notice_1(self):
        notice = "Questa sessione sara' terminata automaticamente tra 1 minuto. \
                  Concludi il lavoro in corso e salva i tuoi documenti. "
        self.show_notice(notice)
        return False

    def show_notice_0(self):
        notice = "Chiusura della sessione in corso!"
        self.show_notice(notice)
        sleep(5)
        self.logout()

    def remaining(self, *args):
        elapsed_seconds = int(time() - self.start)
        remaining_minutes = (1800 - elapsed_seconds) / 60
        notice = "Restano " + str(remaining_minutes) + " minuti disponibili"
        self.show_notice(notice, header="Tempo disponibile")

    def show_notice(self, notice, header="Avviso: chiusura sessione"):
        icon = ""  # TODO
        Notify.init('Shut')
        n = Notify.Notification.new(header, "\n" + notice, icon)
        n.show()

    def logout(self, *args):
        cmd = "dbus-send --session --type=method_call --dest=org.gnome.SessionManager /org/gnome/SessionManager org.gnome.SessionManager.Logout uint32:1"
        system(cmd)

    def about(self, *args):
        a = Gtk.AboutDialog()
        a.set_program_name("Shut")
        a.set_comments("Tool to Logout User")
        a.set_version("0.1")
        a.set_copyright("Copyright (C) 2012-2013 Andrea Colangelo")
        a.set_license_type(Gtk.License.GPL_3_0)
        a.set_website("http://www.linuxfm.org")
        a.set_artists(["Marco Alici", "Copyright (C) 2013 Marco Alici", "Released under the terms of CC-BY-SA 3.0, see:", "http://creativecommons.org/licenses/by-sa/3.0/"])
        a.run()
        a.destroy()

if __name__ == '__main__':
    shut = Shut()
