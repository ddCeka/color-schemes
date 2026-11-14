#!/bin/sh
# Tideglass

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
put_template 0  "23/34/3d"
put_template 1  "e5/8e/8e"
put_template 2  "91/c6/a2"
put_template 3  "d9/bd/83"
put_template 4  "91/a9/e8"
put_template 5  "c4/a1/d9"
put_template 6  "7b/c5/c3"
put_template 7  "c5/d4/d5"
put_template 8  "7e/96/9d"
put_template 9  "f5/ad/aa"
put_template 10 "b1/dd/b8"
put_template 11 "f0/d6/a1"
put_template 12 "b0/c3/ff"
put_template 13 "dc/c0/ed"
put_template 14 "a0/df/d8"
put_template 15 "f0/f6/f2"

color_foreground="dc/e8/e6"
color_background="10/1e/26"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dce8e6"
  put_template_custom Ph "101e26"
  put_template_custom Pi "f0f6f2"
  put_template_custom Pj "304d5a"
  put_template_custom Pk "f0f6f2"
  put_template_custom Pl "7bc5c3"
  put_template_custom Pm "101e26"
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
