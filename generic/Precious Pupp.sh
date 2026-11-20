#!/bin/sh
# Precious Pupp

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
put_template 1  "6c/1c/2f"
put_template 2  "1f/41/24"
put_template 3  "57/31/0c"
put_template 4  "14/38/74"
put_template 5  "5c/22/5c"
put_template 6  "05/41/43"
put_template 7  "46/37/2e"
put_template 8  "18/14/17"
put_template 9  "4f/14/22"
put_template 10 "17/2f/1a"
put_template 11 "40/24/09"
put_template 12 "0f/29/55"
put_template 13 "43/19/43"
put_template 14 "04/2f/31"
put_template 15 "33/28/22"

color_foreground="24/1a/22"
color_background="c2/a0/7b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "241a22"
  put_template_custom Ph "c2a07b"
  put_template_custom Pi "332822"
  put_template_custom Pj "143874"
  put_template_custom Pk "fff9ee"
  put_template_custom Pl "5c225c"
  put_template_custom Pm "c2a07b"
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
