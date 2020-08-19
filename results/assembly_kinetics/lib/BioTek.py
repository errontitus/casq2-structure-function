import numpy as np
import numpy.ma as ma
import pandas as pd
from datetime import datetime
import matplotlib.pyplot as plt

from matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas
from matplotlib.figure import Figure

# Try to be pretty standard here and look a bit like Graphpad.
# Black for WT, red for first variant, blue for second variant. Circle, square, triangle.
WT_format = 'ko'
WT2_formant = 'go'
variant1_format = 'rs'
variant2_format = 'b^'
default_marker_size = 3

background_matrix_header_row = 1
background_matrix_nrows = 8

background_matrix_header_row_edta = 2
background_matrix_nrows_edta = 1


def background_mean_from_matrix(filename, matrix_header_row, matrix_nrows, row, start_column, stop_column):
    all_cols = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", ""]
    header = matrix_header_row
    nrows = matrix_nrows
    matrix = pd.read_csv(filepath_or_buffer=filename, header=header, sep="\t", nrows=nrows, names=all_cols)
    # print matrix.loc['A','4':'6'].mean()
    return matrix.loc[row,start_column:stop_column].mean()

def background_value_from_matrix(filename, well):
    all_cols = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", ""]
    matrix = pd.read_csv(filepath_or_buffer=filename, header=background_matrix_header_row, sep="\t", nrows=background_matrix_nrows, names=all_cols)
    row = well[0]
    column = well[1:]
    return matrix.loc[row,column]

def background_value_from_matrix_edta(filename, well):
    all_cols = ["1", "2", "3", ""]
    matrix = pd.read_csv(filepath_or_buffer=filename, header=background_matrix_header_row_edta, sep="\t", nrows=background_matrix_nrows_edta, names=all_cols)
    row = well[0]
    column = well[1:]
    value = matrix.loc[row,column]
    print value 
    return value

def raw_well_data(filename, time_column, well_list, header_row, nrows, handle_injection_markers=0):
    filename = filename
    cols = time_column + well_list
    header = header_row
    nrows = nrows
    raw = pd.read_csv(filepath_or_buffer=filename, header=header, sep="\t", nrows=nrows, usecols=cols)
    if handle_injection_markers > 0:
        raw = raw[raw.B1 != "Inject 1"]
        raw = raw[raw.B1 != "Inject 2"]
    return raw

def cleaned_well_data(filename, time_column, well_list, header_row, nrows, time_format="hh:MM:SS", sample_label="", handle_injection_markers=0, matrix_format=1):
    # filename = filename
    # cols = time_column + well_list
    # header = header_row
    # nrows = nrows
    # raw = pd.read_csv(filepath_or_buffer=filename, header=header, sep="\t", nrows=nrows, usecols=cols)
    # print sample_label
    raw = raw_well_data(filename, time_column, well_list, header_row, nrows, handle_injection_markers)

    for well in well_list:
        if matrix_format == 1:
            background_value = background_value_from_matrix(filename, well)
        else:
            background_value = background_value_from_matrix_edta(filename, well)
        raw[well] = raw[well].astype(float) - background_value.astype(float)

    raw["time_str"] = raw["Kinetic read"]
    if (time_format == "hh:MM:SS"):
        raw["minutes"] = raw["time_str"].str.split(":", expand=True)[1]
        raw["seconds"] = raw["time_str"].str.split(":", expand=True)[2]
        raw["fractional_seconds"] = 0    
        raw["timedelta"] = raw["minutes"].astype(float) + raw["seconds"].astype(float)/60.0 + raw["fractional_seconds"].astype(float)/100.0
        raw["time_minutes"] = raw["timedelta"]
    else:
        # MM:SS.ss
        raw["minutes"] = raw["time_str"].str.split(":", expand=True)[0]
        raw["seconds"] = raw["time_str"].str.split(":", expand=True)[1].str.split(".", expand=True)[0]
        raw["fractional_seconds"] = raw["time_str"].str.split(":", expand=True)[1].str.split(".", expand=True)[1]
        raw["timedelta"] = (raw["minutes"].astype(float) * 60.0) + raw["seconds"].astype(float) + raw["fractional_seconds"].astype(float)/100.0
        raw["time_seconds"] = raw["timedelta"]

    # Downsample to make plots easier to read.
    # See https://www.shanelynn.ie/summarising-aggregation-and-grouping-data-in-python-pandas/
    if (time_format == "hh:MM:SS"):
        raw = raw.iloc[::10,:]
    else:
        raw = raw.iloc[::20,:]

    # Let's make a df in a nice format for a "source data" spreadsheet for a journal. 
    # The goal of source data is to make statistical decisions transparent. Everything else should be cleaned up to highlight the statistics treatment (i.e finished background subtraction). Anyone who wants to see the totality of the pre-processing and data cleaning operations can always look at the code here (on Github).
    raw = raw.drop(columns=['Kinetic read','time_str','minutes','seconds','fractional_seconds'],axis=1)
    r = 1
    for well in well_list:
        raw["replicate_" + str(r)] = raw[well]
        r += 1
