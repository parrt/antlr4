import sys
from numpy  import *
import matplotlib.pyplot as plt
import shared

transitions_file = sys.argv[1]+'-timings'

# load transition data. Each row is the list of trial stats per this one file
stats = loadtxt(open(transitions_file+'.txt',"rb"),delimiter=",",skiprows=0)
means = [mean(filerow) for filerow in stats]

trials = len(stats[0])
N = len(stats)
index_of_97_5 = round(trials * 0.975) - 1
index_of_2_5 = round(trials * 0.025)

fig, ax = plt.subplots(1)

fig.set_figheight(3)
fig.set_figwidth(3)

# Compute two-sided confidence interval.
# Find max/min value 2.5% values from sorted list
top2_5 = [sort(filerow)[index_of_97_5] for filerow in stats]
bottom2_5 = [sort(filerow)[index_of_2_5] for filerow in stats]

t = arange(N)
ax.fill_between(t, top2_5, bottom2_5, facecolor='yellow', alpha=0.2)

plt.plot(means, linewidth=0.75, color=shared.colors[sys.argv[1]])
# plt.plot(top2_5, color="grey", linewidth=0.5)
# plt.plot(bottom2_5, color="grey", linewidth=0.5)
plt.text(1640, 500, "Java", fontsize=12, family="serif")
plt.text(560, 150, '95% two-sided',
		 fontsize=12, family="serif")
plt.text(560, 90, 'confidence tube',
		 fontsize=12, family="serif")
plt.plot([500,500], [top2_5[500],bottom2_5[500]], 'k-', lw=1)
plt.plot([480,520], [top2_5[500],top2_5[500]], 'k-', lw=1)
plt.plot([480,520], [bottom2_5[500],bottom2_5[500]], 'k-', lw=1)

plt.ylabel('Parse time (ms)', family="serif", size=12)

plt.xlabel('Files parsed', family="serif", size=12)
plt.savefig('Java-timings-stats.pdf',
			format="pdf", bbox_inches='tight', pad_inches=0.03)
plt.show()

