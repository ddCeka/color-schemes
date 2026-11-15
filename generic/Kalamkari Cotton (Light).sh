#!/bin/sh
# Kalamkari Cotton (Light)

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
put_template 0  "a6/98/79"
put_template 1  "a3/30/1f"
put_template 2  "46/67/2a"
put_template 3  "74/52/00"
put_template 4  "27/40/8a"
put_template 5  "89/2c/5a"
put_template 6  "1d/6b/63"
put_template 7  "59/51/45"
put_template 8  "5f/55/45"
put_template 9  "a3/30/1f"
put_template 10 "46/67/2a"
put_template 11 "74/52/00"
put_template 12 "27/40/8a"
put_template 13 "89/2c/5a"
put_template 14 "1d/6b/63"
put_template 15 "2a/22/18"

color_foreground="2a/22/18"
color_background="f0/e6/cc"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "2a2218"
  put_template_custom Ph "f0e6cc"
  put_template_custom Pi "2a2218"
  put_template_custom Pj "cbd5ea"
  put_template_custom Pk "2a2218"
  put_template_custom Pl "a3301f"
  put_template_custom Pm "f0e6cc"
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
