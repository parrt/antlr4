for i in range(1,400,1):
	f = open("%04d" % i, "w")
	f.write('x'*i)
#	f.write('x'*int(i*0.5))
	f.write('\n')
#	f.write('y'*int(i*0.5))
	f.close()
