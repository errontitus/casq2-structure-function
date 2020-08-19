from __future__ import print_function
from pymol import cmd
import sys
import csv
import pickle

# Image size and resolution
base_dpi = 300
quality_level = 1

def quality_adjust(x):
    return quality_level * x

def dpi():
    x = quality_adjust(base_dpi)
    print("dpi is " + str(x) + ".")
    return x

# The idea here is make 4x4 in images. A typical single column figure panel is 86 mm (or 89 mm in Nature),
# so a 4x4 in image will rarely be scaled larger and almost always scaled smaller. Thus, assuming high dpi, 
# pixellation will never be apparent to the viewer as long as you make your images 4 in or larger. 
def default_image_size():
    return dpi() * 4

def save_image_default(filename):
    cmd.bg_color("white")
    cmd.ray(default_image_size(), default_image_size())
    cmd.png("./output/" + filename + ".png", dpi=dpi())
    cmd.bg_color("black")
    return 

def ray_width_dimer():
    return default_image_size()

def ray_height_dimer():
    return default_image_size() * 0.75

def save_image_dimer(filename):
    cmd.bg_color("white")
    cmd.ray(ray_width_dimer(), ray_height_dimer())
    cmd.png("./output/" + filename + ".png", dpi=dpi())
    cmd.bg_color("black")
    return 

def ray_width_dimer_interface():
    return default_image_size()

def ray_height_dimer_interface():
    return default_image_size()

def ray_width_closeups():
    return default_image_size()

def ray_height_closeups():
    return default_image_size() * 0.75

def save_image_closeup(filename, width=ray_width_closeups(), height=ray_height_closeups()):
    cmd.bg_color("white")
    cmd.ray(width, height)
    cmd.png("./output/" + filename + ".png", dpi=dpi())
    cmd.bg_color("black")
    return 

def ray_width_tetramer():
    return default_image_size()

def ray_height_tetramer():
    return default_image_size() * 0.60

def save_image_tetramer(filename):
    cmd.bg_color("white")
    cmd.ray(ray_width_tetramer(), ray_height_tetramer())
    cmd.png("./output/" + filename + ".png", dpi=dpi())
    cmd.bg_color("black")
    return 

def ray_width_tetramer_alignment():
    return default_image_size()

def ray_height_tetramer_alignment():
    return default_image_size()

def ray_width_tetramer_interface():
    return default_image_size()

def ray_height_tetramer_interface():
    return default_image_size()

def ray_height_filament():
    return default_image_size()

def ray_width_filament():
    return default_image_size()

def save_image_filament(filename):
    cmd.bg_color("white")
    cmd.ray(ray_width_filament(), ray_height_filament())
    cmd.png("./output/" + filename + ".png", dpi=dpi())
    cmd.bg_color("black")
    return 

# Colors
def chainA_color(theme_id=1):
    if theme_id == 1:
#        return "wheat"
        return "orange"
    if theme_id == 2:
        return "hotpink"
    if theme_id == 3:
        return "cyan"
    if theme_id == 4:
        return "cb_green"

def chainB_color(theme_id=1):
    if theme_id == 1:
#        return "skyblue"
        return "forest"
    if theme_id == 2:
        return "yellow" # marine"
    if theme_id == 3:
        return "tv_blue"
    if theme_id == 4:
        return "cb_orange"

def chainC_color(theme_id=1):
    if theme_id == 1:
#        return chainA_color(1)
        return "skyblue"
    if theme_id == 2:
        return chainA_color(2)
    if theme_id == 3:
        return chainA_color(3)

def chainD_color(theme_id=1):
    if theme_id == 1:
#        return chainB_color(1)
        return "gold"
    if theme_id == 2:
        return chainB_color(2)
    if theme_id == 3:
        return chainB_color(3)

def domain_color(domain_id):
    if domain_id == 1:
        return "purple"
    if domain_id == 2:
        return "greencyan"  
    if domain_id == 3:
        return "slate"    

def default_stick_transparency():
    return 0.5

def default_cartoon_transparency():
    return 0.5

def default_surface_transparency():
    return 0.4

