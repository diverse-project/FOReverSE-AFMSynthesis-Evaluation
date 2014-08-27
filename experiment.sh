#!/bin/sh


# PARAMS : 
# - number of features (root not included)
# - number of configurations
# - maximum size of domain
# - enable or group computation
# - or group computation timeout
## - timeout for product generation
## - how many synthesis are performed

# Init environment
export PATH=$PATH:/usr/local/sicstus4.3.0/bin/
export PATH=$PATH:/usr/local/scala/bin
export http_proxy=http://proxy:3128/ && export https_proxy=https://proxy:3128/

# Copy files for the experiment in /tmp/afm_experiment
EXPERIMENT_DIR=/home/gbecan/afm-synthesis/FOReverSE-AFMSynthesis-Evaluation
TMP_DIR=/tmp/afm_experiment
RESULTS_DIR=/home/gbecan/afm-synthesis/results
LOG=/home/gbecan/afm-synthesis/results/log.txt

echo "" > $LOG

mkdir $TMP_DIR
cp -rf $EXPERIMENT_DIR/* $TMP_DIR
cd $TMP_DIR

# Perform experiment
#for i in $(seq 1 $7); do 
for i in 5 10 20 50 100 200 500 1000 #2000 5000 10000
do 
	echo "Synthesis $i" >> $LOG
	./synthesis.sh $i $2 $3 $4 $5 >> $LOG

	# Save results
	cp -r $TMP_DIR/results/* $RESULTS_DIR >> $LOG
	rm -rf $TMP_DIR/results/* >> $LOG
done

# Clean /tmp
rm -rf $TMP_DIR

