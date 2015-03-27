#! /usr/bin/env python

import sys
import numpy

file = sys.argv[1]

# open a profile file (will lead coupling to getting the data from Zenodo)
INPUT = open(file)

profile = []
x = numpy.arange(128)

while True:

    # read in the next line
    line = INPUT.readline()

    # if there is no line, leave the loop
    if not line:
        break

    profile.append(float(line))

# save the data to a numpy array
y = numpy.array(profile)

# rescale the data so zero is 60, which is middle C
y+=200
y/=400.
z = numpy.int16(y * 120)

# create the line needed for chuck
# note that the first number is the number of subsequent integers
line = "%5i" % len(z)
for i in z:
    line += "%3i " % i
print line
