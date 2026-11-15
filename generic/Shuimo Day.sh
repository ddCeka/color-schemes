#!/bin/sh
# Shuimo Day

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
put_template 0  "ad/ab/a4"
put_template 1  "b0/3a/2e"
put_template 2  "47/64/44"
put_template 3  "7b/5f/1b"
put_template 4  "3d/5f/7a"
put_template 5  "6e/4e/6b"
put_template 6  "2c/65/65"
put_template 7  "6b/69/63"
put_template 8  "61/5f/59"
put_template 9  "b0/3a/2e"
put_template 10 "47/64/44"
put_template 11 "7b/5f/1b"
put_template 12 "3d/5f/7a"
put_template 13 "6e/4e/6b"
put_template 14 "2c/65/65"
put_template 15 "2a/2a/28"

color_foreground="2a/2a/28"
color_background="f4/f3/ef"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "2a2a28"
  put_template_custom Ph "f4f3ef"
  put_template_custom Pi "2a2a28"
  put_template_custom Pj "d9dee3"
  put_template_custom Pk "2a2a28"
  put_template_custom Pl "b03a2e"
  put_template_custom Pm "f4f3ef"
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
