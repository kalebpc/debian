#! /usr/bin/env bash

######################################################
######################################################
# SCRIPT: setup_ufw
# PURPOSE: Install and/or configure ufw.
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

[[ $(sudo ufw status) =~ "command not found" ]] && { sudo apt update; sudo apt upgrade -y; sudo apt install ufw -y; } || printf "ufw already installed.\n"

[ $? -gt 0 ] && { printf "Failed trying to upgrade system or installing 'ufw'.\n\nExit: '%d'\n\n" $? ; exit 1; }

# match returns 1 as exit code when no match is found
[[ $(sudo ufw status) =~ "inactive" ]] && { ! [[ $(sudo ufw enable) =~ "Firewall is active and enabled" ]] && { printf "Failed to enable firewall.\n\nExit: '%d'\n\n" $?; exit 1; } || { printf "Firewall is active and enabled.\n\nExit: '0'\n\n"; }; } || { printf "Firewall is active and enabled.\n\nExit: '0'\n\n"; }