#    print raw

    return raw 

# This exists to reproduce a bug I had in the original submitted manuscript.
# The bug made error bars in the D325A series in fig 6 larger due to using only 2 of the 3 replicates. The problem was with code that sampled well D2 twice. 
# def normalize_for_plot_bad(input_df):
#     # For plotting we want a further transformation to make the table fully normalized.
# Only two replicates used.
#     new = input_df[['timedelta', 'replicate_1', 'replicate_2']].copy()
#     melted = new.melt(id_vars=(["timedelta"]), var_name="Well")
#     values = melted.groupby('timedelta', as_index=False).value.agg(['mean','std','sem'])
#     values["timedelta"] = values.index
#     values = values.rename(columns={"mean": "well_mean", "std": "well_std", "sem": "well_sem"})
#     values["well_error_high"] = values["well_mean"] + values["well_sem"]
#     values["well_error_low"] = values["well_mean"] - values["well_sem"]

#     # values["sample"] = sample_label
#     # values["color"] = sample_label
#     # values["symbol"] = sample_label
#     # values["point_size"] = 3

#     return values

def normalize_for_plot(input_df):
    # For plotting we want a further transformation to make the table fully normalized.
    new = input_df[['timedelta', 'replicate_1', 'replicate_2', 'replicate_3']].copy()
    melted = new.melt(id_vars=(["timedelta"]), var_name="Well")
    values = melted.groupby('timedelta', as_index=False).value.agg(['mean','std','sem'])
    values["timedelta"] = values.index
    values = values.rename(columns={"mean": "well_mean", "std": "well_std", "sem": "well_sem"})
    values["well_error_high"] = values["well_mean"] + values["well_sem"]
    values["well_error_low"] = values["well_mean"] - values["well_sem"]

    # values["sample"] = sample_label
    # values["color"] = sample_label
    # values["symbol"] = sample_label
    # values["point_size"] = 3

    return values

def clean_data_CPVT_varying_K(time_column, well_list, label):
    # All of Jason's CPVT mutants, plus ours. There's also an earlier data file with these results at 85 mM KCl only, but let's use this one because it provides us with a complete dataset in both 85 mM and 0 mM KCl all run in the same batch. Need to note in methods that this was done on a different type of plate (black CellStar plate).

    # 0 mM KCl
    # F4-6 S173I, F7-9 WT, F10-12 P308L
    # G4-6 K180R, G7-9 Y55C, G10-12 D325E
    # H4-6 R33Q, H7-9 F189L, H10-12 R251H

    # 85 mM KCl
    # A7-9 NP, A10-12 D325E
    # B7-9 WT, B10-12 R251H
    # C7-9 Y55C, C10-12 S173I
    # D7-9 F189L, D10-12 K180R
    # E7-9 P308L, E10-12 R33Q

    filename = "../../data/assembly_kinetics/2018-10_CPVT_Mutants/03_Varying K+, CPVT Mutants, 1 mM Ca Plate Mode, 1 mM EDTA Well Mode, Black Plate, combined 0 and 85 mM KCl.txt"
    header = 21
    nrows = 113
    df = cleaned_well_data(filename, time_column, well_list, header, nrows, "hh:MM:SS", label)

    return df

