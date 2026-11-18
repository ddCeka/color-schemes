#!/bin/sh
# Grand Terminal

# source for these helper functions:
# https://github.com/chriskempson/base16-shell/blob/master/templates/default.mustache
if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  "3d/2c/40"
put_template 1  "d5/8d/91"
put_template 2  "a6/ba/90"
put_template 3  "dc/b6/7a"
put_template 4  "9e/af/cb"
put_template 5  "c8/9d/ba"
put_template 6  "8d/bd/b6"
put_template 7  "cd/bf/af"
put_template 8  "a2/8e/9f"
put_template 9  "ec/b0/ac"
put_template 10 "c6/d5/aa"
put_template 11 "f1/d1/9e"
put_template 12 "bf/cd/e5"
put_template 13 "e2/bd/d3"
put_template 14 "b0/db/ce"
put_template 15 "ff/f0/d9"

color_foreground="e9/df/cf"
color_background="29/1d/2d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e9dfcf"
  put_template_custom Ph "291d2d"
  put_template_custom Pi "fff0d9"
  put_template_custom Pj "594454"
  put_template_custom Pk "fff0d9"
  put_template_custom Pl "dcb67a"
  put_template_custom Pm "291d2d"
else
  put_template_var 10 $color_foreground
  put_template_var 11 $color_background
  if [ "${TERM%%-*}" = "rxvt" ]; then
    put_template_var 708 $color_background # internal border (rxvt)
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom

unset color_foreground
unset color_background
