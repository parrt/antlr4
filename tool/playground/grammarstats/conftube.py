import sys
from numpy  import *
import matplotlib.pyplot as plt

transitions_file = sys.argv[1]

is_transitions = transitions_file.find('transitions')>0
is_dfasize = transitions_file.find('dfasizes')>0

# load transition data. Each row is the list of trial stats per this one file
stats = loadtxt(open(transitions_file+'.txt',"rb"),delimiter=",",skiprows=0)
means = [mean(filerow) for filerow in stats]

trials = len(stats[0])
N = len(stats)
index_of_95 = trials * 0.95 - 1

# Compute one-sided confidence interval.
# Find max value 5% from max value in sorted list
conf95 = [sort(filerow)[index_of_95] for filerow in stats]

#TODO: add trials/N to plot

plt.plot(means, linewidth=0.5)
plt.plot(conf95, color="grey", linewidth=0.5)
if is_transitions:
	plt.axis(ymax=.3)
	plt.ylabel('ATN to total transitions ratio', family="serif")
	plt.legend(('ATN transition mean','95% one-sided confidence interval'),
			   loc='upper right' , prop={'family':'serif'})
elif is_dfasize:
	plt.ylabel('Number of DFA states', family="serif")
	plt.legend(('DFA states mean','95% one-sided confidence interval'),
			   loc='lower right' , prop={'family':'serif'})
else: # timing
	plt.ylabel('Wallclock parse time (ms)', family="serif")
	plt.legend(('Wallclock parse time','95% one-sided confidence interval'),
			   loc='lower right' , prop={'family':'serif'})
plt.title(transitions_file)
plt.xlabel('Files parsed', family="serif")
plt.savefig(transitions_file+'-stats.pdf', format="pdf")
plt.show()

