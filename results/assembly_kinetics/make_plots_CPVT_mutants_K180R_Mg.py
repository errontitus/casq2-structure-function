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
less_golden = 1.4

##################### K180R Mg series

    # Layout:
    # A WT, Mg 90 mins
    # B WT, Mg, 0 mins
    # C WT, No Mg
    # D K180R, Mg, 90 mins
    # E K180R, Mg, 0 mins
    # F K180R, No Mg
    # G NP No Mg
    # H NP Mg

WT_Ca_Mg_90mins = BioTek.clean_data_K180R_varying_Mg(["Kinetic read"], ["A1", "A2", "A3"], "WT with Mg, 90 mins pre-incubation")
WT_Ca_Mg_0mins = BioTek.clean_data_K180R_varying_Mg(["Kinetic read"], ["B1", "B2", "B3"], "WT with Mg, 0 mins pre-incubation")
WT_Ca_0Mg = BioTek.clean_data_K180R_varying_Mg(["Kinetic read"], ["C1", "C2", "C3"], "WT, no Mg")


K180R_Mg_90 = BioTek.clean_data_K180R_varying_Mg(["Kinetic read"], ["D1", "D2", "D3"], "K180R with Mg, 90 mins pre-incubation")
K180R_Mg_0 = BioTek.clean_data_K180R_varying_Mg(["Kinetic read"], ["E1", "E2", "E3"], "K180R with Mg, 0 mins pre-incubation")
K180R_No_Mg = BioTek.clean_data_K180R_varying_Mg(["Kinetic read"], ["F1", "F2", "F3"], "K180R without Mg")

# Legend postion options
	# right
	# center left
	# upper right
	# lower right
	# best
	# center
	# lower left
	# center right
	# upper left
	# upper center
	# lower center

# K180R Turbidity After Mg Preincubation
fig_K180R_Mg = BioTek.plot_K180R_Mg(WT_Ca_Mg_0mins, WT_Ca_Mg_90mins, K180R_Mg_0, K180R_Mg_90, xLabel, yLabel, 24, 0.2, "CASQ2 K180R Turbidity with Mg", "", (0.2,0.42), 1.75, golden)
fig_K180R_Mg.savefig("./output/kinetics_CPVT_mutations_K180R_Mg.pgf", bbox_inches="tight")
fig_K180R_Mg.savefig("./output/kinetics_CPVT_mutations_K180R_Mg.pdf", bbox_inches="tight")

#

