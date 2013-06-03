import sys
from numpy  import *
import matplotlib.pyplot as plt
import matplotlib.patches as mpatch
import matplotlib.pyplot as plt


transitions_file = {}

transitions_file['a'] = sys.argv[1]+'-transitions'
transitions_file['b'] = sys.argv[2]+'-transitions'

# load transition data. Each row is the list of trial stats per this one file
stats = {}
stats['a'] = loadtxt(open(transitions_file['a']+'.txt',"rb"),delimiter=",",skiprows=0)
stats['b'] = loadtxt(open(transitions_file['b']+'.txt',"rb"),delimiter=",",skiprows=0)
means = {}
means['a'] = [mean(filerow) for filerow in stats['a']]
means['b'] = [mean(filerow) for filerow in stats['b']]

trials = len(stats['a'][0])
N = len(stats['a'])
index_of_95 = trials * 0.95 - 1

# Compute one-sided confidence interval.
# Find max value 5% from max value in sorted list
conf95 = [sort(filerow)[index_of_95] for filerow in stats['a']]

f, (plt1,plt2) = plt.subplots(2, sharex=True)

plt1.plot(means['a'], linewidth=0.5)
plt1.plot(conf95, color="grey", linewidth=0.5)
plt1.axis(ymax=.2)
plt.ylabel('ATN to total transitions ratio', family="serif")
#plt1.set_title(transitions_file['a']+" (trials="+str(trials)+", files N="+str(N)+")")
plt.xlabel('Files parsed', family="serif")

plt2.plot(means['b'], linewidth=0.5)
plt.ylabel('ATN to total transitions ratio', family="serif")
plt2.plot(conf95, color="grey", linewidth=0.5)
plt2.axis(ymax=.2)
#plt2.set_title(transitions_file['b']+" (trials="+str(trials)+", files N="+str(N)+")")
#plt2.legend(('ATN transition mean','95% one-sided confidence interval'),
#			loc='upper right' , prop={'family':'serif'})

f.subplots_adjust(hspace=0)
plt.setp([a.get_xticklabels() for a in f.axes[:-1]], visible=False)

f.suptitle("ATN vs total transitions (trials="+str(trials)+", files N="+str(N)+")")

styles = mpatch.BoxStyle.get_styles()
figheight = (len(styles)+.5)
fig1 = plt.figure(1, (4/1.5, figheight/1.5))
fontsize = 0.3 * 72

bbox_props = dict(boxstyle="square,pad=0.3")

plt1.text(0.5, 0.85, transitions_file['a'],
	 horizontalalignment='center',
	 verticalalignment='center',
	 transform = plt1.transAxes)

plt2.text(0.5, 0.85, transitions_file['b'],
		  horizontalalignment='center',
		  verticalalignment='center',
		  transform = plt2.transAxes)


#f.text(0.5, (float(len(styles)) - 0.5)/figheight, stylename,
#		  ha="center",
#		  size=fontsize,
#		  transform=fig1.transFigure,
#		  bbox=dict(boxstyle=stylename, fc="w", ec="k"))

plt.savefig(transitions_file['a']+'-stats.pdf', format="pdf")

plt.show()

