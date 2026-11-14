#!/bin/sh
# Cranberry Sauce

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
put_template 0  "63/2b/46"
put_template 1  "d1/7a/88"
put_template 2  "8e/c9/64"
put_template 3  "c9/9f/64"
put_template 4  "74/93/cf"
put_template 5  "cf/74/b8"
put_template 6  "64/c9/b0"
put_template 7  "dc/d4/c7"
put_template 8  "aa/8b/9a"
put_template 9  "df/a2/ac"
put_template 10 "b0/d9/93"
put_template 11 "d9/bc/93"
put_template 12 "9e/b3/dd"
put_template 13 "dd/9e/cd"
put_template 14 "93/d9/c8"
put_template 15 "e7/e1/d8"

color_foreground="f8/ea/d5"
color_background="50/11/2f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8ead5"
  put_template_custom Ph "50112f"
  put_template_custom Pi "e7e1d8"
  put_template_custom Pj "7493cf"
  put_template_custom Pk "50112f"
  put_template_custom Pl "c99f64"
  put_template_custom Pm "50112f"
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
