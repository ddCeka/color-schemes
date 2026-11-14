#!/bin/sh
# Stranger Theme The Lab

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
put_template 0  "42/45/4e"
put_template 1  "ff/41/36"
put_template 2  "2e/cc/40"
put_template 3  "ff/dc/00"
put_template 4  "7f/db/ff"
put_template 5  "b1/0d/c9"
put_template 6  "39/cc/cc"
put_template 7  "e0/e5/ec"
put_template 8  "73/87/9c"
put_template 9  "ff/5f/54"
put_template 10 "4c/ea/5e"
put_template 11 "ff/fa/1e"
put_template 12 "9d/f9/ff"
put_template 13 "cf/2b/e7"
put_template 14 "57/ea/ea"
put_template 15 "ff/ff/ff"

color_foreground="e0/e5/ec"
color_background="1a/1d/26"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e0e5ec"
  put_template_custom Ph "1a1d26"
  put_template_custom Pi "e0e5ec"
  put_template_custom Pj "3c3f48"
  put_template_custom Pk "e0e5ec"
  put_template_custom Pl "e0e5ec"
  put_template_custom Pm "1a1d26"
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
