from numpy  import *
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages

# load transition data. Each row is the list of trial stats per this one file
stats = loadtxt(open("../JavaLR-transitions.txt","rb"),delimiter=",",skiprows=0)
print var(stats[1])
means = [mean(filerow) for filerow in stats]

trials = len(stats[0])
N = len(stats)
index_of_95 = trials * 0.95 - 1

# Compute one-sided confidence interval.
# Find max value 5% from max value in sorted list
conf95 = [sort(filerow)[index_of_95] for filerow in stats]

plt.plot(stats[:,0])
plt.plot(stats[:,1])
plt.plot(stats[:,2])

#plt.hist(stats[70], bins=200)
#plt.hist(stats[90])
#plt.plot(means, linewidth=0.5)
#plt.plot(conf95, color="grey", linewidth=0.5)
#plt.axis(ymax=.2)
plt.xlabel('Files parsed', family="serif")
plt.legend(('ATN transition mean','95% one-sided confidence interval'),
		   loc='upper right' , prop={'family':'serif'})
plt.savefig('/tmp/stats.pdf', format="pdf")
plt.show()

