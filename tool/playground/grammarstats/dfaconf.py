import sys
from numpy  import *
import matplotlib.pyplot as plt

transitions_file = sys.argv[1]

# load transition data. Each row is the list of trial stats per this one file
stats = loadtxt(open(transitions_file+'.txt',"rb"),delimiter=",",skiprows=0)
means = [mean(filerow) for filerow in stats]

trials = len(stats[0])
if trials<10:
	print "trials", 10, " won't give good confidence tube"
N = len(stats)
index_of_97_5 = (trials * 0.975) - 1
index_of_2_5 = (trials * 0.025) - 1

print index_of_97_5, index_of_2_5

# Compute two-sided confidence interval.
# Find max/min value 2.5% values from sorted list
top2_5 = [sort(filerow)[index_of_97_5] for filerow in stats]
bottom2_5 = [sort(filerow)[index_of_2_5] for filerow in stats]

plt.plot(means, linewidth=0.5)
plt.plot(top2_5, color="grey", linewidth=0.5)
plt.plot(bottom2_5, color="grey", linewidth=0.5)
plt.ylabel('Number of DFA states', family="serif")
plt.legend(('DFA states mean','95% two-sided confidence interval'),
		   loc='lower right' , prop={'family':'serif'})
plt.title(transitions_file+" (trials="+str(trials)+", files N="+str(N)+")")
plt.xlabel('Files parsed', family="serif")
plt.savefig(transitions_file+'-stats.pdf', format="pdf")
plt.show()

