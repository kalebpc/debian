#! /usr/bin/env bash

######################################################
######################################################
# SCRIPT: install_flatpak.sh
# PURPOSE: Install flatpak.
# AUTHOR: https://github.com/kalebpc
# VERSION: 1.0.0
# DATE: 2026.01.22
######################################################
######################################################
# Copyright (c) 2026 https://github.com/kalebpc

# Permission is hereby granted, free of charge, to any person obtaining a copy of this software
# and associated documentation files (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge, publish, distribute,
# sublicense, and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all copies or substantial
# portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
# NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
######################################################
######################################################

sudo apt update && sudo apt upgrade -y && sudo apt autoremove

sudo apt install flatpak -y

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# reboot
read -p "Reboot required. Do you want to reboot now? (y/n): " yn
case "$yn" in
	[Yy]*) systemctl reboot
	;;
	*) exit 0
	;;
esac

