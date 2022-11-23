import os
import numpy as np
import idx2numpy

num_of_images = 128

training_images=idx2numpy.convert_from_file('train-images.idx3-ubyte')[0:num_of_images]
training_labels=idx2numpy.convert_from_file('train-labels.idx1-ubyte')[0:num_of_images]

with open("data.l","w") as f:
	f.write("(setq *Inputs\n   '((")
	for i in range(num_of_images):
		np.savetxt(f, training_images[i].reshape(1,784), delimiter=" ", fmt='%.1f',newline="")
		if i==num_of_images-1:
			f.write("))")
		else:
			f.write(")\n     (")
	f.write("\n)\n\n")
	
	f.write("(setq *Outputs\n   '((")
	training_labels=training_labels.reshape(num_of_images,1)
	for i in range(num_of_images):
		np.savetxt(f, training_labels[i], fmt='%.1f',newline="")
		if i==num_of_images-1:
			f.write("))")
		else:
			f.write(")\n     (")
	f.write("\n)")