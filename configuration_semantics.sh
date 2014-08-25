#!/bin/sh

# PARAMS : timeout


# Init environment
export PATH=$PATH:/usr/local/sicstus4.3.0/bin/
export PATH=$PATH:/usr/local/scala/bin
export http_proxy=http://proxy:3128/ && export https_proxy=https://proxy:3128/
#cp /home/gbecan/afm-synthesis/


# Perform experiment
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


# Save results


# Clean environment