def chainA_HighlightColor():
    # No change.
    return "magenta"

def chainB_HighlightColor():
    # No change
    return "marine"

def chainC_HighlightColor():
    # Change to dark blue (but probably revise this since it collides with nitrogen)
    # Red is bad for the same reason.
    return "purple"

def chainD_HighlightColor():
    # Darken to purple.
    return "blue"

def yb_color():
    # https://en.wikipedia.org/wiki/CPK_coloring
    # Ca should be dark green.
#    return "forest"
    return "magenta"

def cl_color():
    # https://en.wikipedia.org/wiki/CPK_coloring
    # Ca should be dark green.
    return "green"

def cavity_color():
    return "cyan"

def water_color():
    return "blue"

def apply_standard_colors_hetatm():
    cmd.color(yb_color(), "elem Yb")
    cmd.color(cl_color(), "elem Cl")
    cmd.color(water_color(), "resn HOH")
    return 

def apply_standard_colors_dimer(sele, theme_id=1):
    cmd.color(chainA_color(theme_id), "chain A and elem C and " + sele)
    cmd.color(chainB_color(theme_id), "chain B and elem C and " + sele)
    cmd.color(chainC_color(theme_id), "chain C and elem C and " + sele)
    cmd.color(chainD_color(theme_id), "chain D and elem C and " + sele)
    apply_standard_colors_hetatm()
    return

def apply_standard_colors_tetramer(sele, theme_id=1):
    cmd.color(chainA_color(theme_id), "chain A and elem C and " + sele)
    cmd.color(chainB_color(theme_id), "chain B and elem C and " + sele)
    cmd.color(chainC_color(theme_id), "chain C and elem C and " + sele)
    cmd.color(chainD_color(theme_id), "chain D and elem C and " + sele)
    apply_standard_colors_hetatm()
    return

def apply_standard_colors(sele, object_type, theme_id=1):
    cmd.color(chainA_color(theme_id), "chain A and elem C and " + sele)
    cmd.color(chainB_color(theme_id), "chain B and elem C and " + sele)
    if (object_type == "T") or (object_type == "F"):
        cmd.color(chainC_color(theme_id), "chain C and elem C and " + sele)
        cmd.color(chainD_color(theme_id), "chain D and elem C and " + sele)
    if object_type == "F":    
        cmd.color(chainA_color(theme_id), "chain E and elem C and " + sele)
        cmd.color(chainB_color(theme_id), "chain F and elem C and " + sele)
        cmd.color(chainC_color(theme_id), "chain G and elem C and " + sele)
        cmd.color(chainD_color(theme_id), "chain H and elem C and " + sele)
        cmd.color(chainA_color(theme_id), "chain I and elem C and " + sele)
        cmd.color(chainB_color(theme_id), "chain J and elem C and " + sele)
        cmd.color(chainC_color(theme_id), "chain K and elem C and " + sele)
        cmd.color(chainD_color(theme_id), "chain L and elem C and " + sele)
        cmd.color(chainA_color(theme_id), "chain M and elem C and " + sele)
        cmd.color(chainB_color(theme_id), "chain N and elem C and " + sele)
    apply_standard_colors_hetatm()
    return

def apply_standard_colors_filament(sele, theme_id=1):
    cmd.color(chainA_color(theme_id), "chain A and elem C and " + sele)
    cmd.color(chainB_color(theme_id), "chain B and elem C and " + sele)
    cmd.color(chainC_color(theme_id), "chain C and elem C and " + sele)
    cmd.color(chainD_color(theme_id), "chain D and elem C and " + sele)
    cmd.color(chainA_color(theme_id), "chain E and elem C and " + sele)
    cmd.color(chainB_color(theme_id), "chain F and elem C and " + sele)
    cmd.color(chainC_color(theme_id), "chain G and elem C and " + sele)
    cmd.color(chainD_color(theme_id), "chain H and elem C and " + sele)
    cmd.color(chainA_color(theme_id), "chain I and elem C and " + sele)
    cmd.color(chainB_color(theme_id), "chain J and elem C and " + sele)
    cmd.color(chainC_color(theme_id), "chain K and elem C and " + sele)
    cmd.color(chainD_color(theme_id), "chain L and elem C and " + sele)
    cmd.color(chainA_color(theme_id), "chain M and elem C and " + sele)
    cmd.color(chainB_color(theme_id), "chain N and elem C and " + sele)
    apply_standard_colors_hetatm()
    return

