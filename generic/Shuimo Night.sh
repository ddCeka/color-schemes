#!/bin/sh
# Shuimo Night

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
put_template 0  "55/54/4f"
put_template 1  "d7/5e/51"
put_template 2  "8a/a8/86"
put_template 3  "c9/a2/4e"
put_template 4  "8f/aa/c2"
put_template 5  "b4/91/b0"
put_template 6  "71/ab/aa"
put_template 7  "8e/8c/86"
put_template 8  "91/8f/89"
put_template 9  "d7/5e/51"
put_template 10 "8a/a8/86"
put_template 11 "c9/a2/4e"
put_template 12 "8f/aa/c2"
put_template 13 "b4/91/b0"
put_template 14 "71/ab/aa"
put_template 15 "c8/c6/c0"

color_foreground="c8/c6/c0"
color_background="17/17/16"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c8c6c0"
  put_template_custom Ph "171716"
  put_template_custom Pi "c8c6c0"
  put_template_custom Pj "2c333a"
  put_template_custom Pk "c8c6c0"
  put_template_custom Pl "d75e51"
  put_template_custom Pm "171716"
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
