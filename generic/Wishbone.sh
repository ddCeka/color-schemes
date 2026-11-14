#!/bin/sh
# Wishbone

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
put_template 0  "51/48/3d"
put_template 1  "7e/31/26"
put_template 2  "33/60/1d"
put_template 3  "6d/51/21"
put_template 4  "26/43/7e"
put_template 5  "7e/26/6f"
put_template 6  "1d/60/54"
put_template 7  "5e/51/3b"
put_template 8  "3d/36/2e"
put_template 9  "5f/25/1d"
put_template 10 "26/48/16"
put_template 11 "52/3d/19"
put_template 12 "1d/32/5f"
put_template 13 "5f/1d/53"
put_template 14 "16/48/3f"
put_template 15 "47/3d/2c"

color_foreground="30/25/1f"
color_background="ff/fc/ee"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "30251f"
  put_template_custom Ph "fffcee"
  put_template_custom Pi "473d2c"
  put_template_custom Pj "26437e"
  put_template_custom Pk "fffcee"
  put_template_custom Pl "6d5121"
  put_template_custom Pm "fffcee"
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
