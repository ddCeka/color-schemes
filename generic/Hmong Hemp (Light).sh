#!/bin/sh
# Hmong Hemp (Light)

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
put_template 0  "a8/a7/a4"
put_template 1  "a3/20/1e"
put_template 2  "2d/6b/26"
put_template 3  "7a/58/00"
put_template 4  "1f/55/a8"
put_template 5  "8e/2a/90"
put_template 6  "0a/6a/78"
put_template 7  "55/56/5e"
put_template 8  "5d/5c/5f"
put_template 9  "a3/20/1e"
put_template 10 "2d/6b/26"
put_template 11 "7a/58/00"
put_template 12 "1f/55/a8"
put_template 13 "8e/2a/90"
put_template 14 "0a/6a/78"
put_template 15 "30/2e/2b"

color_foreground="30/2e/2b"
color_background="f2/f0/e9"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "302e2b"
  put_template_custom Ph "f2f0e9"
  put_template_custom Pi "302e2b"
  put_template_custom Pj "d3dcf0"
  put_template_custom Pk "302e2b"
  put_template_custom Pl "ad1068"
  put_template_custom Pm "f2f0e9"
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
