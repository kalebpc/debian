#! /usr/bin/env bash

######################################################
######################################################
# SCRIPT: flatpak_run_handbrake_gui.sh
# PURPOSE: Run handbrake gui.
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

# GUI
flatpak run fr.handbrake.ghb

# Command line
# flatpak run --command=HandBrakeCLI fr.handbrake.ghb --preset-import-gui -Z "MY_PRESET" -i "" -o ""

