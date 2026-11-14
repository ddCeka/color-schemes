#!/bin/sh
# U.S. Navy

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
put_template 0  "08/1c/26"
put_template 1  "eb/9c/91"
put_template 2  "a6/cc/ad"
put_template 3  "e6/c4/75"
put_template 4  "9c/bc/e8"
put_template 5  "c9/ac/d6"
put_template 6  "85/cc/d0"
put_template 7  "c7/d9/dc"
put_template 8  "94/ac/b4"
put_template 9  "ff/bc/ae"
put_template 10 "cb/e5/c7"
put_template 11 "ff/e2/a1"
put_template 12 "c5/dc/fa"
put_template 13 "e6/c9/ed"
put_template 14 "b5/e8/e6"
put_template 15 "ff/f7/e4"

color_foreground="e5/ec/ed"
color_background="03/28/5c"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e5eced"
  put_template_custom Ph "03285c"
  put_template_custom Pi "fff7e4"
  put_template_custom Pj "fff7e4"
  put_template_custom Pk "03285c"
  put_template_custom Pl "85ccd0"
  put_template_custom Pm "03285c"
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
