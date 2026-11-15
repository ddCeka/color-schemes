#!/bin/sh
# Tamil Kolam (Dark)

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
put_template 0  "59/61/5f"
put_template 1  "ee/6e/80"
put_template 2  "9c/d8/6a"
put_template 3  "eb/c3/5a"
put_template 4  "7a/a8/f5"
put_template 5  "d9/8a/e0"
put_template 6  "45/c6/d6"
put_template 7  "b4/b8/b4"
put_template 8  "8d/95/92"
put_template 9  "ee/6e/80"
put_template 10 "9c/d8/6a"
put_template 11 "eb/c3/5a"
put_template 12 "7a/a8/f5"
put_template 13 "d9/8a/e0"
put_template 14 "45/c6/d6"
put_template 15 "f2/ef/e6"

color_foreground="f2/ef/e6"
color_background="18/1c/1c"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f2efe6"
  put_template_custom Ph "181c1c"
  put_template_custom Pi "f2efe6"
  put_template_custom Pj "2a3e44"
  put_template_custom Pk "f2efe6"
  put_template_custom Pl "ebc35a"
  put_template_custom Pm "181c1c"
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
