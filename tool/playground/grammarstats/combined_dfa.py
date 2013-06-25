import sys
from numpy  import *
import matplotlib.pyplot as plt
import matplotlib.patches as mpatch
import matplotlib.pyplot as plt
import shared
import shared
from matplotlib.ticker import ScalarFormatter, FuncFormatter

split_index = sys.argv.index("+")

grammars1 = [g for g in sys.argv[1:split_index]]
grammars2 = [g for g in sys.argv[split_index+1:]]

files1 = [g+'-dfasizes.txt' for g in grammars1]
files2 = [g+'-dfasizes.txt' for g in grammars2]

f, (plt1,plt2) = plt.subplots(2, sharex=True)

f.set_figheight(4.5)
f.set_figwidth(3)

def my_formatter_fun(x, p):
	return "%.0f" % (x / 100.0)

plt2.get_yaxis().set_major_formatter(FuncFormatter(my_formatter_fun))

# load transition data. Each row is the list of trial stats per this one file

stats = {}
means = {}
nfiles = {}
for i in range(len(grammars1)):
	g = grammars1[i]
	stats[g] = loadtxt(open(files1[i],"rb"),delimiter=",",skiprows=0)
	means[g] = [mean(filerow) for filerow in stats[g]]
	nfiles[g] = len(stats[g]) # num files parsed for this grammar

m = 0
for g in grammars1:
	N = len(means[g])
	plt1.plot(means[g], linewidth=0.5,
			 color=shared.colors[g], linestyle=shared.styles[g])
	plt1.text(N-len(g)*19, means[g][N-1], g,
			 fontsize=11, family="serif")
	m = max(m, max(means[g]))

plt1.axis(ymax=m*1.08)

# NOW DO 2ND GRAPH
stats = {}
means = {}
nfiles = {}
for i in range(len(grammars2)):
	g = grammars2[i]
	stats[g] = loadtxt(open(files2[i],"rb"),delimiter=",",skiprows=0)
	means[g] = [mean(filerow) for filerow in stats[g]]
	nfiles[g] = len(stats[g]) # num files parsed for this grammar

m = 0
for g in grammars2:
	plt2.plot(means[g], linewidth=0.5,
			 color=shared.colors[g], linestyle=shared.styles[g])
	N = len(means[g])
	if ( g == "C11" ):
		plt2.text(N-len(g)*24, means[g][N-1], g,
				  fontsize=11, family="serif")
	elif ( g == "C11SLL" ):
		plt2.text(N-len(g)*20, 0.80*means[g][N-1], g,
				  fontsize=11, family="serif")
	elif ( g == "JavaSable" ):
		plt2.text(N-len(g)*18, 0.65*means[g][N-1], g,
				  fontsize=11, family="serif")
	else:
		plt2.text(N-len(g)*18, 0.80*means[g][N-1], g,
				  fontsize=11, family="serif")
	m = max(m, max(means[g]))

plt2.axis(ymax=m*1.08)

plt1.set_ylabel('No. DFA states', family="serif", size=11)
plt2.set_ylabel('No. DFA $10^2$ states', family="serif", size=11)
plt.xlabel('Files parsed', family="serif", size=11)

f.subplots_adjust(hspace=0)
plt.setp([a.get_xticklabels() for a in f.axes[:-1]], visible=False)

plt.savefig('dfasize-stats.pdf', format="pdf", bbox_inches='tight', pad_inches=0.03)
plt.show()
