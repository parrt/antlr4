import sys
from numpy  import *
import matplotlib.pyplot as plt

transitions_file = sys.argv[1]+'-transitions'
dfa_file = sys.argv[1]+'-dfasizes'

# load transition data. Each row is the list of trial stats per this one file
transitions = loadtxt(open(transitions_file+'.txt',"rb"),delimiter=",",skiprows=0)
atn_means = [mean(filerow) for filerow in transitions]
dfasizes = loadtxt(open(dfa_file+'.txt',"rb"),delimiter=",",skiprows=0)
dfa_means = [mean(filerow) for filerow in dfasizes]

trials = len(transitions[0])
N = len(transitions)
index_of_95 = trials * 0.95 - 1

fig = plt.figure()
ax1 = fig.add_subplot(111)
ax2 = ax1.twinx()

ax1.plot(atn_means, linewidth=0.5)
ax1.axis(ymax=.65)
ax1.set_ylabel('ATN to total transitions ratio', family="serif")
plt.legend(('ATN transition mean','95% one-sided confidence interval'),
		   loc='upper right' , prop={'family':'serif'})
plt.title(sys.argv[1]+" (trials="+str(trials)+", files N="+str(N)+")")
ax1.set_xlabel('Files parsed')

ax2.plot(dfa_means, linewidth=0.5)
ax2.set_ylabel('Number of DFA states', family="serif")

plt.savefig(transitions_file+'-stats.pdf', format="pdf")
plt.show()

