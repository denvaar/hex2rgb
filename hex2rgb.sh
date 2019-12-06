#!/bin/sh

hexinput=`echo $1 | tr '[:lower:]' '[:upper:]'`  # uppercase-ing
a=`echo $hexinput | cut -c-2`
b=`echo $hexinput | cut -c3-4`
c=`echo $hexinput | cut -c5-6`

r=`echo "ibase=16; $a" | bc`
g=`echo "ibase=16; $b" | bc`
b=`echo "ibase=16; $c" | bc`

result=`echo "scale=2; ($r * 0.299 + $g * 0.587 + $b * 0.114) > 186" | bc`
[[ $result = "1" ]] && x="0" || x="255"

pad="██"
label="#$1"
labelfg="\x1b[38;2;$x;$x;${x}m"
labelbg="\x1b[48;2;$r;$g;${b}m"
padcolor="\x1b[38;2;$r;$g;${b}m"
resetcolor="\x1b[0m"

printf "${padcolor}%s${labelfg}${labelbg}%s${padcolor}%s${resetcolor}\n" $pad $label $pad

exit 0
