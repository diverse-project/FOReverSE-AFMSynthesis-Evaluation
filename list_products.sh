#!/bin/sh

# PARAMS : 
# - timeout
# - directories

# Init environment
export PATH=$PATH:/usr/local/sicstus4.3.0/bin/
export PATH=$PATH:/usr/local/scala/bin
export http_proxy=http://proxy:3128/ && export https_proxy=https://proxy:3128/

# Copy files for the experiment in /tmp/afm_experiment
EXPERIMENT_DIR=/home/gbecan/afm-synthesis/FOReverSE-AFMSynthesis-Evaluation
TMP_DIR=/tmp/afm_experiment
#RESULTS_DIR=/data/gbecan_690668/afm-synthesis/results
#LOG=/home/gbecan/afm-synthesis/results/log.txt

mkdir $TMP_DIR
cp -rf $EXPERIMENT_DIR/* $TMP_DIR
cd $TMP_DIR

# Perform experiment
for dir in "${@:2}"
do
    dir=${dir%*/}
	echo $dir	
	# Generate products
	java -Xmx16g -jar jars/MatrixGenerator.jar $dir $1

done


# Clean /tmp
rm -rf $TMP_DIR
