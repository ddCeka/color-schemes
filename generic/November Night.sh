#!/bin/sh
# November Night

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
put_template 0  "b3/a7/9a"
put_template 1  "da/99/83"
put_template 2  "96/cf/5e"
put_template 3  "cf/a9/5e"
put_template 4  "81/ad/d9"
put_template 5  "dd/8e/d0"
put_template 6  "5e/cf/b3"
put_template 7  "dc/d4/c7"
put_template 8  "ca/c1/b8"
put_template 9  "e5/b8/a8"
put_template 10 "b6/dd/8e"
put_template 11 "dd/c3/8e"
put_template 12 "a7/c6/e4"
put_template 13 "e7/b0/de"
put_template 14 "8e/dd/ca"
put_template 15 "e7/e1/d8"

color_foreground="f8/ea/d5"
color_background="10/1c/32"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8ead5"
  put_template_custom Ph "101c32"
  put_template_custom Pi "e7e1d8"
  put_template_custom Pj "81add9"
  put_template_custom Pk "101c32"
  put_template_custom Pl "cfa95e"
  put_template_custom Pm "101c32"
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
