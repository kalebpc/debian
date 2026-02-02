#! /usr/bin/env bash

######################################################
######################################################
# SCRIPT: new_script
# PURPOSE: Create base file with header lines and MIT Copyright License.
# AUTHOR: https://github.com/kalebpc
# VERSION: 1.0.0
# DATE: 2026.01.25
######################################################
######################################################
# Copyright (c) 2026 https://github.com/kalebpc
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software
# and associated documentation files (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge, publish, distribute,
# sublicense, and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial
# portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
# NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
######################################################
######################################################

## n <string> 		Name of new script.
## p <string> 		Optional: Purpose of new script. What does the code do.
## d [<string>]		Optional: Destination/Path to directory for new script. Will make new file in current directory if ommitted.

function set_opts () {
	while getopts ":n:p:d:" opt; do
		case $opt in
			# Script name
			n) NAME=$(awk '{$1=$1}1' <<<"$OPTARG"); [[ "$NAME" == "" ]] && { printf "Error: -n requires an argument.\n" >&2; exit 1; }
			;;
			# Purpose
			p) PURPOSE=$(awk '{$1=$1}1' <<<"$OPTARG"); [[ "$PURPOSE" == "" ]] && PURPOSE="<script description>"
			;;
			# Destination
			d) DEST=$(awk '{$1=$1}1' <<<"$OPTARG"); [[ "$DEST" == "" ]] && { printf "Error: -d requires an argument.\n" >&2; exit 1; }
			;;
			\?) echo "Invalid option argument -$OPTARG" >&2; exit 1
			;;
		esac
		case "$OPTARG" in
			-*) echo "Invalid option argument -$opt='$OPTARG'" >&2; exit 1
			;;
		esac
	done
}

function user_prompt () {
	read -p "$1 (y/n): " answer
	case "$answer" in
		[Yy]*) return 0
		;;
		*) return 1
		;;
	esac
}

function user_verify () {
	echo "[name       ] '$NAME'"
	echo "[purpose    ] '$PURPOSE'"
	echo "[new file   ] '$DEST'"
	return $(user_prompt "Does this look right?")
}

function create_file () {
	local tmp="$(basename "$NAME")"
	cat <<EOF > $DEST
#! /usr/bin/env bash

######################################################
######################################################
# SCRIPT: $tmp
# PURPOSE: $PURPOSE
# AUTHOR: https://github.com/kalebpc
# VERSION: 1.0.0
# DATE: $(date +"%Y.%m.%d")
######################################################
######################################################
# Copyright (c) $(date +"%Y") https://github.com/kalebpc
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software
# and associated documentation files (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge, publish, distribute,
# sublicense, and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial
# portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
# NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
######################################################
######################################################


EOF
	[ $? -eq 0 ] && printf "File created at '%s'.\n" "$DEST" || printf "Failed creating file.\n"
}

function main () {
	local NAME PURPOSE DEST
	set_opts "$@"
	if [ -d "$DEST" ]; then
		[[ "${DEST: -1}" == "/" ]] && DEST="${DEST%/}/${NAME}" || DEST="${DEST}/${NAME}"
	else
		printf "\n\nSystem cannot find '%s'.\n\n" "$DEST"
		DEST="$NAME"
	fi
	if user_verify; then
		if [ -f "$DEST" ]; then
			if $(user_prompt "'$DEST' already exists! Do you want to overwrite it?"); then create_file; else exit 1; fi
		else
			create_file
		fi
	fi
}
main "$@"

