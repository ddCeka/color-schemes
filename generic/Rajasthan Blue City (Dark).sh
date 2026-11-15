#!/bin/sh
# Rajasthan Blue City (Dark)

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
put_template 0  "5a/6f/85"
put_template 1  "f2/70/7a"
put_template 2  "8f/d4/7a"
put_template 3  "f2/c7/5c"
put_template 4  "6c/c0/ff"
put_template 5  "e4/86/d9"
put_template 6  "4f/d6/c8"
put_template 7  "b7/b9/b6"
put_template 8  "93/9e/a7"
put_template 9  "f2/70/7a"
put_template 10 "8f/d4/7a"
put_template 11 "f2/c7/5c"
put_template 12 "6c/c0/ff"
put_template 13 "e4/86/d9"
put_template 14 "4f/d6/c8"
put_template 15 "f2/ea/df"

color_foreground="f2/ea/df"
color_background="13/27/3c"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f2eadf"
  put_template_custom Ph "13273c"
  put_template_custom Pi "f2eadf"
  put_template_custom Pj "2a4458"
  put_template_custom Pk "f2eadf"
  put_template_custom Pl "ff9f45"
  put_template_custom Pm "13273c"
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
