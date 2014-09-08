exec -c
set -u
source /tmp/library.cfg

use commander
use ensure

#dir_root=${dir_root:-$PWD}
dir_self=$( where_am_i $0 )

while read line;do
  test -n "$line" || exit
  echo
  file=$( eval echo $line )
  commander ls $file
commander ensure ln_tmp $file  
echo
done < anchors.txt


