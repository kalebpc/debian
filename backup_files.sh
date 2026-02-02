#! /usr/bin/env bash

######################################################
######################################################
# SCRIPT: backup_files.sh
# PURPOSE: Use rsync to copy files from list of dirs in BACKUPDIRS to BACKUPDRIVE.
# AUTHOR: https://github.com/kalebpc
# VERSION: 1.0.0
# DATE: 2026.01.21
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

BACKUPDIRQUALIFIER="$HOME"
BACKUPLISTFILE="backup_list.txt"
[ -f "$BACKUPLISTFILE" ] && mapfile -t BACKUPDIRS < "$BACKUPLISTFILE" || exit 1
SYSTEM="debian"
BACKUPDRIVE="/media/$USER/256 gb"
LOGFILE="${BACKUPDIRQUALIFIER}/Logs/rsync_system_backup.log"

BACKUPPATH="${BACKUPDRIVE}/${SYSTEM}_backup"

# Checking existence of backupdrive.
[ -d "$BACKUPDRIVE" ] && printf "Backup drive exists.\nStarting backup...\n" || { printf "System could not locate '%s'.\n\nExit: '%d'\n\n" "$BACKUPDRIVE" $?; exit 1; }

# Checking existence of backup directory on backupdrive.
! [ -d "$BACKUPPATH" ] && { printf "Backup directory does not exist.\nCreating '%s'...\n" "$BACKUPPATH"; mkdir "$BACKUPPATH"; [ $? -gt 0 ] && printf "Error creating '%s'\n\nExit: '%d'\n\n" "$BACKUPPATH" $?; exit 1; } || printf "Backup folder exists.\n"

for dir in "${BACKUPDIRS[@]}"; do
	[ "$dir" == "" ] && continue
	#echo "dir: '$dir'"; continue #testing
	source="${BACKUPDIRQUALIFIER}/${dir}/"
	dest="${BACKUPPATH}/${dir}"
	! [ -f "$LOGFILE" ] && { [ -d $(dirname "$LOGFILE") ] && mkdir -p $(dirname "$LOGFILE"); touch "$LOGFILE"; [ $? -ne 0 ] && { printf "Failed creating log file.\n\nExit: '%d'\n\n" $?; exit 1; }; }
	! [ -d "$dest" ] && mkdir -p "$dest"
	if [ -d "$dest" ]; then
		[ -d "$source" ] && { rsync -ruPavh "$source" "$dest" --log-file="$LOGFILE"; continue; } || printf "System could not locate '%s'.\n" "$source"
	else
		printf "System could not locate '%s'.\n" "$dest"
	fi
done

