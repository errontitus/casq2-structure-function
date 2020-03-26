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

##################### Interface mutants

    # A NP
    # B WT
    # C D325I
    # D D50A
    # E D144A E174A
    # F E184A E187A
    # G D348A D350A
    # H D351A D357A
    #
    # 85 mM KCl in wells 7-9, 0 mM KCl in wells 10-12

WT_Ca_85K_interface = BioTek.clean_data_interface_mutants(["Kinetic read"], ["B7", "B8", "B9"], "WT")
D325I_Ca_85K_interface = BioTek.clean_data_interface_mutants(["Kinetic read"], ["C7", "C8", "C9"], "D325I")
D50A_Ca_85K_interface = BioTek.clean_data_interface_mutants(["Kinetic read"], ["D7", "D8", "D9"], "D50A")
D144A_E174A_Ca_85K_interface = BioTek.clean_data_interface_mutants(["Kinetic read"], ["E7", "E8", "E9"], "D144A E174A")
E184A_E187A_Ca_85K_interface = BioTek.clean_data_interface_mutants(["Kinetic read"], ["F7", "F8", "F9"], "E184A E187A")
D348A_D350A_Ca_85K_interface = BioTek.clean_data_interface_mutants(["Kinetic read"], ["G7", "G8", "G9"], "D348A D350A")
D351A_E357A_Ca_85K_interface = BioTek.clean_data_interface_mutants(["Kinetic read"], ["H7", "H8", "H9"], "D351A E357A")

#df_WT, df_mutant, mutant_label, xlabel, ylabel, xlim_max, ylim_max, fig_title, legend_title, legend_position, fig_height, fig_width_multiplier

# D325I Turbidity After 1 mM Calcium (in 85 mM KCl)
fig_D325I_Ca_85K_interface = BioTek.plot_vs_WT(WT_Ca_85K_interface, D325I_Ca_85K_interface, "D325I", xLabel, yLabel, 40, 0.13, "CASQ2 D325I Turbidity", "", "lower right", 1.75, golden)
fig_D325I_Ca_85K_interface.savefig("./output/kinetics_interface_mutation_D325I_85mM_K.pgf")

# D50A Turbidity After 1 mM Calcium (in 85 mM KCl)
fig_D50A_Ca_85K_interface = BioTek.plot_vs_WT(WT_Ca_85K_interface, D50A_Ca_85K_interface, "D50A", xLabel, yLabel, 40, 0.13, "CASQ2 D50A Turbidity", "", "lower right",1.5,golden)
fig_D50A_Ca_85K_interface.savefig("./output/kinetics_interface_mutation_D50A_85mM_K.pgf")

# D144A E174A Turbidity After 1 mM Calcium (in 85 mM KCl)
fig_D144A_E174A_Ca_85K_interface = BioTek.plot_vs_WT(WT_Ca_85K_interface, D144A_E174A_Ca_85K_interface, "D144A E174A", xLabel, yLabel, 40, 0.16, "CASQ2 D144A E174A Turbidity", "", "lower right",1.5,golden)
fig_D144A_E174A_Ca_85K_interface.savefig("./output/kinetics_interface_mutation_D144A_E174A_85mM_K.pgf")
# fig_D144A_E174A_Ca_85K_interface.savefig("./output/kinetics_interface_mutation_D144A_E174A_85mM_K.pdf")

# E184A E187A Turbidity After 1 mM Calcium (in 85 mM KCl)
fig_E184A_E187A_Ca_85K_interface = BioTek.plot_vs_WT(WT_Ca_85K_interface, E184A_E187A_Ca_85K_interface, "E184A E187A", xLabel, yLabel, 40, 0.13, "CASQ2 E184A E187A Turbidity", "", "lower right",1.5,golden)
fig_E184A_E187A_Ca_85K_interface.savefig("./output/kinetics_interface_mutation_E184A_E187A_85mM_K.pgf")

# D348A D350A Turbidity After 1 mM Calcium (in 85 mM KCl)
fig_D348A_D350A_Ca_85K_interface = BioTek.plot_vs_WT(WT_Ca_85K_interface, D348A_D350A_Ca_85K_interface, "D348A D350A", xLabel, yLabel, 40, 0.13, "CASQ2 D348A D350A Turbidity", "", "lower right",1.75,golden)
fig_D348A_D350A_Ca_85K_interface.savefig("./output/kinetics_interface_mutation_D348A_D350A_85mM_K.pgf")

# D351 _E357A Turbidity After 1 mM Calcium (in 85 mM KCl)
fig_D351A_E357A_Ca_85K_interface = BioTek.plot_vs_WT(WT_Ca_85K_interface, D351A_E357A_Ca_85K_interface, "D351A E357A", xLabel, yLabel, 40, 0.13, "CASQ2 D351A E357A Turbidity", "", "lower right",1.75,golden)
fig_D351A_E357A_Ca_85K_interface.savefig("./output/kinetics_interface_mutation_D351A_E357A_85mM_K.pgf")