#!/bin/sh
# Aizome Kamenozoki (Light)

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
put_template 0  "97/a7/b3"
put_template 1  "ac/30/31"
put_template 2  "24/6e/3a"
put_template 3  "7d/5e/07"
put_template 4  "25/56/91"
put_template 5  "79/39/74"
put_template 6  "08/6a/73"
put_template 7  "59/6b/7c"
put_template 8  "4b/5e/73"
put_template 9  "ac/30/31"
put_template 10 "24/6e/3a"
put_template 11 "7d/5e/07"
put_template 12 "25/56/91"
put_template 13 "79/39/74"
put_template 14 "08/6a/73"
put_template 15 "21/36/51"

color_foreground="21/36/51"
color_background="e7/f2/f7"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "213651"
  put_template_custom Ph "e7f2f7"
  put_template_custom Pi "213651"
  put_template_custom Pj "bdd8ec"
  put_template_custom Pk "213651"
  put_template_custom Pl "111f37"
  put_template_custom Pm "e7f2f7"
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
