import os
import sys
from math import sqrt
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

##################### CPVT mutants

    # 85 mM KCl
    # A7-9 NP, A10-12 D325E
    # B7-9 WT, B10-12 R251H
    # C7-9 Y55C, C10-12 S173I
    # D7-9 F189L, D10-12 K180R
    # E7-9 P308L, E10-12 R33Q

WT_Ca_85K = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["B7", "B8", "B9"], "WT")
S173I_Ca_85K = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["C10", "C11", "C12"], "S173I")
K180R_Ca_85K = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["D10", "D11", "D12"], "K180R")

# This was done in a batch with Jason's mutants.
# R33Q_Ca_85K = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["E10", "E11", "E12"], "R33Q")
# P308L_Ca_85K = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["E7", "E8", "E9"], "P308L")
# Y55C_Ca_85K = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["C7", "C8", "C9"], "Y55C")
# D325E_Ca_85K = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["A10", "A11", "A12"], "D325E")
# R251H_Ca_85K = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["B10", "B11", "B12"], "R251H")

# S173I Turbidity After 1 mM Calcium (in 85 mM KCl)
fig_S173I_85K = BioTek.plot_vs_WT(WT_Ca_85K, S173I_Ca_85K, "S173I", xLabel, yLabel, 40, 0.13, "CASQ2 S173I Turbidity", "", "upper left",1.75, golden)
fig_S173I_85K.savefig("./output/kinetics_CPVT_mutation_S173I_85mM_K.pgf")

# K180R Turbidity After 1 mM Calcium (in 85 mM KCl)
fig_K180R_85K = BioTek.plot_vs_WT(WT_Ca_85K, K180R_Ca_85K, "K180R", xLabel, yLabel, 40, 0.13, "CASQ2 K180R Turbidity", "", "upper left",1.75, golden)
fig_K180R_85K.savefig("./output/kinetics_CPVT_mutation_K180R_85mM_K.pgf")

WT_Ca_0K = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["F7", "F8", "F9"], "WT")
S173I_Ca_0K = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["F4", "F5", "F6"], "S173I")
K180R_Ca_0K = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["G4", "G5", "G6"], "K180R")

# Jason's mutants
# R33Q_Ca_0K = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["H4", "H5", "H6"], "R33Q")
# P308L_Ca_0K = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["F10", "F11", "F12"], "P308L")
# Y55C_Ca_0K = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["G7", "G8", "G9"], "Y55C")
# D325E_Ca_0K = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["G10", "G11", "G12"], "D325E")
# R251H_Ca_0K = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["H10", "H11", "H12"], "R251H")

fig_S173I_0K = BioTek.plot_vs_WT(WT_Ca_0K, S173I_Ca_0K, "S173I", xLabel, yLabel, 40, 0.13, "CASQ2 S173I Turbidity (0 mM KCl)", "0 mM KCl", "upper left", 2.25, golden)
fig_S173I_0K.savefig("./output/kinetics_CPVT_mutation_S173I_0mM_K.pgf")
fig_S173I_0K.savefig("./output/kinetics_CPVT_mutation_S173I_0mM_K.pdf")

fig_K180R_0K = BioTek.plot_vs_WT(WT_Ca_0K, K180R_Ca_0K, "K180R", xLabel, yLabel, 40, 0.13, "CASQ2 K180R Turbidity (0 mM KCl)", "0 mM KCl", "upper left", 2.25, golden)
fig_K180R_0K.savefig("./output/kinetics_CPVT_mutation_K180R_0mM_K.pgf")
fig_K180R_0K.savefig("./output/kinetics_CPVT_mutation_K180R_0mM_K.pdf")

