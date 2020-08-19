import sys
import pandas as pd

def get_native_value(row_index, col_index = 1):
    return str(phenix_native_df.iat[row_index,col_index])

def get_anom_value(row_index, col_index = 1):
    return str(phenix_anom_df.iat[row_index,col_index])

def round_percent(val):
    return str(round(float(val),3) * 100)

def get_space_group_native():
    return "\\textit{P} 4\\textsubscript{3} 2 2" 

def get_space_group_anom():
    return "\\textit{P} 1 2\\textsubscript{1} 1" 

print sys.argv[1]
phenix_native = sys.argv[1]
print sys.argv[2]
phenix_anom = sys.argv[2]

phenix_native_df = pd.read_csv(filepath_or_buffer=phenix_native, sep=",")
phenix_anom_df = pd.read_csv(filepath_or_buffer=phenix_anom, sep=",")

print "Native"
print phenix_native_df
print "Anom"
print phenix_anom_df

sep = " & "
terminator = " \\\\\n"

with open("./output/table_xtal_stats.tex", "w+") as f:
    f.write("\\begin{tabular}{ lcc }\n")
    f.write("\hline\n")    
    f.write(sep + "\\textbf{Human Cardiac Calsequestrin}" + sep + "\\textbf{Human Cardiac Calsequestrin, Ytterbium-Complexed}" + terminator)
    f.write(sep + "\\textbf{(PDB 6OWV)}" + sep + "\\textbf{(PDB 6OWW)}" + terminator)
    f.write("\hline\n")    
    f.write("\multicolumn{3}{l}{\\textbf{Data Collection}}" + terminator)
#    f.write("\hline\n")    

    # label = "Wavelength (\\AA)"
    # f.write(label + sep + get_native_value(0) + sep + get_anom_value(0) + terminator)

    label = "Space Group"
    f.write(label + sep + get_space_group_native() + sep + get_space_group_anom() + terminator)
    
    label = "Cell Dimensions"
    f.write(label + terminator)
    
    label = "\\quad \\textit{a, b, c} (\\AA)"
    CellLengthsNative = ", ".join(get_native_value(3).split()[0:3])
    CellLengthsAnom = ", ".join(get_anom_value(3).split()[0:3])
    f.write(label + sep + CellLengthsNative + sep + CellLengthsAnom + terminator)

    # Using $^{\circ}$ to obtain (roughly) a degree symbol.
    # Reasoning: \ang() from SIunitx won't work without an argument.
    # \degree from gensymb would be fine, but trying to be consistent about relying on core packages for most symbols.
    label = "\\quad $\\alpha$,$\\beta$,$\\gamma$ ($^{\circ}$)"
    CellAnglesNative = ", ".join(get_native_value(3).split()[3:6])
    CellAnglesAnom = ", ".join(get_anom_value(3).split()[3:6])
    f.write(label + sep + CellAnglesNative + sep + CellAnglesAnom + terminator)

    label = "Resolution (\\AA)"
    f.write(label + sep + get_native_value(1) + "\\textsuperscript{a}" + sep + get_anom_value(1) + terminator)

    # Rpim
    label = "\\textit{R}\\textsubscript{pim} (\\%)"
    RpimNative = get_native_value(12).split()[0]
    RpimAnom = get_anom_value(12).split()[0]
    RpimNativeHigh = get_native_value(12).split()[1].replace("(","").replace(")","")
    RpimAnomHigh = get_anom_value(12).split()[1].replace("(","").replace(")","")
    RpimNativeBoth = round_percent(RpimNative) + " (" + round_percent(RpimNativeHigh) + ")"
    RpimAnomBoth = round_percent(RpimAnom) + " (" + round_percent(RpimAnomHigh) + ")"
    f.write(label + sep + RpimNativeBoth + sep + RpimAnomBoth + terminator)

    # Mean(I)/sig(I)
    label = "\\textit{I/$\\sigma$(I)}" 
    f.write(label + sep + get_native_value(8) + sep + get_anom_value(8) + terminator)

    # CC1/2
    label = "\\textit{CC}\\textsubscript{1/2}"
    f.write(label + sep + get_native_value(13) + sep + get_anom_value(13) + terminator)

    # Completeness
    label = "Completeness (\\%)"
    f.write(label + sep + get_native_value(7) + sep + get_anom_value(7) + terminator)

    # Multiplicity
    label = "Redundancy"
    f.write(label + sep + get_native_value(6) + sep + get_anom_value(6) + terminator)

    ################################################

    f.write("\multicolumn{3}{l}{\\textbf{Refinement}}" + terminator)
#    f.write("\hline\n")    

    # Resolution
    label = "Resolution (\\AA)"
    RefineResolutionNative = get_native_value(1).split()[0] + " - " + get_native_value(1).split()[2]
    RefineResolutionAnom = get_anom_value(1).split()[0] + " - " + get_anom_value(1).split()[2]
    f.write(label + sep + RefineResolutionNative + sep + RefineResolutionAnom + terminator)

    # No. Unique Reflections
    label = "No. Reflections"
    f.write(label + sep + get_native_value(5) + sep + get_anom_value(5) + terminator)
#    f.write("\hline\n")

    # Rwork / Rfree(%) 
    label = "\\textit{R}\\textsubscript{work} / \\textit{R}\\textsubscript{free} (\\%) "
    sRworkNative = get_native_value(17).split()[0]
    sRfreeNative = get_native_value(18).split()[0]
    sRworkAnom = get_anom_value(17).split()[0]
    sRfreeAnom = get_anom_value(18).split()[0]
    native = str(round(float(sRworkNative),3) * 100) + " / " + str(round(float(sRfreeNative),3) * 100)
    anom = str(round(float(sRworkAnom),3) * 100) + " / " + str(round(float(sRfreeAnom),3) * 100)
    f.write(label + sep + native + sep + anom + terminator)

    # # No. of chains in AU 
    # label = "No. of chains in AU"
    # f.write(label + sep + "1" + sep + "8" + terminator)

    # No. of atoms 
    label = "No. atoms"
    f.write(label + sep + get_native_value(21) + sep + get_anom_value(21) + terminator)

    # Protein 
    label = "\\quad Protein"
    f.write(label + sep + get_native_value(22) + sep + get_anom_value(22) + terminator)

    # Ligand
    label = "\\quad Ligand"
    f.write(label + sep + get_native_value(23) + sep + get_anom_value(23) + terminator)

    # Solvent
    label = "\\quad Water"
    f.write(label + sep + get_native_value(24) + sep + "N/A" + terminator)

    # B Factors
    label = "\\textit{B} Factors"
    f.write(label + sep + "" + sep + "" + terminator)

    # Protein 
    label = "\\quad Protein"
    f.write(label + sep + get_native_value(34) + sep + get_anom_value(33) + terminator)

    # Ligand
    label = "\\quad Ligand/ion"
    f.write(label + sep + get_native_value(35) + sep + get_anom_value(34) + terminator)

    # Solvent
    label = "\\quad Water"
    f.write(label + sep + get_native_value(36) + sep + "N/A" + terminator)

    # R.m.s. deviations
    label = "R.m.s. deviations"
    f.write(label + sep + "" + sep + "" + terminator)

    # Bond lengths 
    label = "\\quad Bond lengths (\\AA)"
    f.write(label + sep + get_native_value(26) + sep + get_anom_value(25) + terminator)

    # Bond angles 
    label = "\\quad Bond angles ($^{\circ}$)"
    f.write(label + sep + get_native_value(27) + sep + get_anom_value(26) + terminator)
    f.write("\hline\n")    
    f.write("\\end{tabular}\n")