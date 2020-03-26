import sys
import pandas as pd

df = pd.read_csv(filepath_or_buffer="../../data/materials/oligonucleotides.tsv", sep="\t")
print df
sep = " & "
terminator = " \\\\\n"
hline = "\hline\n"
with open("./output/table_oligos.tex", "w+") as f:
    for index, row in df.iterrows():
        oligo_name = row["Oligonucleotide Name"] 
        oligo_sequence = row["Sequence"]
        f.write(oligo_name + sep + oligo_sequence + terminator + hline)