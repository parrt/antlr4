from numpy  import *
import matplotlib.pyplot as plt

# load transition data. Each row is the list of trial stats per this one file
stats = loadtxt(open("../JavaLR-transitions.txt","rb"),delimiter=",",skiprows=0)
print stats[2]
plt.plot(stats[2])
plt.show()