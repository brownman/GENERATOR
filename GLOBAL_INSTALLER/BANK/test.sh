source install11.cfg
source disto.cfg
test1(){
  set -o nounset
  single $dir_list/dependencies_all.txt  install1
  single $dir_list/dependencies_extra.txt install1
  set +o nounset
  single $dir_list/dependencies_python.txt install1_python

  set -o nounset
}