def clean_data_WT_EDTA(time_column, well_list, label):
    # This was a run in 0 mM KCl, slightly different Tris (pH 7.2), black plate instead of clear. Jason's mutants were in the other rows, but we are using this only for EDTA response, so looking only at WT in row B.

    filename = "../../data/assembly_kinetics/2018_07_WT_Only/2018-07-17 Jason's Mutants 1 mM Ca++ and 1 mM EDTA_for_export_2019_10.txt"
    header = 5
    nrows = 1504
    df = cleaned_well_data(filename, time_column, well_list, header, nrows, "MM:SS.ss", label, 1, 2)
    return df

def clean_data_interface_mutant_D325A(time_column, well_list, label):
    # Layout:
    #
    # A NP
    # B WT
    # C D325I
    # D D325A
    #
    # Assay as above.
    # uClear polystyrene plate used.
    filename = "../../data/assembly_kinetics/2019-09_Ala_Mutants_D325I_and_D325A/2019-09 Ala Mutants D325I and D325A.txt"
    header = 21
    nrows = 169
    df = cleaned_well_data(filename, time_column, well_list, header, nrows, "hh:MM:SS", label)
    return df


def clean_data_interface_mutants(time_column, well_list, label):
    # Layout:
    #
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
    # Assay as above.
    # uClear polystyrene plate used.
    filename = "../../data/assembly_kinetics/2018-12_Ala_Mutants_D325I_D50A_K180R/12_Varying K+, Ala Mutants and D325I and D50A, Clear Plate, 1 mM Ca, 1 mM EDTA.txt"
    header = 21
    nrows = 169
    df = cleaned_well_data(filename, time_column, well_list, header, nrows, "hh:MM:SS", label)
    return df


def clean_data_K180R_varying_Mg(time_column, well_list, label):
    # K180R in varying Mg, clear plate, 85 mM KCl in all wells.

    # Layout:
    # A WT, Mg 90 mins
    # B WT, Mg, 0 mins
    # C WT, No Mg
    # D K180R, Mg, 90 mins
    # E K180R, Mg, 0 mins
    # F K180R, No Mg
    # G NP No Mg
    # H NP Mg

    # For K180R, protein was added to the well as before, buffer was added to 133 uL, then for Mg samples 7 uL of 40 mM MgCl2 was added for a final well volume of 140 uL, a final protein concentration of 2.25 uM, and a final Mg concentration of 2 mM. For Mg-free samples, 7 uL of buffer was added. The plate was covered and allowed to rock gently for 90 minutes. The turbidity assay was performed otherwise as above.

    # Buffer: Turbidity Assay Buffer (TAB, 15 mM Tris pH 7.4, 20 mM NaCl, 85 mM KCl)
    # EDTA Dialysis: 10 mM in TAB
    # Plate type: uClear, clear, half-area
    # Calcium: 7 uL of 20 mM Ca added for final concentration of 1 mM (after Mg as above)
    # EDTA: 7 uL of 20 mM EDTA added for final concentration of 1 mM

    filename = "../../data/assembly_kinetics/2018-12_WT_and_K180R_Varying_Mg/85 mM K+, WT and K180R Mg 90 mins and 0 mins.txt"
    header = 21
    nrows = 169
    df = cleaned_well_data(filename, time_column, well_list, header, nrows, "hh:MM:SS", label)
    return df


