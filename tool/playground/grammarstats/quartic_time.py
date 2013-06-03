from numpy  import *
import matplotlib.pyplot as plt

transitions_file = 'Quartic-timings'

# load timing data; column of times per file
f = open(transitions_file+'.txt',"rb")
timing = []
for line in f.readlines():
	timing.append(int(line.strip()))

trials = 1
N = len(timing)

x = array(arange(0,170,1))

# fit polynomial max 5
fit = polyfit(x, array(timing), 3)
poly = poly1d(fit)
print poly
y = poly(x)

# 0.0407 x^3 - 4.644 x^2 + 188 x - 1378

plt.plot(y, color="red", linewidth=0.5)
plt.plot(timing, color="blue", linewidth=0.5)
plt.ylabel('Wallclock parse time (ms)', family="serif")
plt.title(transitions_file+" (files N="+str(N)+")")
plt.xlabel('File size in tokens (x, xx, xxx, ...)', family="serif")
plt.savefig(transitions_file+'-stats.pdf', format="pdf")
plt.show()