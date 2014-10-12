#!/usr/bin/env bash
#exec -c
#set -x
#set +e
#trap_err(){
#echo `caller`
#}
#trap trap_err ERR
commander0(){
local cmd="$@"
echo "[cmd] $cmd" 
eval "$cmd"
}

#clear
reset_env(){
#commander0 env - bash
export SHELL=/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/games
export DISPLAY=:0 
export LOGNAME=paretech
export HOME=/home/paretech
export TERM=/usr/sbin/xterm
}



ensure_install(){
echo $FUNCNAME
  source /tmp/library.cfg
  use who_am_i
  use print
  use commander
  use ensure
 # ensure ln_tmp $0
}

cmd="$@"

echo $cmd > /tmp/cmd
reset_env

#set -x
cmd=$(cat /tmp/cmd)
echo [cmd] $cmd
#sleep 3
#gxmessage -file < env

notify-send -t 1000 -u critical PROXY "$cmd" &
#notify-send -t 6000 -u critical "$str1" "$str2"
ensure_install

#use dialog_confirm
#dialog_confirm pilot? /tmp/pilot.sh

( eval "$cmd" 2>/tmp/err ) && ( notify-send ok; ) || ( notify-send err; $gxmessage1 )
#echo 2>&1  res: $res
