#!/bin/sh
# Gujarat Navratri (Dark)

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
put_template 0  "5e/57/68"
put_template 1  "ff/70/68"
put_template 2  "7f/dc/78"
put_template 3  "f5/cf/4a"
put_template 4  "6f/b8/f5"
put_template 5  "f2/8a/c0"
put_template 6  "4f/d1/c9"
put_template 7  "b8/b0/bc"
put_template 8  "93/8b/9c"
put_template 9  "ff/70/68"
put_template 10 "7f/dc/78"
put_template 11 "f5/cf/4a"
put_template 12 "6f/b8/f5"
put_template 13 "f2/8a/c0"
put_template 14 "4f/d1/c9"
put_template 15 "f2/ec/e4"

color_foreground="f2/ec/e4"
color_background="18/14/1f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f2ece4"
  put_template_custom Ph "18141f"
  put_template_custom Pi "f2ece4"
  put_template_custom Pj "382e4c"
  put_template_custom Pk "f2ece4"
  put_template_custom Pl "e8f0f5"
  put_template_custom Pm "18141f"
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
