import sys
import os
from os.path import basename
from PIL import Image, ImageChops


input_file = sys.argv[1]
print input_file

im = Image.open(input_file)
print "Original size of " + input_file + ": " 
print im.size

  # Setting the points for cropped image 
left = float(sys.argv[2])
top = float(sys.argv[3])
right = float(sys.argv[4])
bottom = float(sys.argv[5])

# Cropped image
# (It will not change orginal image) 
print "here"
im2 = im.crop((left, top, right, bottom)) 
print "New size: " 
print im2.size

head, tail = os.path.split(input_file)

new_filename = "./output/" + basename(os.path.splitext(input_file)[0]) + "_cropped" + os.path.splitext(input_file)[1]
im2.save(new_filename)
