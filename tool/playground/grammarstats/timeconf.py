import sys
from numpy  import *
import matplotlib.pyplot as plt

transitions_file = sys.argv[1]+'-timings'

# load transition data. Each row is the list of trial stats per this one file
stats = loadtxt(open(transitions_file+'.txt',"rb"),delimiter=",",skiprows=0)
means = [mean(filerow) for filerow in stats]

trials = len(stats[0])
N = len(stats)
index_of_97_5 = round(trials * 0.975) - 1
index_of_2_5 = round(trials * 0.025)

# Compute two-sided confidence interval.
# Find max/min value 2.5% values from sorted list
top2_5 = [sort(filerow)[index_of_97_5] for filerow in stats]
bottom2_5 = [sort(filerow)[index_of_2_5] for filerow in stats]

plt.plot(means, linewidth=0.5)
plt.plot(top2_5, color="grey", linewidth=0.5)
plt.plot(bottom2_5, color="grey", linewidth=0.5)
plt.ylabel('Wallclock parse time (ms)', family="serif")
plt.legend(('Wallclock parse time','95% two-sided confidence interval'),
		   loc='upper left' , prop={'family':'serif'})
plt.title(transitions_file+" (trials="+str(trials)+", files N="+str(N)+")")
plt.xlabel('Files parsed', family="serif")
plt.savefig(transitions_file+'-stats.pdf', format="pdf", bbox_inches='tight', pad_inches=0)
plt.show()

