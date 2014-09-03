set -o nounset
dir_from="$PWD"
dir_self=`dirname $0`
pushd $dir_from >/dev/null

#source $dir_root/init.cfg
set_env(){
  source /tmp/library.cfg
  use commander
  use print
  use assert
  use trace
  use where_am_i 
  use exiting
}

init(){
  #dir_self="`where_am_i $0`"
  dir_root=$dir_from
  #${dir_root:-.}
  dir_target="$dir_root/COMMON/BANK"
assert dir_exist $dir_target 
}

single(){
  local line="$1"
  local   file=$( commander finder "$line" )
  test $? -eq 0 || {  exit 1; }
  #commander   assert file_exist $file
  local   filename=`basename "$file"`

  file_target=$dir_target/$filename
  if [ ! -L $file_target ] ;then
    echo commander "ln -s $file $file_target" 
    #else
    # print ok file exist: $file_target 

  commander assert symlink_exist $file_target
  fi


}

many(){

  #file:   required.txt
  file_required="$1"

  commander assert file_exist $file_required
  while read line;do
    echo $line 
    commander single $line  
  done < $file_required
}

#$cmd=${1:-single}
num=$#
set_env
assert left_bigger $num 0 
str="$1"
init

#) && ( echo print ok ) || ( echo print error )
#) && ( print ok )  || { print error "Please supply a file or a filename"; exit 0; }


if [ -f "$str" ];then
  commander many "$str"
else
  commander single "$str"
fi


popd >/dev/null
