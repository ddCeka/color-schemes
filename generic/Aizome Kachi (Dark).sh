#!/bin/sh
# Aizome Kachi (Dark)

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
put_template 0  "44/51/60"
put_template 1  "e6/6e/68"
put_template 2  "73/bb/83"
put_template 3  "dc/ba/5c"
put_template 4  "73/a9/e1"
put_template 5  "cc/8b/c5"
put_template 6  "60/bf/c4"
put_template 7  "78/8f/a7"
put_template 8  "7d/8f/a2"
put_template 9  "e6/6e/68"
put_template 10 "73/bb/83"
put_template 11 "dc/ba/5c"
put_template 12 "73/a9/e1"
put_template 13 "cc/8b/c5"
put_template 14 "60/bf/c4"
put_template 15 "a3/be/d6"

color_foreground="a3/be/d6"
color_background="0b/14/21"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "a3bed6"
  put_template_custom Ph "0b1421"
  put_template_custom Pi "a3bed6"
  put_template_custom Pj "1f344e"
  put_template_custom Pk "a3bed6"
  put_template_custom Pl "e9f2f7"
  put_template_custom Pm "0b1421"
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
