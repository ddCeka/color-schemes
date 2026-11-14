#!/bin/sh
# Leftover Sandwich

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
put_template 1  "7e/26/34"
put_template 2  "3e/74/23"
put_template 3  "78/59/24"
put_template 4  "26/4a/7e"
put_template 5  "7e/26/68"
put_template 6  "23/73/5f"
put_template 7  "5e/51/3b"
put_template 8  "3d/36/2e"
put_template 9  "5f/1d/27"
put_template 10 "2f/57/1a"
put_template 11 "5a/43/1b"
put_template 12 "1d/38/5f"
put_template 13 "5f/1d/4e"
put_template 14 "1a/56/47"
put_template 15 "47/3d/2c"

color_foreground="30/25/1f"
color_background="f6/e8/cf"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "30251f"
  put_template_custom Ph "f6e8cf"
  put_template_custom Pi "473d2c"
  put_template_custom Pj "264a7e"
  put_template_custom Pk "f6e8cf"
  put_template_custom Pl "785924"
  put_template_custom Pm "f6e8cf"
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
