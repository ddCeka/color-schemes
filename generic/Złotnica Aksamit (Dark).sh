#!/bin/sh
# Złotnica Aksamit (Dark)

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
put_template 0  "52/62/5a"
put_template 1  "f0/80/80"
put_template 2  "8f/d4/96"
put_template 3  "e8/c3/5e"
put_template 4  "8d/b4/f0"
put_template 5  "da/9a/d8"
put_template 6  "74/d0/d0"
put_template 7  "98/a4/9d"
put_template 8  "89/97/8f"
put_template 9  "f0/80/80"
put_template 10 "8f/d4/96"
put_template 11 "e8/c3/5e"
put_template 12 "8d/b4/f0"
put_template 13 "da/9a/d8"
put_template 14 "74/d0/d0"
put_template 15 "c6/cb/c4"

color_foreground="c6/cb/c4"
color_background="10/20/1a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c6cbc4"
  put_template_custom Ph "10201a"
  put_template_custom Pi "c6cbc4"
  put_template_custom Pj "24403a"
  put_template_custom Pk "c6cbc4"
  put_template_custom Pl "e8c35e"
  put_template_custom Pm "10201a"
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
