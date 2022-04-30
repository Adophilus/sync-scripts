#! /bin/bash

project=$1
path=$2
out=$3
extensions=".js .jsx .html .css .vue"

file_path=$(echo $out | sed -E s"/^(.*)?\s(\w+)\s(.*)?$/\1\3/")
file_operation=$(echo $out | sed -E s"/^.*?\s(\w+)\s.*?$/\1/")
file_name=$(basename $file_path)
file_extension=".${file_name##*.}"

if [[ -f "/tmp/my-watcher/$project/last-lint" ]];
then
	last_lint=$(cat "/tmp/my-watcher/$project/last-lint")
else
	last_lint="0"
fi

# echo $file_path
# echo $file_operation
# echo $file_extension

if [[ ! $last_lint == $EPOCHSECONDS ]];
then
	if [[ $file_operation == "MODIFY" ]];
	then
		for ext in $extensions;
		do
			if [[ -f $file_path ]] && [[ $ext == $file_extension ]];
			then
				prettier $file_path --write
				echo $EPOCHSECONDS > "/tmp/my-watcher/$project/last-lint"
			fi
		done
	fi
fi

go-sync deploy $project