#!/bin/sh
# All-Nighter

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
put_template 0  "30/2d/38"
put_template 1  "cc/92/93"
put_template 2  "a2/b6/93"
put_template 3  "c8/ad/82"
put_template 4  "9d/aa/ca"
put_template 5  "b6/a0/c5"
put_template 6  "94/b8/b2"
put_template 7  "ba/b8/b2"
put_template 8  "91/8a/9a"
put_template 9  "e0/ac/ab"
put_template 10 "b9/ca/a9"
put_template 11 "dd/c4/9b"
put_template 12 "b6/c1/df"
put_template 13 "cc/b8/d8"
put_template 14 "af/cf/c8"
put_template 15 "e4/df/d3"

color_foreground="cb/c7/bd"
color_background="1e/1c/24"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "cbc7bd"
  put_template_custom Ph "1e1c24"
  put_template_custom Pi "e4dfd3"
  put_template_custom Pj "46404f"
  put_template_custom Pk "e4dfd3"
  put_template_custom Pl "94b8b2"
  put_template_custom Pm "1e1c24"
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
