#!/bin/sh

# PARAMS : 
# - number of features (root not included)
# - number of configurations
# - maximum size of domain
# - enable or group computation
# - or group computation timeout

scala -J-Xmx16g -classpath "jars/lib-afmsynthesis/*:jars/afmsynthesis_2.10-0.1.jar" \
foreverse.afmsynthesis.RandomSynthesis \
results $1 $2 $3 $4 $5

