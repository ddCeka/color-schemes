#!/bin/sh
# Arabian Knights

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
put_template 0  "21/1b/20"
put_template 1  "8b/24/3c"
put_template 2  "28/55/2f"
put_template 3  "74/41/10"
put_template 4  "16/3f/82"
put_template 5  "6f/29/6f"
put_template 6  "07/55/57"
put_template 7  "4c/3c/32"
put_template 8  "18/14/17"
put_template 9  "65/1a/2c"
put_template 10 "1d/3e/22"
put_template 11 "55/2f/0c"
put_template 12 "10/2e/5f"
put_template 13 "51/1e/51"
put_template 14 "05/3e/40"
put_template 15 "37/2c/25"

color_foreground="24/1a/22"
color_background="ed/cd/9a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "241a22"
  put_template_custom Ph "edcd9a"
  put_template_custom Pi "372c25"
  put_template_custom Pj "163f82"
  put_template_custom Pk "fff9ee"
  put_template_custom Pl "6f296f"
  put_template_custom Pm "edcd9a"
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
