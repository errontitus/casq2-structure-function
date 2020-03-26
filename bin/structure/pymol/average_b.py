# Author: Gregor Hagelueken

from pymol import cmd,stored
import numpy

def average_b(selection):
    stored.tempfactor = 0
    stored.atomnumber = 0
    stored.tempfactors = []
    cmd.iterate(selection, "stored.tempfactor = stored.tempfactor + b")
    cmd.iterate(selection, "stored.atomnumber = stored.atomnumber + 1")
    cmd.iterate(selection, "stored.tempfactors.append(b)")    
    print "Your selection: %s" % selection
    print "sum of B factors: %s" % stored.tempfactor
    print "number of atoms: %s" % stored.atomnumber
    averagetempfactor = stored.tempfactor / stored.atomnumber
    print "average B of '%s': %s" % (selection, averagetempfactor)
    stddevtempfactor = numpy.std(stored.tempfactors)
    print "stddev of B factors: %s" % stddevtempfactor
    return averagetempfactor, stddevtempfactor
cmd.extend("average_b", average_b)
