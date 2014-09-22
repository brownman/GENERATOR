


#shopt -s expand_aliases
#exec -c
set -u

test -f /tmp/library.cfg || { echo 1>&2 install the library first; exit 1; }
source /tmp/library.cfg
test -d "/tmp/dir_root" || exiting

pushd $(dirname $0) >/dev/null
while read line;do
  test -n "$line" || exit
  echo
  file=$( eval echo $line )
  commander ls $file
commander ensure ln_tmp $file  
echo
done < anchors.txt

popd >/dev/null
