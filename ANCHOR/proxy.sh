clear
ensure_install(){
  source /tmp/library.cfg
  use who_am_i
  use print
  use commander
  use ensure
 # ensure ln_tmp $0
}

cmd="$@"
    #notify-send -t 6000 -u critical "$str1" "$str2"

notify-send -t 1000 -u critical PROXY "$cmd" &

ensure_install
( eval "$cmd" 2>/tmp/err ) || $gxmessage1
#echo 2>&1  res: $res
