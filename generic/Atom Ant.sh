#!/bin/sh
# Atom Ant

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
put_template 0  "1f/20/27"
put_template 1  "f8/c6/c9"
put_template 2  "be/de/8b"
put_template 3  "f3/ce/7f"
put_template 4  "be/d4/f7"
put_template 5  "ec/c7/ef"
put_template 6  "a1/de/d3"
put_template 7  "de/d3/c6"
put_template 8  "d2/d2/d4"
put_template 9  "fa/d5/d8"
put_template 10 "d0/e7/aa"
put_template 11 "f6/db/a2"
put_template 12 "d0/e0/f9"
put_template 13 "f1/d6/f3"
put_template 14 "ba/e7/df"
put_template 15 "e7/df/d5"

color_foreground="ff/f3/d9"
color_background="a5/2b/31"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff3d9"
  put_template_custom Ph "a52b31"
  put_template_custom Pi "e7dfd5"
  put_template_custom Pj "f3ce7f"
  put_template_custom Pk "a52b31"
  put_template_custom Pl "ecc7ef"
  put_template_custom Pm "a52b31"
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
