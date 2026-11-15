#!/bin/sh
# Kerala Kasavu (Light)

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
put_template 0  "a5/a7/97"
put_template 1  "b0/20/3a"
put_template 2  "3a/79/1e"
put_template 3  "7a/5a/00"
put_template 4  "10/60/a8"
put_template 5  "9c/3a/8a"
put_template 6  "00/78/76"
put_template 7  "56/5c/56"
put_template 8  "5a/61/5a"
put_template 9  "b0/20/3a"
put_template 10 "3a/79/1e"
put_template 11 "7a/5a/00"
put_template 12 "10/60/a8"
put_template 13 "9c/3a/8a"
put_template 14 "00/78/76"
put_template 15 "1f/24/20"

color_foreground="1f/24/20"
color_background="f9/f5/e8"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1f2420"
  put_template_custom Ph "f9f5e8"
  put_template_custom Pi "1f2420"
  put_template_custom Pj "d4e8da"
  put_template_custom Pk "1f2420"
  put_template_custom Pl "b0203a"
  put_template_custom Pm "f9f5e8"
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
