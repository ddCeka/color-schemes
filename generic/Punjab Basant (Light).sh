#!/bin/sh
# Punjab Basant (Light)

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
put_template 0  "a1/a2/85"
put_template 1  "b0/20/2e"
put_template 2  "3a/70/18"
put_template 3  "7a/52/00"
put_template 4  "1f/55/a8"
put_template 5  "a3/20/7a"
put_template 6  "00/75/6e"
put_template 7  "55/56/4a"
put_template 8  "5b/5f/4a"
put_template 9  "b0/20/2e"
put_template 10 "3a/70/18"
put_template 11 "7a/52/00"
put_template 12 "1f/55/a8"
put_template 13 "a3/20/7a"
put_template 14 "00/75/6e"
put_template 15 "22/24/1a"

color_foreground="22/24/1a"
color_background="f8/f1/d2"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "22241a"
  put_template_custom Ph "f8f1d2"
  put_template_custom Pi "22241a"
  put_template_custom Pj "d6e4f5"
  put_template_custom Pk "22241a"
  put_template_custom Pl "b04600"
  put_template_custom Pm "f8f1d2"
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
