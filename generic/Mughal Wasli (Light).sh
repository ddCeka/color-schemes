#!/bin/sh
# Mughal Wasli (Light)

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
put_template 0  "a9/9e/96"
put_template 1  "b0/30/1e"
put_template 2  "1e/6e/55"
put_template 3  "7a/58/00"
put_template 4  "2b/3b/a6"
put_template 5  "99/2d/82"
put_template 6  "13/6a/8f"
put_template 7  "57/50/5a"
put_template 8  "5f/56/66"
put_template 9  "b0/30/1e"
put_template 10 "1e/6e/55"
put_template 11 "7a/58/00"
put_template 12 "2b/3b/a6"
put_template 13 "99/2d/82"
put_template 14 "13/6a/8f"
put_template 15 "22/1f/2b"

color_foreground="22/1f/2b"
color_background="f7/f1/e3"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "221f2b"
  put_template_custom Ph "f7f1e3"
  put_template_custom Pi "221f2b"
  put_template_custom Pj "d3d9f2"
  put_template_custom Pk "221f2b"
  put_template_custom Pl "2b3ba6"
  put_template_custom Pm "f7f1e3"
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
