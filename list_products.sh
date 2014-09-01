#!/bin/sh

# PARAMS : 
# - directory
# - timeout

for dir in $1/*/
do
    dir=${dir%*/}
echo $dir
	# Generate products
	java -Xmx16g -jar jars/MatrixGenerator.jar $dir $2

done