def clean_data_mixing_experiment(time_column, well_list, label):
    # A more limited set of CPVT mutants, all run at 85 mM. This was done using a clear plate.

    # 85 mM KCl
    # A1-6 NP control 
    # B1-3 WT, B4-6 WT hemizygous
    # C1-3 R33Q, C4-6 R33Q mix 
    # D1-3 P308L, D4-6 P308L mix 
    # E1-3 D325E, E4-6 D325E mix 
    # F1-3 S173I, F4-6 S173I mix 
    # G1-3 K180R (bad), G4-6 K180R mix (bad)

    filename = "../../data/assembly_kinetics/2018-12_CPVT_Mutants_Mixing/21_85 mM K, CPVT Mutant Mixing, Clear Plate, 1 mM Ca, 1 mM EDTA.txt"
    header = 21
    nrows = 169
    df = cleaned_well_data(filename, time_column, well_list, header, nrows, "hh:MM:SS", label)
    return df


# Now setting rcParams in the parent script, but leaving these notes here for future reference.
def update_pgf_params():
    # Plots should not be saved as vector graphics and rescaled, not even in a vector format that supports non-linear font scaling, such as PDF. The reason is that we want to control font size absolutely (e.g. force font size of 8). This means that the way to save plots is in the form of raw pgf. 
    # http://sbillaudelle.de/2015/02/23/seamlessly-embedding-matplotlib-output-into-latex.html
    # https://nipunbatra.github.io/blog/2014/latexify.html

    fig_width=None
    fig_height=None

    golden_ratio = (sqrt(5) + 1.0)/2.0

    if fig_height is None:
        fig_height = 0.1
    if fig_width is None:
        fig_width = golden_ratio * fig_height

    # 'backend': 'ps',
    # 'text.latex.preamble': ['\usepackage{gensymb}'],
    # 'axes.labelsize': 8, # fontsize for x and y labels (was 10)
    # 'axes.titlesize': 8,
    # 'text.fontsize': 8, # was 10
    # 'legend.fontsize': 8, # was 10
    # 'xtick.labelsize': 8,
    # 'ytick.labelsize': 8,
    # 'text.usetex': True,

    # params = {'pgf.rcfonts' : False,
    #             'figure.figsize': [fig_width,fig_height]
    #     }

    # matplotlib.rcParams.update(params)

def plot_vs_WT(df_WT, df_mutant, mutant_label, xlabel, ylabel, xlim_max, ylim_max, fig_title, legend_title, legend_position, fig_height, fig_width_multiplier):
    print df_WT

    fig = Figure()
    # A canvas must be manually attached to the figure (pyplot would automatically
    # do it).  This is done by instantiating the canvas with the figure as
    # argument.
    FigureCanvas(fig)
    ax = fig.add_subplot(111)
    ax.plot([1, 2, 3])

    x = df_WT["timedelta"]
    y = df_WT["well_mean"]
    yerr = df_WT["well_std"]
    WT_line = ax.errorbar(x, y, yerr, fmt=WT_format, markersize=default_marker_size)
    WT_line.set_label("WT")

    x = df_mutant["timedelta"]
    y = df_mutant["well_mean"]
    yerr = df_mutant["well_std"]
    mutant_line = ax.errorbar(x, y, yerr, fmt=variant1_format, markersize=default_marker_size)
    mutant_line.set_label(mutant_label)

    ax.legend(loc=legend_position, title=legend_title)

    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.set_xlim(0, xlim_max)
    ax.set_ylim(0, ylim_max)

    ax.set_title(fig_title)
    fig.set_size_inches(fig_height * fig_width_multiplier, fig_height)
    fig.tight_layout(pad=0.4)

    return fig


