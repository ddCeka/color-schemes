#!/bin/sh
# Peru Kulli (Dark)

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
put_template 0  "91/6a/97"
put_template 1  "ff/7e/76"
put_template 2  "93/e1/95"
put_template 3  "f4/d6/60"
put_template 4  "80/bd/fb"
put_template 5  "f1/9f/d6"
put_template 6  "73/df/df"
put_template 7  "d7/c8/da"
put_template 8  "ca/ab/cf"
put_template 9  "ff/7e/76"
put_template 10 "93/e1/95"
put_template 11 "f4/d6/60"
put_template 12 "80/bd/fb"
put_template 13 "f1/9f/d6"
put_template 14 "73/df/df"
put_template 15 "f8/ec/e0"

color_foreground="f8/ec/e0"
color_background="48/0f/50"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8ece0"
  put_template_custom Ph "480f50"
  put_template_custom Pi "f8ece0"
  put_template_custom Pj "374573"
  put_template_custom Pk "f8ece0"
  put_template_custom Pl "f4d660"
  put_template_custom Pm "480f50"
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
