import sys
import os
from os.path import basename
from PIL import Image, ImageChops

# Usage:
# crop ./output/dimer_cavity_axial.png [reference file to use for bounding box]
# Pass the second argument when you need to crop multiple different images to the same size.

def get_bbox(im):
    bg = Image.new(im.mode, im.size, im.getpixel((0,0)))
    diff = ImageChops.difference(im, bg)
    diff = ImageChops.add(diff, diff, 2.0, -100)
    bbox = diff.getbbox()
    if bbox:
        return bbox

# def trim(im):
#     bg = Image.new(im.mode, im.size, im.getpixel((0,0)))
#     diff = ImageChops.difference(im, bg)
#     diff = ImageChops.add(diff, diff, 2.0, -100)
#     bbox = diff.getbbox()
#     if bbox:
#         return im.crop(bbox)

def trim(im, bbox):
    if bbox:
        return im.crop(bbox)

input_file = sys.argv[1]
reference_file = ""

im = Image.open(input_file)
print "Original size of " + input_file + ": " 
print im.size

if len(sys.argv) > 2:
    reference_file = sys.argv[2]
    im_ref = Image.open(reference_file)
    bbox = get_bbox(im_ref)
else:
    bbox = get_bbox(im)

im2 = trim(im, bbox)
print "New size: " 
print im2.size

head, tail = os.path.split(input_file)

new_filename = "./output/" + basename(os.path.splitext(input_file)[0]) + "_cropped" + os.path.splitext(input_file)[1]
im2.save(new_filename)


####################
# Simpler approach below does not work. Presumably PyMOL puts a non-zero value 
# in the background pixels even when the alpha channel is set to 0.

# im = Image.open(input_file)
# print im.size
# # (364, 471)

# im.getbbox()
# # (64, 89, 278, 267)

# im2 = im.crop(im.getbbox())
# print im2.size
# # (214, 178)
####################
