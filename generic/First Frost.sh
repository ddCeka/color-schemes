#!/bin/sh
# First Frost

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
put_template 1  "83/21/31"
put_template 2  "23/5d/18"
put_template 3  "69/4c/1b"
put_template 4  "21/49/83"
put_template 5  "83/21/83"
put_template 6  "17/5b/50"
put_template 7  "5c/4f/3a"
put_template 8  "3d/36/2e"
put_template 9  "62/19/25"
put_template 10 "1a/46/12"
put_template 11 "4f/39/14"
put_template 12 "19/37/62"
put_template 13 "62/19/62"
put_template 14 "11/44/3c"
put_template 15 "45/3b/2c"

color_foreground="30/25/1f"
color_background="ed/f5/f4"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "30251f"
  put_template_custom Ph "edf5f4"
  put_template_custom Pi "453b2c"
  put_template_custom Pj "214983"
  put_template_custom Pk "edf5f4"
  put_template_custom Pl "694c1b"
  put_template_custom Pm "edf5f4"
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
