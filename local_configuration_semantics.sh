#!/bin/sh

# PARAMS : 
# - directory
# - timeout

for dir in $1/*/
do
    dir=${dir%*/}
echo $dir
	# Generate products
	java -Xmx2g -jar jars/MatrixGenerator.jar $dir $2

	# Check configuration semantics	
#	scala -J-Xmx2g -classpath "jars/lib-afmsynthesis/*:jars/afmsynthesis_2.10-0.1.jar" \
#	foreverse.afmsynthesis.ConfigurationSemanticsChecker \
#	$dir

done



