#!/bin/sh
# Sardinia Orbace (Dark)

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
put_template 0  "5e/58/52"
put_template 1  "f0/7e/70"
put_template 2  "95/d2/7e"
put_template 3  "f0/b2/3e"
put_template 4  "7f/b0/f5"
put_template 5  "d7/95/d8"
put_template 6  "6d/cf/d8"
put_template 7  "ad/a6/9b"
put_template 8  "98/8f/83"
put_template 9  "f0/7e/70"
put_template 10 "95/d2/7e"
put_template 11 "f0/b2/3e"
put_template 12 "7f/b0/f5"
put_template 13 "d7/95/d8"
put_template 14 "6d/cf/d8"
put_template 15 "d3/cc/c1"

color_foreground="d3/cc/c1"
color_background="1a/18/17"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d3ccc1"
  put_template_custom Ph "1a1817"
  put_template_custom Pi "d3ccc1"
  put_template_custom Pj "2c3854"
  put_template_custom Pk "d3ccc1"
  put_template_custom Pl "f0b23e"
  put_template_custom Pm "1a1817"
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
