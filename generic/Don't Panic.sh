#!/bin/sh
# Don't Panic

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
put_template 0  "23/31/4b"
put_template 1  "f1/8d/87"
put_template 2  "ad/d8/67"
put_template 3  "ea/cb/64"
put_template 4  "83/ad/f0"
put_template 5  "df/95/ce"
put_template 6  "72/cc/c0"
put_template 7  "be/cf/c6"
put_template 8  "82/93/ab"
put_template 9  "ff/b1/a1"
put_template 10 "cd/f6/8c"
put_template 11 "ff/e5/98"
put_template 12 "b0/cc/ff"
put_template 13 "f6/b8/e5"
put_template 14 "a0/ea/db"
put_template 15 "f1/f5/db"

color_foreground="d2/e7/c7"
color_background="0d/19/30"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d2e7c7"
  put_template_custom Ph "0d1930"
  put_template_custom Pi "f1f5db"
  put_template_custom Pj "34506a"
  put_template_custom Pk "f1f5db"
  put_template_custom Pl "72ccc0"
  put_template_custom Pm "0d1930"
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