def apply_standard_colors_filament_surfaces(sele, theme_id=1):
    cmd.set("surface_color",chainA_color(theme_id), "chain A and " + sele)
    cmd.set("surface_color",chainB_color(theme_id), "chain B and " + sele)
    cmd.set("surface_color",chainC_color(theme_id), "chain C and " + sele)
    cmd.set("surface_color",chainD_color(theme_id), "chain D and " + sele)
    cmd.set("surface_color",chainA_color(theme_id), "chain E and " + sele)
    cmd.set("surface_color",chainB_color(theme_id), "chain F and " + sele)
    cmd.set("surface_color",chainC_color(theme_id), "chain G and " + sele)
    cmd.set("surface_color",chainD_color(theme_id), "chain H and " + sele)
    cmd.set("surface_color",chainA_color(theme_id), "chain I and " + sele)
    cmd.set("surface_color",chainB_color(theme_id), "chain J and " + sele)
    cmd.set("surface_color",chainC_color(theme_id), "chain K and " + sele)
    cmd.set("surface_color",chainD_color(theme_id), "chain L and " + sele)
    cmd.set("surface_color",chainA_color(theme_id), "chain M and " + sele)
    cmd.set("surface_color",chainB_color(theme_id), "chain N and " + sele)
    apply_standard_colors_hetatm()
    return

def apply_standard_colors_filament_spheres(sele, theme_id=1):
    cmd.color(chainA_color(theme_id), "chain A and " + sele)
    cmd.color(chainB_color(theme_id), "chain B and " + sele)
    cmd.color(chainC_color(theme_id), "chain C and " + sele)
    cmd.color(chainD_color(theme_id), "chain D and " + sele)
    cmd.color(chainA_color(theme_id), "chain E and " + sele)
    cmd.color(chainB_color(theme_id), "chain F and " + sele)
    cmd.color(chainC_color(theme_id), "chain G and " + sele)
    cmd.color(chainD_color(theme_id), "chain H and " + sele)
    cmd.color(chainA_color(theme_id), "chain I and " + sele)
    cmd.color(chainB_color(theme_id), "chain J and " + sele)
    cmd.color(chainC_color(theme_id), "chain K and " + sele)
    cmd.color(chainD_color(theme_id), "chain L and " + sele)
    cmd.color(chainA_color(theme_id), "chain M and " + sele)
    cmd.color(chainB_color(theme_id), "chain N and " + sele)
    apply_standard_colors_hetatm()
    return

def apply_standard_colors_tetramer_spheres(sele, theme_id=1):
    cmd.color(chainA_color(theme_id), "chain A and " + sele)
    cmd.color(chainB_color(theme_id), "chain B and " + sele)
    cmd.color(chainC_color(theme_id), "chain C and " + sele)
    cmd.color(chainD_color(theme_id), "chain D and " + sele)
    apply_standard_colors_hetatm()
    return

def apply_standard_colors_dimer_spheres(sele, theme_id=1):
    cmd.color(chainA_color(theme_id), "chain A and " + sele)
    cmd.color(chainB_color(theme_id), "chain B and " + sele)
    apply_standard_colors_hetatm()
    return

def apply_standard_color_cavity(sele, theme_id=1):
    cmd.set("surface_color", cavity_color(), sele)
    apply_standard_colors_hetatm()
    return


# Zooms
def zoom_complete(selection):
    # To absolutely prevent clipping, you need both complete=1 and a further 2 A buffer (at least).
    # The complete=1 setting on its own fails to compensate for small movements that result from 
    # perspective shifts. See https://pymolwiki.org/index.php/Zoom
    cmd.zoom(selection, buffer=2.0, complete=1) 

def zoom_dimer_1a8y(object_name):
    # Get a neutral, symmetric view of the molecule(s)
