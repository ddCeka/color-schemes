#!/bin/sh
# Morocco Majorelle (Dark)

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
put_template 0  "64/71/bc"
put_template 1  "ff/7a/8a"
put_template 2  "86/e0/a0"
put_template 3  "f6/c9/45"
put_template 4  "8f/b0/ff"
put_template 5  "ff/8f/bf"
put_template 6  "4f/e0/d4"
put_template 7  "bf/c6/ee"
put_template 8  "9a/a4/e0"
put_template 9  "ff/7a/8a"
put_template 10 "86/e0/a0"
put_template 11 "f6/c9/45"
put_template 12 "8f/b0/ff"
put_template 13 "ff/8f/bf"
put_template 14 "4f/e0/d4"
put_template 15 "f4/ee/dd"

color_foreground="f4/ee/dd"
color_background="16/1f/66"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f4eedd"
  put_template_custom Ph "161f66"
  put_template_custom Pi "f4eedd"
  put_template_custom Pj "2c3b92"
  put_template_custom Pk "f4eedd"
  put_template_custom Pl "f6c945"
  put_template_custom Pm "161f66"
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
