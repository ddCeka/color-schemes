#!/bin/sh
# Edo Cha (Dark)

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
put_template 0  "57/51/4c"
put_template 1  "e6/6e/68"
put_template 2  "7a/ba/7c"
put_template 3  "dc/ba/5c"
put_template 4  "73/ab/da"
put_template 5  "c8/8e/c3"
put_template 6  "6c/be/c2"
put_template 7  "97/91/8a"
put_template 8  "93/8d/86"
put_template 9  "e6/6e/68"
put_template 10 "7a/ba/7c"
put_template 11 "dc/ba/5c"
put_template 12 "73/ab/da"
put_template 13 "c8/8e/c3"
put_template 14 "6c/be/c2"
put_template 15 "c2/bd/b5"

color_foreground="c2/bd/b5"
color_background="19/14/10"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c2bdb5"
  put_template_custom Ph "191410"
  put_template_custom Pi "c2bdb5"
  put_template_custom Pj "2a3741"
  put_template_custom Pk "c2bdb5"
  put_template_custom Pl "e8605b"
  put_template_custom Pm "191410"
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
