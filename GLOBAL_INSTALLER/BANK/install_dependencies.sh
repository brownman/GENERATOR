intro(){
  clear
}
set_env(){
  source distro1.cfg
  #  dependOn PACKAGE/install1.cfg
}

single(){
  local file=$1
  local file_list=$( mktemp )
  local method=$2
  #list_strip $file $file_list
  cat $file | cut -d '#' -f1 > $file_list
  #act_on_list $file_list $method
  while read line;do
    cmd="$method $line"
    echo "[CMD] $cmd"
    eval "$cmd"
  done < $file_list
}
install_1_package(){
  local package="$1"


  echo -n "[ $package ] "
  commander "$SUDO $cmd_check_package $package"  &>/dev/null  

  res=$?


  if [ $res -ne 0 ];then
    commander "$SUDO $cmd_installer $package" &>/dev/null 
    #&>/dev/null 
    res=$?
    ( test $res -eq 0 ) || ( print error "$package -  is not in your repositories - add it first"; cat1 "$dir_root/LIST/RESCUE/$package.txt" true; sleep 3; ) 
  fi
}

steps(){
  intro
  set_env
  #  step1

}


steps
distro=debian

distro=arch
#${distro:-$( $distro )}
cmd_check_package=${cmd_check_package:-$( os_check_package "$distro" )}
#    cmd_check_package_remote=${cmd_check_package_remote:-$( os_check_package_remote "$distro" )}
cmd_installer=${cmd_installer:-$( os_installer "$distro" )}
SUDO=${SUDO:-$( os_user )}

print_color 33 "DETAILS:"
echo $SUDO
echo $distro
echo $cmd_installer
echo $cmd_check_package
echo steps

