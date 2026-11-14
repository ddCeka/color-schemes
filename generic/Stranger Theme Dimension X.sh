#!/bin/sh
# Stranger Theme Dimension X

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
put_template 0  "46/42/42"
put_template 1  "ff/6b/6b"
put_template 2  "8f/ae/7e"
put_template 3  "d1/9a/66"
put_template 4  "c6/78/dd"
put_template 5  "ff/55/aa"
put_template 6  "7f/b5/b0"
put_template 7  "e8/d5/d5"
put_template 8  "9a/7c/7c"
put_template 9  "ff/89/89"
put_template 10 "ad/cc/9c"
put_template 11 "ef/b8/84"
put_template 12 "e4/96/fb"
put_template 13 "ff/73/c8"
put_template 14 "9d/d3/ce"
put_template 15 "ff/ff/ff"

color_foreground="e8/d5/d5"
color_background="1e/1a/1a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e8d5d5"
  put_template_custom Ph "1e1a1a"
  put_template_custom Pi "e8d5d5"
  put_template_custom Pj "523535"
  put_template_custom Pk "e8d5d5"
  put_template_custom Pl "e8d5d5"
  put_template_custom Pm "1e1a1a"
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
