#!/bin/sh
# Holi Night

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
put_template 0  "5f/5a/5e"
put_template 1  "ff/54/68"
put_template 2  "93/d3/8c"
put_template 3  "f5/c8/42"
put_template 4  "72/aa/f6"
put_template 5  "f2/66/9c"
put_template 6  "4f/d0/c2"
put_template 7  "b6/ae/b7"
put_template 8  "98/91/9c"
put_template 9  "ff/54/68"
put_template 10 "93/d3/8c"
put_template 11 "f5/c8/42"
put_template 12 "72/aa/f6"
put_template 13 "f2/66/9c"
put_template 14 "4f/d0/c2"
put_template 15 "ec/e4/da"

color_foreground="ec/e4/da"
color_background="1d/1c/1b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ece4da"
  put_template_custom Ph "1d1c1b"
  put_template_custom Pi "ece4da"
  put_template_custom Pj "3b2d46"
  put_template_custom Pk "ece4da"
  put_template_custom Pl "ff8a3d"
  put_template_custom Pm "1d1c1b"
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
