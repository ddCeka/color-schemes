#!/bin/sh
# Bingo

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
put_template 1  "5a/17/27"
put_template 2  "1a/36/1e"
put_template 3  "48/29/0a"
put_template 4  "10/2f/60"
put_template 5  "4d/1d/4d"
put_template 6  "04/36/38"
put_template 7  "3a/2e/26"
put_template 8  "18/14/17"
put_template 9  "42/11/1c"
put_template 10 "13/27/16"
put_template 11 "35/1e/07"
put_template 12 "0c/22/46"
put_template 13 "38/15/38"
put_template 14 "03/27/29"
put_template 15 "2a/22/1c"

color_foreground="24/1a/22"
color_background="e8/7e/20"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "241a22"
  put_template_custom Ph "e87e20"
  put_template_custom Pi "2a221c"
  put_template_custom Pj "102f60"
  put_template_custom Pk "fff9ee"
  put_template_custom Pl "4d1d4d"
  put_template_custom Pm "e87e20"
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
