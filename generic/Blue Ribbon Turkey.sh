#!/bin/sh
# Blue Ribbon Turkey

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
put_template 0  "af/a3/96"
put_template 1  "d9/9e/80"
put_template 2  "ab/d5/71"
put_template 3  "d5/b3/71"
put_template 4  "77/9e/d6"
put_template 5  "d5/71/bc"
put_template 6  "62/d0/b5"
put_template 7  "dc/d4/c7"
put_template 8  "c7/bf/b6"
put_template 9  "e4/bb/a6"
put_template 10 "c4/e2/9c"
put_template 11 "e2/ca/9c"
put_template 12 "a0/bb/e2"
put_template 13 "e2/9c/d0"
put_template 14 "91/de/cb"
put_template 15 "e7/e1/d8"

color_foreground="f8/ea/d5"
color_background="17/2c/46"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8ead5"
  put_template_custom Ph "172c46"
  put_template_custom Pi "e7e1d8"
  put_template_custom Pj "779ed6"
  put_template_custom Pk "172c46"
  put_template_custom Pl "d5b371"
  put_template_custom Pm "172c46"
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
