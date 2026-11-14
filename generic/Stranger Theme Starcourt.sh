#!/bin/sh
# Stranger Theme Starcourt

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
put_template 0  "42/42/56"
put_template 1  "ff/6b/6b"
put_template 2  "00/fa/9a"
put_template 3  "ff/d7/00"
put_template 4  "ba/55/d3"
put_template 5  "ff/14/93"
put_template 6  "00/ce/d1"
put_template 7  "ea/ea/ea"
put_template 8  "8c/77/c3"
put_template 9  "ff/89/89"
put_template 10 "1e/ff/b8"
put_template 11 "ff/f5/1e"
put_template 12 "d8/73/f1"
put_template 13 "ff/32/b1"
put_template 14 "1e/ec/ef"
put_template 15 "ff/ff/ff"

color_foreground="ea/ea/ea"
color_background="1a/1a/2e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "eaeaea"
  put_template_custom Ph "1a1a2e"
  put_template_custom Pi "eaeaea"
  put_template_custom Pj "3d3d66"
  put_template_custom Pk "eaeaea"
  put_template_custom Pl "eaeaea"
  put_template_custom Pm "1a1a2e"
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
