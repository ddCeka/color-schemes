#!/bin/sh
# Deep In Purple

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
put_template 0  "39/29/68"
put_template 1  "ef/81/9b"
put_template 2  "a9/cb/8d"
put_template 3  "e6/ba/6f"
put_template 4  "a5/a5/f4"
put_template 5  "d8/8d/e4"
put_template 6  "88/cc/c5"
put_template 7  "d1/ba/db"
put_template 8  "a2/95/c6"
put_template 9  "ff/a8/b9"
put_template 10 "c6/e4/aa"
put_template 11 "ff/db/91"
put_template 12 "c6/c1/ff"
put_template 13 "f3/b0/f6"
put_template 14 "ab/e7/df"
put_template 15 "ff/f4/ec"

color_foreground="eb/df/f0"
color_background="24/16/50"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ebdff0"
  put_template_custom Ph "241650"
  put_template_custom Pi "fff4ec"
  put_template_custom Pj "514080"
  put_template_custom Pk "fff4ec"
  put_template_custom Pl "88ccc5"
  put_template_custom Pm "241650"
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
