#!/bin/sh
# Stone

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
put_template 0  "19/1c/1a"
put_template 1  "c2/9b/91"
put_template 2  "ae/b5/9a"
put_template 3  "c3/b3/8d"
put_template 4  "9f/af/b9"
put_template 5  "b3/a2/ae"
put_template 6  "9f/b5/ae"
put_template 7  "c6/c5/bd"
put_template 8  "97/9b/94"
put_template 9  "d1/ad/a3"
put_template 10 "c1/c7/ac"
put_template 11 "d4/c5/a1"
put_template 12 "b3/c1/ca"
put_template 13 "c4/b4/bf"
put_template 14 "b2/c8/c0"
put_template 15 "ec/ea/e3"

color_foreground="de/dc/d5"
color_background="4e/4f/4e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dedcd5"
  put_template_custom Ph "4e4f4e"
  put_template_custom Pi "eceae3"
  put_template_custom Pj "b6b8aa"
  put_template_custom Pk "2b2e2b"
  put_template_custom Pl "d8d3c4"
  put_template_custom Pm "2b2e2b"
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
