#! /bin/bash

# Styles
S_RESET=0
S_BOLD=1
S_DIM=2
S_UNDERLINED=4
S_BLINK=5
S_REVERSE=7
S_HIDDEN=8
# Foreground colors
FG_DEFAULT=39
FG_BLACK=30
FG_RED=31
FG_GREEN=32
FG_YELLOW=33
FG_BLUE=34
FG_MAGENTA=35
FG_CYAN=36
FG_DARK_GRAY=90
# Background colors
BG_DEFAULT=49
BG_BLACK=40
BG_RED=41
BG_GREEN=42
BG_YELLOW=43
BG_BLUE=44
BG_MAGENTA=45
BG_CYAN=46
BG_DARK_GRAY=100

function format_text () {
  echo "\e[${3:-$S_RESET};${2:-$BG_DEFAULT};${1:-$FG_DEFAULT}m"
}

function info () {
  echo -e "$(format_text $FG_GREEN $BG_DEFAULT $S_BOLD)[ INFO ]$(format_text) ${1}"
}

function warn () {
  echo -e "$(format_text $FG_BLACK $BG_YELLOW $S_BOLD)[ WARN ]$(format_text) ${1}"
}

function fail () {
  echo -e "$(format_text $FG_BLACK $BG_RED $S_BOLD)[ FAIL ]$(format_text) ${1}"
}
