import sys
from numpy  import *
import matplotlib.pyplot as plt
import matplotlib.patches as mpatch
import matplotlib.pyplot as plt
import shared
import shared

transitions_file = {}

grammars = [g for g in sys.argv[1:]]

files = [g+'-transitions.txt' for g in grammars]

# load transition data. Each row is the list of trial stats per this one file

fig, ax = plt.subplots(1)

fig.set_figheight(3.6)
fig.set_figwidth(6)

stats = {}

means = {}
nfiles = {}
for i in range(len(grammars)):
	g = grammars[i]
	stats[g] = loadtxt(open(files[i],"rb"),delimiter=",",skiprows=0)
	means[g] = [mean(filerow) for filerow in stats[g]]
	nfiles[g] = len(stats[g]) # num files parsed for this grammar

m = 0
for g in grammars:
	N = len(means[g])
	N = 175 # force to show left side more
	plt.plot(means[g][1:N], linewidth=1.0,
			 color=shared.colors[g], linestyle=shared.styles[g])

	X = 20
	Y = max(means[g][X-5:X+5])
	#if g=='Verilog2001' : Y = 0.005; X = 1
	plt.text(X, Y, g,
			 fontsize=15, family="serif")
	m = max(m, max(means[g]))

plt.axis(xmax=N, ymax=.5)

plt.ylabel('Expected DATN simulation', family="serif", size=15)
plt.xlabel('Files parsed', family="serif", size=15)
plt.text(10, .4, "Curves represent 500 trials of 175 files", fontsize=15, family="serif")
plt.savefig('atn-decay-stats.pdf', format="pdf", bbox_inches='tight', pad_inches=0.05)
plt.show()