def plot_two_variants_vs_WT(df_WT, df_variant1, variant_label1, df_variant2, variant_label2, xlabel, ylabel, xlim_max, ylim_max, fig_title, legend_title, legend_position, fig_height, fig_width_multiplier):
    print df_WT

    fig = Figure()
    # A canvas must be manually attached to the figure (pyplot would automatically
    # do it).  This is done by instantiating the canvas with the figure as
    # argument.
    FigureCanvas(fig)
    ax = fig.add_subplot(111)
    ax.plot([1, 2, 3])

    x = df_WT["timedelta"]
    y = df_WT["well_mean"]
    yerr = df_WT["well_std"]
    WT_line = ax.errorbar(x, y, yerr, fmt=WT_format, markersize=default_marker_size)
    WT_line.set_label("WT")

    x = df_variant1["timedelta"]
    y = df_variant1["well_mean"]
    yerr = df_variant1["well_std"]
    mutant_line1 = ax.errorbar(x, y, yerr, fmt=variant1_format, markersize=default_marker_size)
    mutant_line1.set_label(variant_label1)

    x = df_variant2["timedelta"]
    y = df_variant2["well_mean"]
    yerr = df_variant2["well_std"]
    mutant_line2 = ax.errorbar(x, y, yerr, fmt=variant2_format, markersize=default_marker_size)
    mutant_line2.set_label(variant_label2)

    ax.legend(loc=legend_position, title=legend_title)

    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.set_xlim(0, xlim_max)
    ax.set_ylim(-1 * 0.003, ylim_max)

    ax.set_title(fig_title)
    fig.set_size_inches(fig_height * fig_width_multiplier, fig_height)
    fig.tight_layout(pad=0.4)

    return fig


def plot_WT_EDTA(df_WT, WT_label, xlabel, ylabel, xlim_max, ylim_max, fig_title, legend_title, legend_position, fig_height, fig_width_multiplier):
    print df_WT

    fig = Figure()
    # A canvas must be manually attached to the figure (pyplot would automatically
    # do it).  This is done by instantiating the canvas with the figure as
    # argument.
    FigureCanvas(fig)
    ax = fig.add_subplot(111)
    ax.plot([1, 2, 3])

    x = df_WT["timedelta"]
    y = df_WT["well_mean"]
    yerr = df_WT["well_std"]
    WT_line = ax.errorbar(x, y, yerr, fmt=WT_format, markersize=default_marker_size)
    WT_line.set_label(WT_label)

    ax.legend(loc=legend_position, title=legend_title)

    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.set_xlim(-1 * 1, xlim_max)
    ax.set_ylim(-1 * 0.001, ylim_max)

    ax.annotate("EDTA",
            xy=(600, 0.02), xycoords='data',
            xytext=(300, 0.0222), textcoords='data',
            arrowprops=dict(arrowstyle="->",
                            connectionstyle="arc3"),
            )
    ax.set_title(fig_title)
    fig.set_size_inches(fig_height * fig_width_multiplier, fig_height)
    fig.tight_layout(pad=0.4)

    return fig


def plot_K180R_Mg(df_WT, df_WT90, df_K180R, df_K180R90, xlabel, ylabel, xlim_max, ylim_max, fig_title, legend_title, legend_position, fig_height, fig_width_multiplier):

    fig = Figure()
    # A canvas must be manually attached to the figure (pyplot would automatically
    # do it).  This is done by instantiating the canvas with the figure as
    # argument.
    FigureCanvas(fig)
    ax = fig.add_subplot(111)
    ax.plot([1, 2, 3])

    x = df_WT["timedelta"]
    y = df_WT["well_mean"]
    yerr = df_WT["well_std"]
    WT_line = ax.errorbar(x, y, yerr, fmt=WT_format, markersize=default_marker_size)
    WT_line.set_label("WT, 0 mins pre-incubation w/ Mg")

    x = df_WT90["timedelta"]
    y = df_WT90["well_mean"]
    yerr = df_WT90["well_std"]
    WT_90_line = ax.errorbar(x, y, yerr, fmt='go', markersize=default_marker_size)
    WT_90_line.set_label("WT, 90 mins pre-incubation w/ Mg")

    x = df_K180R["timedelta"]
    y = df_K180R["well_mean"]
    yerr = df_K180R["well_std"]
    K180R_line = ax.errorbar(x, y, yerr, fmt=variant1_format, markersize=default_marker_size)
    K180R_line.set_label("K180R, 0 mins pre-incubation w/ Mg")

    x = df_K180R90["timedelta"]
    y = df_K180R90["well_mean"]
    yerr = df_K180R90["well_std"]
    K180R_90_line = ax.errorbar(x, y, yerr, fmt=variant2_format, markersize=default_marker_size)
    K180R_90_line.set_label("K180R, 90 mins pre-incubation w/ Mg")

    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.set_ylim(0, ylim_max)
    ax.set_xlim(0, xlim_max)

    ax.set_title(fig_title)

    # We will override the canvas size later in order to accomodate a legend outside of the plot area. But for now this sets relative axis proportions.
    fig.set_size_inches(fig_height * fig_width_multiplier, fig_height)
    fig.tight_layout(pad=0.4)

    # Put a legend to the right of the current axis. 
    ax.legend(loc='center left', title=legend_title, bbox_to_anchor=(1, 0.5))

    return fig


