import sys
from numpy  import *
import matplotlib.pyplot as plt

transitions_file = sys.argv[1]

# load transition data. Each row is the list of trial stats per this one file
stats = loadtxt(open(transitions_file,"rb"),delimiter=",",skiprows=0)
means = [mean(filerow) for filerow in stats]

trials = len(stats[0])
N = len(stats)
index_of_95 = trials * 0.95 - 1

# Compute one-sided confidence interval.
# Find max value 5% from max value in sorted list
conf95 = [sort(filerow)[index_of_95] for filerow in stats]

#plt.plot(stats[:,0])
#plt.plot(stats[:,1])
#plt.plot(stats[:,2])

plt.plot(means, linewidth=0.5)
plt.plot(conf95, color="grey", linewidth=0.5)
#plt.axis(ymax=.4)
plt.title(transitions_file)
plt.xlabel('Files parsed', family="serif")
plt.ylabel('ATN to total transitions ratio', family="serif")
plt.legend(('ATN transition mean','95% one-sided confidence interval'),
		   loc='upper right' , prop={'family':'serif'})
plt.savefig('/tmp/'+transitions_file+'-stats.pdf', format="pdf")
plt.show()

