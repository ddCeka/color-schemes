#!/bin/sh
# U.S. Army

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
put_template 0  "1d/25/1d"
put_template 1  "e7/b9/b1"
put_template 2  "ba/ca/95"
put_template 3  "e3/c0/6f"
put_template 4  "af/c6/d9"
put_template 5  "d5/bc/cf"
put_template 6  "a3/cc/bb"
put_template 7  "d1/cd/bb"
put_template 8  "c2/c5/b7"
put_template 9  "f0/b6/a7"
put_template 10 "d0/dd/a9"
put_template 11 "f9/db/94"
put_template 12 "bc/d5/ea"
put_template 13 "e0/c0/d4"
put_template 14 "bc/e2/cd"
put_template 15 "ff/f5/dc"

color_foreground="ef/e8/d3"
color_background="4b/53/20"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "efe8d3"
  put_template_custom Ph "4b5320"
  put_template_custom Pi "fff5dc"
  put_template_custom Pj "fff5dc"
  put_template_custom Pk "4b5320"
  put_template_custom Pl "9bc8b5"
  put_template_custom Pm "4b5320"
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
