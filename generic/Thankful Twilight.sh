#!/bin/sh
# Thankful Twilight

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
put_template 0  "ad/a1/93"
put_template 1  "de/98/7a"
put_template 2  "9b/da/6e"
put_template 3  "d9/b3/67"
put_template 4  "89/ae/e1"
put_template 5  "da/6d/b6"
put_template 6  "74/dc/c2"
put_template 7  "dc/d4/c7"
put_template 8  "c6/bd/b3"
put_template 9  "e8/b7/a2"
put_template 10 "b9/e5/9a"
put_template 11 "e4/ca/95"
put_template 12 "ac/c6/ea"
put_template 13 "e5/99/cc"
put_template 14 "9e/e7/d4"
put_template 15 "e7/e1/d8"

color_foreground="f8/ea/d5"
color_background="35/23/3f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8ead5"
  put_template_custom Ph "35233f"
  put_template_custom Pi "e7e1d8"
  put_template_custom Pj "89aee1"
  put_template_custom Pk "35233f"
  put_template_custom Pl "d9b367"
  put_template_custom Pm "35233f"
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
