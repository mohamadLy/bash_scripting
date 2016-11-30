#!/bin/bash

function weekstat {

	#Save current directory
	CURRENT=$(pwd)

	#Ask username
	read -p "Please enter username: " USERNAME

	#cd ~/mainline/product/sandbox/services/system/unittests
	cd ~/mainline/product/sandbox/lib/c/unittests

	svn log | grep "$USERNAME" | grep -v "CI" | cut -d " " -f 1,5 >> tmp_file
	#VARIABLE=`cat tmp_file`

	#echo "VARIABLE $VARIABLE" 
	#LINE_NUMBER=svn diff -c r184757 | wc -l
	#echo "line number $LINE_NUMBER"

	# read file line by line
	# IFS='' (or IFS=) prevent leading/trailing whitespace from being trimmed
	# -r prevent backslash escape from being interpreted.
	# || [ -n $line ]] prevents the last line from being ignored if dosn't end with an \n (since read return a non-zero exit code when
	# it encounters EOF
	while IFS='' read -r line || [[ -n "$line" ]]; do
		#Line_number=svn diff -c $line | wc - l
		echo "File id = $line" 
		svn diff -c $line | wc -l >> result_file 
	done < "tmp_file"
	cat result_file

	SUM=0; 
	for i in `cut -d " " -f 1 result_file`; do
		SUM=$(($SUM + $i)); 
	done; 
	echo "total number of line is: $SUM"

	rm -f tmp_file
	rm -f result_file
	#came back to current directory
	cd "$CURRENT"

} 