# def plot_mixtures(df_WT, df_WT_half, df_mutant, df_mutant_mix, mutant_label, xlabel, ylabel, xlim_max, ylim_max, fig_title, legend_title, legend_position, fig_height, fig_width_multiplier):

#     fig = Figure()
#     # A canvas must be manually attached to the figure (pyplot would automatically
#     # do it).  This is done by instantiating the canvas with the figure as
#     # argument.
#     FigureCanvas(fig)
#     ax = fig.add_subplot(111)
#     ax.plot([1, 2, 3])

#     x = df_WT["timedelta"]
#     y = df_WT["well_mean"]
#     yerr = df_WT["well_std"]
#     WT_line = ax.errorbar(x, y, yerr, fmt='bo', markersize=default_marker_size)
#     WT_line.set_label("WT")

#     x = df_mutant["timedelta"]
#     y = df_mutant["well_mean"]
#     yerr = df_mutant["well_std"]
#     mutant_line = ax.errorbar(x, y, yerr, fmt='rs', markersize=default_marker_size)
#     mutant_line.set_label(mutant_label)

#     x = df_mutant_mix["timedelta"]
#     y = df_mutant_mix["well_mean"]
#     yerr = df_mutant_mix["well_std"]
#     mix_line = ax.errorbar(x, y, yerr, fmt='cP', markersize=default_marker_size)
#     mix_line.set_label(mutant_label + "/WT mix")

#     ax.legend(loc=legend_position, title=legend_title)

#     ax.set_xlabel(xlabel)
#     ax.set_ylabel(ylabel)
#     ax.set_xlim(0, xlim_max)
#     ax.set_ylim(0, ylim_max)
#     ax.set_title(fig_title)

#     fig.set_size_inches(fig_height * fig_width_multiplier, fig_height)
#     fig.tight_layout(pad=0.4)

#     return fig

# def plot_two_K_conditions_vs_WT(df_WT0, df_WT85, df_mutant0, df_mutant85, mutant_label, xlabel, ylabel, ylim_max, fig_title, legend_title):
#     plt.figure(figsize=(1.6, 1.0))
# #    fig, ax = plt.subplots()

#     x = df_WT85["timedelta"]
#     y = df_WT85["well_mean"]
#     yerr = df_WT85["well_std"]
#     plt.errorbar(x, y, yerr, fmt='bo')
#     label1 = "WT 85 mM KCl"

#     x = df_mutant85["timedelta"]
#     y = df_mutant85["well_mean"]
#     yerr = df_mutant85["well_std"]
#     plt.errorbar(x, y, yerr, fmt='rs')
#     label2 = mutant_label + " 85 mM KCl"

#     x = df_WT0["timedelta"]
#     y = df_WT0["well_mean"]
#     yerr = df_WT0["well_std"]
#     plt.errorbar(x, y, yerr, fmt='cP')
#     label3 = "WT 0 mM KCl"

#     x = df_mutant0["timedelta"]
#     y = df_mutant0["well_mean"]
#     yerr = df_mutant0["well_std"]
#     plt.errorbar(x, y, yerr, fmt='m^')
#     label4 = mutant_label + " 0 mM KCl"

#     plt.legend((label1, label2, label3, label4), loc="upper left", title=legend_title)

#     plt.xlabel(xlabel)
#     plt.ylabel(ylabel)

#     plt.ylim(0, ylim_max)

#     return plt

