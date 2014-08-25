#!/bin/sh

# PARAMS : 
# - number of features (root not included)
# - number of configurations
# - maximum size of domain
# - enable or group computation

# Init environment
export PATH=$PATH:/usr/local/sicstus4.3.0/bin/
export PATH=$PATH:/usr/local/scala/bin
export http_proxy=http://proxy:3128/ && export https_proxy=https://proxy:3128/
#cp /home/gbecan/afm-synthesis/

# Perform experiment
scala -J-Xmx16g -classpath "jars/lib-afmsynthesis/*:jars/afmsynthesis_2.10-0.1.jar" \
foreverse.afmsynthesis.RandomSynthesis \
results $1 $2 $3 $4


# Save results


# Clean environment
