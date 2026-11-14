#!/bin/sh
# Turkey Trot

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
put_template 0  "b9/af/a3"
put_template 1  "dd/a2/9d"
put_template 2  "9f/c9/64"
put_template 3  "ce/ac/71"
put_template 4  "91/b4/d9"
put_template 5  "dd/9d/cd"
put_template 6  "64/c9/a7"
put_template 7  "dc/d4/c7"
put_template 8  "ce/c7/bf"
put_template 9  "e7/be/ba"
put_template 10 "bc/d9/93"
put_template 11 "dd/c5/9c"
put_template 12 "b2/cb/e4"
put_template 13 "e7/ba/dc"
put_template 14 "93/d9/c1"
put_template 15 "e7/e1/d8"

color_foreground="f8/ea/d5"
color_background="0e/29/22"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8ead5"
  put_template_custom Ph "0e2922"
  put_template_custom Pi "e7e1d8"
  put_template_custom Pj "91b4d9"
  put_template_custom Pk "0e2922"
  put_template_custom Pl "ceac71"
  put_template_custom Pm "0e2922"
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