#    cmd.viewport(viewport_width_dimer(), viewport_height_dimer())
    cmd.orient(object_name)
    cmd.zoom("center", 35)
    cmd.translate([0,4,0], "(all)")
    return

def zoom_dimer(object_name):
    # Get a neutral, symmetric view of the molecule(s)
#    cmd.viewport(viewport_width_dimer(), viewport_height_dimer())
    cmd.orient(object_name)
    cmd.zoom("center", 35)
    cmd.translate([0,4,0], "(all)")
    return

def zoom_tetramer_deo(object_name):
    # Get a neutral, symmetric view of the molecule(s)
    # Note: this is the best view overall, but not the best view for observing the interface.
#    cmd.viewport(viewport_width_tetramer(), viewport_height_tetramer())
    cmd.orient(object_name)
#    cmd.rotate("x", 180)
    cmd.rotate("y", 180)
    cmd.zoom("center", 45)
    return

def zoom_tetramer_1a8y(object_name):
    # Get a neutral, symmetric view of the molecule(s)
#    cmd.viewport(viewport_width_tetramer(), viewport_height_tetramer())
    cmd.orient(object_name)
    cmd.rotate("y", 180)
    cmd.zoom("center", 45)
    return

def zoom_tetramer_any(object_name):
    # Get a neutral, symmetric view of the molecule(s)
    # No rotations allowed, since this is generic for many tetramers that may or may not be oriented with respect to 1a8y.
#    cmd.viewport(viewport_width_tetramer(), viewport_height_tetramer())
    cmd.orient(object_name)
    cmd.zoom(object_name, 45)
    return

def rezoom_tetramer_deo_alignment(target, mobile_pdb):
#    cmd.viewport(viewport_width_tetramer_alignment(), viewport_height_tetramer_alignment())
    cmd.orient(target)
    cmd.zoom("center", 75)
    y = tetramer_alignment_centering_y(mobile_pdb)
    cmd.translate([0,y,0], "(all)")
    return

def zoom_tetramer(object_name):
    # Get a neutral, symmetric view of the molecule(s)
#    cmd.viewport(viewport_width_tetramer(), viewport_height_tetramer())
    cmd.orient(object_name)
    cmd.zoom("center", 45)
    return

def zoom_tetramer_spheres(object_name):
    # Get a neutral, symmetric view of the molecule(s)
#    cmd.viewport(viewport_width_tetramer(), viewport_height_tetramer())
    cmd.orient(object_name)
    cmd.zoom("center", 55)
    return

def rezoom_tetramer_interface(object_name):
#    cmd.viewport(viewport_width_tetramer_interface(), viewport_height_tetramer_interface())
    cmd.orient(object_name)
    cmd.zoom("center", 35)
    return

def tetramer_alignment_centering_y(pdb):
    switcher = {
        "1a8y": -20,
        "1sji": 20,
        "2vaf": 0
    }
    return switcher.get(pdb, 0)


def tetramer_image_rotation_increment(pdb):
    switcher = {
        "deo_native": 180,
        # "1sji": 0,
        # "2vaf": 0,
        # "3uom": 0,
        # "5cre": 0,
        # "5crg": 0,
        # "5crh": 0,
        # "5kn1": 0, # 90,
        # "5kn2": 0, # 90
    }
    return switcher.get(pdb, 0)

def tetramer_image_interface_rotation_increment(pdb):
    switcher = {
        "deo_native": 270,
        # "1sji": 0,
        # "2vaf": 0,
        # "3uom": 0,
        # "5cre": 0,
        # "5crg": 0,
        # "5crh": 0,
        # "5kn1": 0, # 90,
        # "5kn2": 0, # 90
    }
    return switcher.get(pdb, 0)

