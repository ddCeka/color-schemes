#!/bin/sh
# 1K Confetti

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
put_template 0  "28/27/35"
put_template 1  "f2/8e/99"
put_template 2  "91/d4/a0"
put_template 3  "f2/d6/6d"
put_template 4  "8d/af/fc"
put_template 5  "dd/9b/ed"
put_template 6  "68/d4/d0"
put_template 7  "cc/c8/dc"
put_template 8  "93/90/aa"
put_template 9  "ff/b2/b7"
put_template 10 "b4/f0/bb"
put_template 11 "ff/eb/9e"
put_template 12 "b9/ce/ff"
put_template 13 "f2/c0/fa"
put_template 14 "9a/f0/e4"
put_template 15 "ff/f5/fc"

color_foreground="ea/e7/f0"
color_background="13/13/1d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "eae7f0"
  put_template_custom Ph "13131d"
  put_template_custom Pi "fff5fc"
  put_template_custom Pj "483458"
  put_template_custom Pk "fff5fc"
  put_template_custom Pl "f2d66d"
  put_template_custom Pm "13131d"
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
