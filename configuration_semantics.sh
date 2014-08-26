#!/bin/sh

# PARAMS : timeout

for dir in results/*/
do
    dir=${dir%*/}
echo $dir
	# Generate products
	java -Xmx16g -jar jars/MatrixGenerator.jar $dir $1

	# Check configuration semantics	
	scala -J-Xmx16g -classpath "jars/lib-afmsynthesis/*:jars/afmsynthesis_2.10-0.1.jar" \
	foreverse.afmsynthesis.ConfigurationSemanticsChecker \
	$dir

done



