#!/bin/sh
# Penumbra Light (Semantic 6)

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
put_template 0  "df/d9/d0"
put_template 1  "bb/62/6b"
put_template 2  "50/92/59"
put_template 3  "95/8a/1c"
put_template 4  "00/82/b5"
put_template 5  "9d/68/a2"
put_template 6  "00/8a/87"
put_template 7  "2c/2e/31"
put_template 8  "b4/b1/ad"
put_template 9  "bb/62/6b"
put_template 10 "50/92/59"
put_template 11 "95/8a/1c"
put_template 12 "00/82/b5"
put_template 13 "9d/68/a2"
put_template 14 "00/8a/87"
put_template 15 "20/22/25"

color_foreground="8b/8b/8b"
color_background="ef/e8/dd"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "8b8b8b"
  put_template_custom Ph "efe8dd"
  put_template_custom Pi "5e6063"
  put_template_custom Pj "dfd9d0"
  put_template_custom Pk "8b8b8b"
  put_template_custom Pl "2c2e31"
  put_template_custom Pm "efe8dd"
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
