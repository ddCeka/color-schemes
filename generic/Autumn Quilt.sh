#!/bin/sh
# Autumn Quilt

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
put_template 0  "b2/a6/99"
put_template 1  "d7/9e/8b"
put_template 2  "9c/d3/80"
put_template 3  "d0/b7/79"
put_template 4  "90/a9/d8"
put_template 5  "d1/7c/bc"
put_template 6  "7f/d2/be"
put_template 7  "dc/d4/c7"
put_template 8  "c9/c1/b8"
put_template 9  "e3/bb/ae"
put_template 10 "ba/e0/a6"
put_template 11 "de/cd/a1"
put_template 12 "b1/c3/e4"
put_template 13 "df/a3/d0"
put_template 14 "a5/e0/d2"
put_template 15 "e7/e1/d8"

color_foreground="f8/ea/d5"
color_background="35/2a/45"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8ead5"
  put_template_custom Ph "352a45"
  put_template_custom Pi "e7e1d8"
  put_template_custom Pj "90a9d8"
  put_template_custom Pk "352a45"
  put_template_custom Pl "d0b779"
  put_template_custom Pm "352a45"
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
