#!/bin/sh
# Penumbra Dark+ (Semantic 6)

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
put_template 0  "13/14/18"
put_template 1  "cd/6b/76"
put_template 2  "58/a0/61"
put_template 3  "a3/97/20"
put_template 4  "00/8f/c6"
put_template 5  "ac/72/b2"
put_template 6  "00/98/94"
put_template 7  "ef/e8/dd"
put_template 8  "5b/5d/62"
put_template 9  "cd/6b/76"
put_template 10 "58/a0/61"
put_template 11 "a3/97/20"
put_template 12 "00/8f/c6"
put_template 13 "ac/72/b2"
put_template 14 "00/98/94"
put_template 15 "ff/f6/e9"

color_foreground="99/99/99"
color_background="1d/20/24"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "999999"
  put_template_custom Ph "1d2024"
  put_template_custom Pi "bab8b4"
  put_template_custom Pj "292b30"
  put_template_custom Pk "999999"
  put_template_custom Pl "efe8dd"
  put_template_custom Pm "1d2024"
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
