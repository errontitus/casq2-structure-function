# Program to generate a plot for mean B-factor for each residue in a PDB File
# Protein atoms only.
#
# Author: Dr. Walter Filgueira de Azevedo Jr.
# Date: February, 1st 2016.
#
# (with minor changes to input processing)
# Erron Titus, 3/6/2019

import sys

def read_file_name_interactive():
    """Function to read file name"""
    my_file = input("Type input file name => ")
    
    # Returns input file name
    return my_file

def read_file_name():
    """Function to read file name"""
    my_file = sys.argv[1]
    
    # Returns input file name
    return my_file

def read_PDB():
    """Function to read a PDB file"""
    # Sets initial list
    my_atoms = []
    
    # Calls function read_file_name()
    input_file_name = read_file_name()
    
    # Opens PDB file
    my_fo = open(input_file_name,"r")
    
    # Looping through PDB file content
    for line in my_fo:
        if line[0:6] == "ATOM  " or line[0:6] == "HETATM":
            my_atoms.append(line)
    
    my_fo.close()
    
    return my_atoms

def calculate_bfactors(list_of_atoms_in):
    """Function to calculate average B-factor for each residue"""
    import numpy as np
    
    # Calculates the number of atoms in the list_of_atoms_in
    count_atoms = len(list_of_atoms_in)
    
    bfactor = np.zeros(count_atoms)
    residues = np.zeros(count_atoms,int)
    bfactor_res = np.zeros(999)
    
    # To have different number of residue for the first iteration
    former_res = -9999
    new_res = -9998
    
    # Sets count_res and count_atoms to zero
    count_res = 0
    count_atoms = 0
    
    # Looping through list_of_atoms_in
    for line in list_of_atoms_in:
        if former_res == new_res:
            bfactor_res[count_atoms] =  float(line[61:65])
            new_res = int(line[22:26])
            count_atoms += 1
        else:
            new_res = int(line[22:26])
            former_res = new_res
            if count_res > 0:
                bfactor[count_res] = bfactor_res[0:count_atoms].mean()
                residues[count_res] = count_res
                count_res += 1
                count_atoms = 0
            else:
                count_res = int(line[22:26])    # Allows to get first residue
        
    # Returns arrays
    return residues[0:count_res],bfactor[0:count_res]    

def calc_prot_bfactors(list_of_atoms_in):  
    """Function to calculate average B-factor for each residue in a protein PDB"""
    import numpy as np
    
    # List of main-chain atoms
    list_mc =  ["CA","C ","O ","N ","OX"]
    
    # Sets lists for all, main-chain and side-chain atoms
    all_atoms = []
    mc_atoms = []
    sc_atoms = []
    
    # looping through all atoms in the list
    for line in list_of_atoms_in:
        if line[0:6] == "ATOM  ":
            all_atoms.append(line)      # Picks all atoms
            if line[13:15] in list_mc:  # Picks main-chain atoms
                mc_atoms.append(line)
            else:
                sc_atoms.append(line)   # Picks side-chain atoms
    
    # Calls function calculate_bfactors()
    nres, bf_all = calculate_bfactors(all_atoms) 
    nres, bf_mc = calculate_bfactors(mc_atoms)
    nres, bf_sc = calculate_bfactors(sc_atoms)
    
    # Sets initial matrix as a NumPy array
    columns = 4
    rows = len(nres)
    bf = np.array([[0]*columns]*rows,float)
    
    bf[:,0] = nres              # Gets residue number
    bf[:,1] = bf_all[:rows]     # Gets all atom B-factors
    bf[:,2] = bf_mc[:rows]      # Gets main-chain atom B-factor
    bf[:,3] = bf_sc[:rows]      # Gets side-chain atom B-factor
  
    return bf

def plot_mult_array(x,x_label_in,y_label_in,list_legends_in):
    """Function to plot two multi-dimensional arrays"""
    
    import matplotlib.pyplot as plt

    num_var = len(x[0,:])       # Number of variables
    x1 = x[1:,0]                # Gets array for number of residues (column 0)
    
    num_var = 2

    # Looping variables to get B-factor arrays
    for i in range(1,num_var):
        x2 = x[1:,i]            # Gets each column (1-3) for B-factors
        plt.plot(x1,x2,label=list_legends_in[i-1])  # Generates plot
    
    plt.legend(loc='upper left')    # Positioning the legends
    plt.xlabel(x_label_in)          # Adds axis label 
    plt.ylabel(y_label_in)          # Adds axis label
    plt.grid(True)                  # Adds grid to the plot

    plt.show()                      # Shows plot
    
    plt.savefig("bfactor.png")      # Saves plot on png file

# Main program

# Calls function to read PDB
my_list_of_atoms = read_PDB()

# Calls function to calculate mean B-factor for each residue (protein atoms only)
my_bfactors = calc_prot_bfactors(my_list_of_atoms)

# Creates a list of legends
list_legends = ["All","Main-chain","Side-chain"]

# Calls function to plot B-factor
plot_mult_array(my_bfactors,"Residue Number","B-factor(A**2)",list_legends)