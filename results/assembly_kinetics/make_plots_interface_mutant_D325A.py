import os
import sys
from math import sqrt
from matplotlib.backends.backend_pdf import PdfPages
import matplotlib.pyplot as plt
import matplotlib

from lib import BioTek

# Assay conditions:
# Buffer: Turbidity Assay Buffer (TAB, 15 mM Tris pH 7.4, 20 mM NaCl, 85 mM KCl)
# EDTA Dialysis: 10 mM in TAB
# Plate type: uClear, black or clear, half-area
# Calcium: 7 uL of 20 mM Ca added for final concentration of 1 mM
# EDTA: 7 uL of 20 mM EDTA added for final concentration of 1 mM

# Additional mutant D325A requested by reviewer because D325I was a too aggressive substitution.

xLabel = "Minutes after Calcium Addition"
yLabel = "Abs at 350 nm"

# For debugging
# background_offset = BioTek.background_mean_from_matrix(filename, background_matrix_header_row, background_matrix_nrows, "A", "4", "6")
# exit()

# For debugging
# import pandas as pd
# filename = filename
# #cols = ["Kinetic read", "A7", "A8", "A9"]
# header = 21
# nrows = 113
# raw = pd.read_csv(filepath_or_buffer=filename, header=header, sep="\t", nrows=nrows)
# print raw
# exit() 


matplotlib.rcParams.update({'font.size': 8})
matplotlib.rcParams.update({"legend.handlelength": 0.5})
matplotlib.rcParams.update({"legend.frameon": False})
golden = 1.61803398875

##################### Interface mutants

    # A NP
    # B WT
    # C D325I
    # D D325A

WT_Ca_85K_interface = BioTek.clean_data_interface_mutant_D325A(["Kinetic read"], ["B1", "B2", "B3"], "WT")
D325I_Ca_85K_interface = BioTek.clean_data_interface_mutant_D325A(["Kinetic read"], ["C1", "C2", "C3"], "D325I")
D325A_Ca_85K_interface = BioTek.clean_data_interface_mutant_D325A(["Kinetic read"], ["D1", "D2", "D2"], "D325A")


# D325I Turbidity After 1 mM Calcium (in 85 mM KCl)
fig_D325I_Ca_85K_interface = BioTek.plot_vs_WT(WT_Ca_85K_interface, D325I_Ca_85K_interface, "D325I", xLabel, yLabel, 40, 0.13, "CASQ2 D325I Turbidity", "", "lower right", 1.75, golden)
fig_D325I_Ca_85K_interface.savefig("./output/kinetics_interface_mutation_D325I_85mM_K.pgf")

# D325A Turbidity After 1 mM Calcium (in 85 mM KCl)
fig_D325A_Ca_85K_interface = BioTek.plot_vs_WT(WT_Ca_85K_interface, D325A_Ca_85K_interface, "D325A", xLabel, yLabel, 40, 0.13, "CASQ2 D325A Turbidity", "", "lower right", 1.75, golden)
fig_D325A_Ca_85K_interface.savefig("./output/kinetics_interface_mutation_D325A_85mM_K.pgf")
fig_D325A_Ca_85K_interface.savefig("./output/kinetics_interface_mutation_D325A_85mM_K.pdf")
