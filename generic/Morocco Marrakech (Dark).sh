#!/bin/sh
# Morocco Marrakech (Dark)

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
put_template 0  "9a/6c/5a"
put_template 1  "ff/a0/a0"
put_template 2  "a6/e6/a0"
put_template 3  "ff/d8/4d"
put_template 4  "8f/c6/ff"
put_template 5  "f5/a3/c0"
put_template 6  "5f/dd/d2"
put_template 7  "d8/bf/b0"
put_template 8  "d0/a5/93"
put_template 9  "ff/a0/a0"
put_template 10 "a6/e6/a0"
put_template 11 "ff/d8/4d"
put_template 12 "8f/c6/ff"
put_template 13 "f5/a3/c0"
put_template 14 "5f/dd/d2"
put_template 15 "f7/ed/de"

color_foreground="f7/ed/de"
color_background="4f/1d/14"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f7edde"
  put_template_custom Ph "4f1d14"
  put_template_custom Pi "f7edde"
  put_template_custom Pj "374a50"
  put_template_custom Pk "f7edde"
  put_template_custom Pl "ffd84d"
  put_template_custom Pm "4f1d14"
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
