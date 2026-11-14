#!/bin/sh
# U.S. Marine Corps

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
put_template 0  "30/0b/0d"
put_template 1  "f5/ac/a1"
put_template 2  "bd/da/a3"
put_template 3  "f5/d1/6d"
put_template 4  "b6/c9/ef"
put_template 5  "e7/b1/d6"
put_template 6  "b7/dd/da"
put_template 7  "ea/d6/c5"
put_template 8  "d1/b5/b2"
put_template 9  "ff/d0/bc"
put_template 10 "df/ed/c8"
put_template 11 "ff/e8/a1"
put_template 12 "d5/e0/ff"
put_template 13 "f9/d6/ef"
put_template 14 "d6/f3/ec"
put_template 15 "ff/fa/ef"

color_foreground="ff/f0/d8"
color_background="99/00/00"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0d8"
  put_template_custom Ph "990000"
  put_template_custom Pi "fffaef"
  put_template_custom Pj "fffaef"
  put_template_custom Pk "990000"
  put_template_custom Pl "b7ddda"
  put_template_custom Pm "990000"
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
