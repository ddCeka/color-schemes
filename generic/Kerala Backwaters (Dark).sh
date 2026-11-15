#!/bin/sh
# Kerala Backwaters (Dark)

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
put_template 0  "55/65/5b"
put_template 1  "f2/75/60"
put_template 2  "a8/d6/7a"
put_template 3  "ed/cb/5e"
put_template 4  "6c/b8/f5"
put_template 5  "ec/8e/ba"
put_template 6  "4f/d1/cc"
put_template 7  "b0/b6/ae"
put_template 8  "8b/98/8c"
put_template 9  "f2/75/60"
put_template 10 "a8/d6/7a"
put_template 11 "ed/cb/5e"
put_template 12 "6c/b8/f5"
put_template 13 "ec/8e/ba"
put_template 14 "4f/d1/cc"
put_template 15 "f0/ea/db"

color_foreground="f0/ea/db"
color_background="0f/22/19"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f0eadb"
  put_template_custom Ph "0f2219"
  put_template_custom Pi "f0eadb"
  put_template_custom Pj "26443a"
  put_template_custom Pk "f0eadb"
  put_template_custom Pl "e3b84a"
  put_template_custom Pm "0f2219"
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
