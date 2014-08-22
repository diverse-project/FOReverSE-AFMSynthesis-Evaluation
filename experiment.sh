#!/bin/sh

# Init environment
export PATH=$PATH:/usr/local/sicstus4.3.0/bin
export PATH=$PATH:/usr/local/scala/bin

#cp /home/gbecan/afm-synthesis/

# Perform experiment
scala -classpath "lib/*" afmsynthesis_2.10-0.1.jar \
/home/gbecan/afm-synthesis/output/synthesized/ 2 3 4 true

# Save results


# Clean environment
