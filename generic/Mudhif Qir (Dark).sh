#!/bin/sh
# Mudhif Qir (Dark)

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
put_template 0  "55/4d/3e"
put_template 1  "f0/7e/6e"
put_template 2  "8c/c8/78"
put_template 3  "ee/cc/5a"
put_template 4  "82/ae/f0"
put_template 5  "de/8a/d0"
put_template 6  "6c/cc/d0"
put_template 7  "a0/94/78"
put_template 8  "97/8c/72"
put_template 9  "f0/7e/6e"
put_template 10 "8c/c8/78"
put_template 11 "ee/cc/5a"
put_template 12 "82/ae/f0"
put_template 13 "de/8a/d0"
put_template 14 "6c/cc/d0"
put_template 15 "c2/b5/96"

color_foreground="c2/b5/96"
color_background="17/14/0e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c2b596"
  put_template_custom Ph "17140e"
  put_template_custom Pi "c2b596"
  put_template_custom Pj "3a3220"
  put_template_custom Pk "c2b596"
  put_template_custom Pl "e2b44a"
  put_template_custom Pm "17140e"
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
