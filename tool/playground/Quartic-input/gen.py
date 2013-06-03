for i in range(1,10,2):
	f = open(str(i), "w")
	f.write('x'*int(i*0.5))
	f.write('y'*int(i*0.5))
	f.close()