# def apply_custom_view(pdb):
#     # 5crh needs a bit of help to be oriented into the same view as 5crg.
#     if pdb == "5crh":
#         cmd.set_view ([-0.983348846,   -0.173023999,    0.055581983,
#             -0.013358761,    0.373839378,    0.927396059,
#             -0.181242362,    0.911211073,   -0.369926721,
#             -0.000068858,   -0.000118464, -586.029724121,
#             -10.942100525,   50.099952698,   63.575683594,
#             223.742614746,  948.237121582,  -20.000000000])
    # if pdb == "5crg":
    #     cmd.set_view ([0.686482966,   -0.716966629,    0.121229753,
    #         -0.342863083,   -0.466184080,   -0.815547287,
    #         0.641235530,    0.518293977,   -0.565851510,
    #         0.000000000,    0.000000000, -368.704650879,
    #         223.555419922,   54.516765594,   39.276351929,
    #         290.689575195,  446.719726562,  -20.000000000])
#    return

def select_dimer_yb(name, source_sele_name):
    cmd.select(name, "elem Yb within 4.0 of ((resi 143 or resi 147 or resi 310) and (" + source_sele_name + "))")

def select_dimer_yb_residues(name, source_sele_name):
    cmd.select(name, "(resi 136 or resi 140 or resi 143 or resi 147 or resi 275 or resi 277 or resi 278 or resi 280 or resi 309 or resi 310) and (" + source_sele_name + ")")
    return 
    
def select_tetramer_yb(name, source_BC_name, source_AD_name):
    # Breaking this up only for readability.
    cmd.select("_tetramer_sel1", "elem Yb within 4 of ((resi 187 or resi 174) and (" + source_BC_name + "))")
    cmd.select("_tetramer_sel2", "elem Yb within 4.5 of ((resi 351 or resi 348) and (" + source_AD_name + "))")
    cmd.select(name, "_tetramer_sel1 or _tetramer_sel2")
    return

def select_tetramer_yb_thio23_only(name, source_BC_name, source_AD_name):
    source_BC_name_thio23 = "(" + source_BC_name + ") and (resi 144)"
    select_tetramer_yb(name, source_BC_name_thio23, source_AD_name)
    return 

def select_tetramer_yb_residues(name, source_BC_name, source_AD_name):
    cmd.select("_tetramer_residue_sel1", "(resi 47 or resi 49 or resi 50 or resi 144 or resi 174 or resi 180 or resi 183 or resi 184 or resi 187 or resi 188 or resi 121) and (" + source_BC_name + ")")
    cmd.select("_tetramer_residue_sel2", "(resi 348 or resi 350 or resi 351 or resi 357) and (" + source_AD_name + ")")
    cmd.select(name, "_tetramer_residue_sel1 or _tetramer_residue_sel2")
    return 

def select_tetramer_yb_residues_thio23_only(name, source_BC_name, source_AD_name):
    source_BC_name_thio23 = "(" + source_BC_name + ") and (resi 144 or resi 174)"
    select_tetramer_yb_residues(name, source_BC_name_thio23, source_AD_name)
    return 

def apply_domain_colors(theme_id, domain_id, source_object, pdb_code):
    target = thioredoxin_domain_selection(pdb_code, domain_id, source_object)
    cmd.color(domain_color(domain_id), target)
    cmd.set("surface_color", domain_color(domain_id), target)

    return

def color_thioredoxin_domains(pdb_code, object):
    apply_domain_colors(1, 1, object, pdb_code)
    apply_domain_colors(1, 2, object, pdb_code)
    apply_domain_colors(1, 3, object, pdb_code)

def color_thioredoxin_globes():
    cmd.color(domain_color(1), "ps*1")
    cmd.color(domain_color(2), "ps*2")
    cmd.color(domain_color(3), "ps*3")
    return

