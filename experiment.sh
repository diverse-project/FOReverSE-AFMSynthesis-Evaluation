#!/bin/sh


# PARAMS : 
# - number of features (root not included)
# - number of configurations
# - maximum size of domain
# - enable or group computation
# - or group computation timeout
# - timeout for product generation

# Init environment
export PATH=$PATH:/usr/local/sicstus4.3.0/bin/
export PATH=$PATH:/usr/local/scala/bin
export http_proxy=http://proxy:3128/ && export https_proxy=https://proxy:3128/

# Copy files for the experiment in /tmp/afm_experiment
EXPERIMENT_DIR=/home/gbecan/afm-synthesis/FOReverSE-AFMSynthesis-Evaluation
TMP_DIR=/tmp/afm_experiment
RESULTS_DIR=/home/gbecan/afm-synthesis/results

mkdir $TMP_DIR
cp -rf $EXPERIMENT_DIR/* $TMP_DIR
cd $TMP_DIR

# Perform experiment
./synthesis.sh $1 $2 $3 $4 $5
./configuration_semantics.sh $6

# Save results
cp -r $TMP_DIR/results/* $RESULTS_DIR

# Clean /tmp
rm -rf $TMP_DIR

