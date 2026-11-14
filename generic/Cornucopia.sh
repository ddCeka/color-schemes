#!/bin/sh
# Cornucopia

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
put_template 0  "b1/a6/98"
put_template 1  "dc/96/88"
put_template 2  "96/cf/5e"
put_template 3  "cf/af/5e"
put_template 4  "8b/a9/dd"
put_template 5  "dc/8b/dc"
put_template 6  "5e/cf/a9"
put_template 7  "dc/d4/c7"
put_template 8  "c8/c1/b7"
put_template 9  "e7/b6/ac"
put_template 10 "b6/dd/8e"
put_template 11 "dd/c7/8e"
put_template 12 "ae/c3/e7"
put_template 13 "e7/ae/e7"
put_template 14 "8e/dd/c3"
put_template 15 "e7/e1/d8"

color_foreground="f8/ea/d5"
color_background="28/18/09"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8ead5"
  put_template_custom Ph "281809"
  put_template_custom Pi "e7e1d8"
  put_template_custom Pj "8ba9dd"
  put_template_custom Pk "281809"
  put_template_custom Pl "cfaf5e"
  put_template_custom Pm "281809"
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
