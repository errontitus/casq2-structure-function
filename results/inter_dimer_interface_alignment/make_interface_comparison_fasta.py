import sys
from Bio import SeqIO
from Bio.SeqRecord import SeqRecord

input_fasta = "../../data/orthology/eggnog_calsequestrin_all.fasta"
output_fasta_dimer = "./output/pdb_interface_comparison_dimer.fasta"
output_fasta_tetramer = "./output/pdb_interface_comparison_tetramer.fasta"

record_dict = SeqIO.to_dict(SeqIO.parse(input_fasta, "fasta"))

dimer_fasta = []
tetramer_fasta = []

# Excluded from tetramer analysis because redundant: PDB.3TRP.Oryctolagus.CASQ1,PDB.3TRQ.Oryctolagus.CASQ1,PDB.3US3.Oryctolagus.CASQ1,PDB.5CRD.Homo.CASQ1,PDB.5KN0.Bos.CASQ1,PDB.5KN2.Bos.CASQ1,PDB.5KN3.Bos.CASQ1}

# Ours - Homo casq2
s = SeqRecord(record_dict["9606.ENSP00000261448"].seq[21:], "PDB.6OWV.Homo.CASQ2", "", "")
dimer_fasta.append(s)
tetramer_fasta.append(s)

# 2vaf - Homo casq2
# -Homo-CASQ2
s = SeqRecord(record_dict["9606.ENSP00000261448"].seq[21:], "PDB.2VAF.Homo.CASQ2", "", "")
dimer_fasta.append(s)
tetramer_fasta.append(s)

# 3uom - casq1 human 
s = SeqRecord(record_dict["9606.ENSP00000357057"].seq[36:], "PDB.3UOM.Homo.CASQ1", '', '')
dimer_fasta.append(s)
tetramer_fasta.append(s)

# 5crg - casq1 human - mutant D210G
# Exclude mutant, mainly to simplify alignment and save figure space.
# s = SeqRecord(record_dict["9606.ENSP00000357057"].seq[36:], "PDB.5CRG.Homo.CASQ1.D210G", '', '')
# dimer_fasta.append(s)
# tetramer_fasta.append(s)

# 5crh - casq1 human - mutant M53T
# Exclude mutant, mainly to simplify alignment and save figure space.
# s = SeqRecord(record_dict["9606.ENSP00000357057"].seq[36:], "PDB.5CRH.Homo.CASQ1.M53T", '', '')
# dimer_fasta.append(s)
# tetramer_fasta.append(s)

# 5kn1 - casq1 bovine
s = SeqRecord(record_dict["9913.ENSBTAP00000026932"].seq[36:], "PDB.5KN1.Bos.CASQ1", '', '')
dimer_fasta.append(s)
tetramer_fasta.append(s)

# 5kn2 - casq1 bovine
s = SeqRecord(record_dict["9913.ENSBTAP00000026932"].seq[36:], "PDB.5KN2.Bos.CASQ1", '', '')
dimer_fasta.append(s)
# tetramer_fasta.append(s)


############ Group 2

# 1a8y - Oryctolagus casq1
s = SeqRecord(record_dict["9986.ENSOCUP00000024484"].seq[30:], "PDB.1A8Y.Oryct.CASQ1", "", "")
dimer_fasta.append(s)
tetramer_fasta.append(s)

# 1sji - Canis casq2
s = SeqRecord(record_dict["9606.ENSP00000261448"].seq[21:], "PDB.1SJI.Canis.CASQ2", "", "")
dimer_fasta.append(s)
tetramer_fasta.append(s)

# 3trp - casq1 rabbit 
s = SeqRecord(record_dict["9986.ENSOCUP00000024484"].seq[30:], "PDB.3TRP.Oryct.CASQ1", '', '')
dimer_fasta.append(s)

# 3trq - casq1 rabbit 
s = SeqRecord(record_dict["9986.ENSOCUP00000024484"].seq[30:], "PDB.3TRQ.Oryct.CASQ1", '', '')
dimer_fasta.append(s)

# 3us3 - casq1 rabbit 
s = SeqRecord(record_dict["9986.ENSOCUP00000024484"].seq[30:], "PDB.3US3.Oryct.CASQ1", '', '')
dimer_fasta.append(s)

# 3v1w - casq1 rabbit 
s = SeqRecord(record_dict["9986.ENSOCUP00000024484"].seq[30:], "PDB.3V1W.Oryct.CASQ1", '', '')
dimer_fasta.append(s)

# 5crd - casq1 human
s = SeqRecord(record_dict["9606.ENSP00000357057"].seq[36:], "PDB.5CRD.Homo.CASQ1", '', '')
dimer_fasta.append(s)

# 5cre - casq1 human - mutant D210G
# Exclude mutant, mainly to simplify alignment and save figure space.
# s = SeqRecord(record_dict["9606.ENSP00000357057"].seq[36:], "PDB.5CRE.Homo.CASQ1.D210G", '', '')
# dimer_fasta.append(s)
# tetramer_fasta.append(s)

# 5kn0 - casq1 bovine
s = SeqRecord(record_dict["9913.ENSBTAP00000026932"].seq[36:], "PDB.5KN0.Bos.CASQ1", '', '')
dimer_fasta.append(s)
# tetramer_fasta.append(s)

# 5kn3 - casq1 bovine
s = SeqRecord(record_dict["9913.ENSBTAP00000026932"].seq[36:], "PDB.5KN3.Bos.CASQ1", '', '')
dimer_fasta.append(s)

count = SeqIO.write(dimer_fasta, output_fasta_dimer, "fasta")
print("Saved %i records from %s to %s" % (count, input_fasta, output_fasta_dimer))

count = SeqIO.write(tetramer_fasta, output_fasta_tetramer, "fasta")
print("Saved %i records from %s to %s" % (count, input_fasta, output_fasta_tetramer))

# These are for verifying our pdb sequences against the canonical sequences. As long as there are no errors, we'll hide them, because
# the gaps screw up residue numbering for texshade.
for record in SeqIO.parse("./output/casq2.deo.native.fasta", "fasta"):
#        print "writing sequence deo.casq2.pdb"
        dimer_fasta.append(SeqRecord(record.seq,"deo.pdb","",""))

for record in SeqIO.parse("./output/casq1.1a8y.fasta", "fasta"):
#        print "writing sequence 1a8y.pdb"
        dimer_fasta.append(SeqRecord(record.seq,"1a8y.pdb","",""))

for record in SeqIO.parse("./output/casq2.1sji.fasta", "fasta"):
#        print "writing sequence 1sji.pdb"
        dimer_fasta.append(SeqRecord(record.seq,"1sji.pdb","",""))

for record in SeqIO.parse("./output/casq2.2vaf.fasta", "fasta"):
#        print "writing sequence 2vaf.pdb"
        dimer_fasta.append(SeqRecord(record.seq,"2vaf.pdb","",""))








