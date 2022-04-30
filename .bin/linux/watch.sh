#! /bin/bash

program_dir=$(dirname $0)
program=$(basename $0)
project=$1
path=$2

if [[ ! -d "/tmp/my-watcher/$project" ]];
then
	mkdir -p "/tmp/my-watcher/$project"
fi

if [[ ! $project ]] || [[ ! $path ]];
then
	echo "$program <project> <path>"
	exit
fi

# inotifywait --monitor --event create,delete,move,modify --recursive $path | xargs -I{} go-sync deploy development
inotifywait --monitor --event modify --recursive $path | xargs -I{} $program_dir/worker.sh $project $path {}