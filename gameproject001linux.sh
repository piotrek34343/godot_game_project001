#!/bin/sh
printf '\033c\033]0;%s\a' Game_project001
base_path="$(dirname "$(realpath "$0")")"
"$base_path/gameproject001linux.x86_64" "$@"
