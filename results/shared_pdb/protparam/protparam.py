from Bio import SeqIO
from Bio.SeqRecord import SeqRecord
from Bio.SeqUtils.ProtParam import ProteinAnalysis

input_fasta = "../../../data/orthology/eggnog_calsequestrin_all.fasta"
record_dict = SeqIO.to_dict(SeqIO.parse(input_fasta, "fasta"))

def analyze(seq, name):
    analysed = ProteinAnalysis(seq)
    print(name)
    print("pI: ")
    print(analysed.isoelectric_point())
    print("AA percent: ")
    print(analysed.get_amino_acids_percent())

# Homo casq2
hCasq2 = SeqRecord(record_dict["9606.ENSP00000261448"].seq[21:], "Homo.CASQ2", "", "")
analyze(str(hCasq2.seq), "hCasq2 full-length")

hCasq2_no_tail = SeqRecord(record_dict["9606.ENSP00000261448"].seq[21:372], "Homo.CASQ2", "", "")
analyze(str(hCasq2_no_tail.seq), "hCasq2 no tail")

# Homo casq1
hCasq1 = SeqRecord(record_dict["9606.ENSP00000357057"].seq[36:], "Homo.CASQ1", "", "")
analyze(str(hCasq1.seq), "hCasq1 full-length")

hCasq1_no_tail = SeqRecord(record_dict["9606.ENSP00000357057"].seq[36:387], "Homo.CASQ1", "", "")
analyze(str(hCasq1_no_tail.seq), "hCasq1 no tail")

