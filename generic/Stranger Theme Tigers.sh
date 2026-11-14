#!/bin/sh
# Stranger Theme Tigers

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
put_template 0  "40/46/40"
put_template 1  "cc/66/66"
put_template 2  "b5/bd/68"
put_template 3  "f0/c6/74"
put_template 4  "81/a2/be"
put_template 5  "b2/94/bb"
put_template 6  "8a/be/b7"
put_template 7  "f5/f5/f5"
put_template 8  "75/89/75"
put_template 9  "ea/84/84"
put_template 10 "d3/db/86"
put_template 11 "ff/e4/92"
put_template 12 "9f/c0/dc"
put_template 13 "d0/b2/d9"
put_template 14 "a8/dc/d5"
put_template 15 "ff/ff/ff"

color_foreground="f5/f5/f5"
color_background="18/1e/18"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f5f5f5"
  put_template_custom Ph "181e18"
  put_template_custom Pi "f5f5f5"
  put_template_custom Pj "38463a"
  put_template_custom Pk "f5f5f5"
  put_template_custom Pl "f5f5f5"
  put_template_custom Pm "181e18"
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
