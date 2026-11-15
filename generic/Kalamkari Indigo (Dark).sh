#!/bin/sh
# Kalamkari Indigo (Dark)

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
put_template 0  "56/5f/7e"
put_template 1  "ee/7a/63"
put_template 2  "a9/c4/7f"
put_template 3  "ea/c4/6a"
put_template 4  "93/aa/eb"
put_template 5  "de/8f/b0"
put_template 6  "6e/c6/b6"
put_template 7  "ad/aa/a6"
put_template 8  "8d/93/a8"
put_template 9  "ee/7a/63"
put_template 10 "a9/c4/7f"
put_template 11 "ea/c4/6a"
put_template 12 "93/aa/eb"
put_template 13 "de/8f/b0"
put_template 14 "6e/c6/b6"
put_template 15 "ed/e3/cf"

color_foreground="ed/e3/cf"
color_background="14/1c/34"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ede3cf"
  put_template_custom Ph "141c34"
  put_template_custom Pi "ede3cf"
  put_template_custom Pj "2c3b5e"
  put_template_custom Pk "ede3cf"
  put_template_custom Pl "eab84a"
  put_template_custom Pm "141c34"
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