def thioredoxin_domain_selection(pdb_code, domain_number, source_object):
    # This code is a bit complicated because I didn't renumber the residues in the other structures
    # to match canonical numbering when making the filament. Could consider that to simplify.
    if pdb_code == "1a8y":
        if domain_number == 1:
            sele = "resi 3-124 and polymer and " + source_object
        elif domain_number == 2:
            sele = "resi 125-227 and polymer and " + source_object
        elif domain_number == 3:
            sele = "resi 228-347 and polymer and " + source_object
    elif pdb_code == "1sji":
        if domain_number == 1:
            sele = "resi 3-124 and polymer and " + source_object
        elif domain_number == 2:
            sele = "resi 125-227 and polymer and " + source_object
        elif domain_number == 3:
            sele = "resi 228-352 and polymer and " + source_object
    elif pdb_code == "deo_yb":
        if domain_number == 1:
            sele = "resi 20-143 and polymer and " + source_object
        elif domain_number == 2:
            sele = "resi 144-246 and polymer and " + source_object
        elif domain_number == 3:
            sele = "resi 247-371 and polymer and " + source_object
    elif pdb_code == "deo_native":
        if domain_number == 1:
            sele = "resi 20-143 and polymer and " + source_object
        elif domain_number == 2:
            sele = "resi 144-246 and polymer and " + source_object
        elif domain_number == 3:
            sele = "resi 247-371 and polymer and " + source_object
    return sele

def create_thioredoxin_domains(chain_list, pdb_code, source_object, create_globes = 0):
    for chain_id in chain_list:
        domain1_name = chain_id + "1"
        domain2_name = chain_id + "2"
        domain3_name = chain_id + "3"

        domain_1_residues = thioredoxin_domain_selection(pdb_code, 1, source_object)
        domain_2_residues = thioredoxin_domain_selection(pdb_code, 2, source_object)
        domain_3_residues = thioredoxin_domain_selection(pdb_code, 3, source_object)

        cmd.select(domain1_name, "chain " + chain_id + " and " + domain_1_residues)    
        cmd.select(domain2_name, "chain " + chain_id + " and " + domain_2_residues)    
        cmd.select(domain3_name, "chain " + chain_id + " and " + domain_3_residues)

        if create_globes == 1:
            ps1_name = "ps" + domain1_name
            ps2_name = "ps" + domain2_name
            ps3_name = "ps" + domain3_name
            cmd.pseudoatom(ps1_name, selection=domain1_name, chain=chain_id)
            cmd.pseudoatom(ps2_name, selection=domain2_name, chain=chain_id)
            cmd.pseudoatom(ps3_name, selection=domain3_name, chain=chain_id)

    if create_globes == 1:
        # Only works if you have not set sphere_scale globally for hetatm.
        cmd.set("sphere_scale", 1.1, "ps*")
    
    return


def get_arg1():
    return sys.argv[1]

def get_arg2():
    return sys.argv[2]

# Mainly for when I'm having trouble deciding on the best view.
def rotation_series(axis, increment, width, height, filename, with_centering):
    if (increment == 0):
        max_turns = 1
    else:
        max_turns = (360/increment) + 1

    for x in range(max_turns):    
        if x > 0: cmd.rotate(axis, increment)
        if with_centering: cmd.center("(all)")
        cmd.ray(width, height)
        cmd.png(filename + "_" + str(x * increment) + ".png", dpi=dpi())
    return

def write_interface_residue_list_to_file(residue_list, filename):
    pickle.dump(residue_list, open(filename, "wb" ))
    # for residue in residue_list:
    #     if residue[0] == "chA":
    #         f.write()            
    # keys = residue_list[0].keys()
    # with open(filename, "wb") as output_file:
    #     dict_writer = csv.DictWriter(output_file, keys)
    #     dict_writer.writeheader()
    #     dict_writer.writerows(residue_list)

def write_fasta_file(fasta, filename):
    with open(filename, "wb") as f:
        f.write(fasta)

cmd.extend("apply_standard_colors_filament", apply_standard_colors_filament)
cmd.extend("apply_standard_colors_tetramer", apply_standard_colors_tetramer)
cmd.extend("apply_standard_colors_dimer", apply_standard_colors_dimer)
cmd.extend("tetramer_image_rotation_increment", tetramer_image_rotation_increment)
cmd.extend("get_arg1", get_arg1)
cmd.extend("get_arg2", get_arg2)
cmd.extend("rotation_series", rotation_series)
cmd.extend("zoom_complete", zoom_complete)
cmd.extend("write_interface_residue_list_to_file", write_interface_residue_list_to_file)
cmd.extend("write_fasta_file", write_fasta_file)

