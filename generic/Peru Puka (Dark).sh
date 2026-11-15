#!/bin/sh
# Peru Puka (Dark)

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
put_template 0  "a0/66/7d"
put_template 1  "ff/9e/96"
put_template 2  "97/ed/9a"
put_template 3  "f4/e3/82"
put_template 4  "92/c9/ff"
put_template 5  "e8/b6/f3"
put_template 6  "7a/e6/e5"
put_template 7  "e9/d0/d8"
put_template 8  "d8/a8/b9"
put_template 9  "ff/9e/96"
put_template 10 "97/ed/9a"
put_template 11 "f4/e3/82"
put_template 12 "92/c9/ff"
put_template 13 "e8/b6/f3"
put_template 14 "7a/e6/e5"
put_template 15 "f8/ec/e0"

color_foreground="f8/ec/e0"
color_background="72/00/41"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8ece0"
  put_template_custom Ph "720041"
  put_template_custom Pi "f8ece0"
  put_template_custom Pj "414f7f"
  put_template_custom Pk "f8ece0"
  put_template_custom Pl "97ed9a"
  put_template_custom Pm "720041"
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
