import sys
from Bio import SeqIO
from Bio.SeqRecord import SeqRecord

input_fasta = sys.argv[1] 
output_fasta_CASQ2_vertebrates = sys.argv[2] 
output_fasta_CASQ2_casq1 = sys.argv[3] 

record_dict = SeqIO.to_dict(SeqIO.parse(input_fasta, "fasta"))

# http://genomewiki.ucsc.edu/index.php/Phylogenetic_Tree

# Homo sapiens
# Macaca mulatta
# Canis lupus familiaris
# Mus musculus
# Gallus gallus
# Anolis carolinensis
# Danio rerio
sorted_fasta_select = []
sorted_fasta_select.append(SeqRecord(record_dict["9606.ENSP00000261448"].seq, "CASQ2.H.sapiens", '', ''))
# sorted_fasta_select.append(SeqRecord(record_dict["9544.ENSMMUP00000011753"].seq, "Macaca_mulatta", '', ''))
sorted_fasta_select.append(SeqRecord(record_dict["9615.ENSCAFP00000014348"].seq, "CASQ2.C.lupus.familiaris", '', ''))
sorted_fasta_select.append(SeqRecord(record_dict["10090.ENSMUSP00000029454"].seq, "CASQ2.M.musculus", '', ''))
sorted_fasta_select.append(SeqRecord(record_dict["9031.ENSGALP00000036165"].seq, "CASQ2.G.gallus", '', ''))
#
# The Anolis CASQ2 is fragmented, so we'll leave it out. Using Pelodiscus instead.
# sorted_fasta_select.append(SeqRecord(record_dict["28377.ENSACAP00000003186"].seq, "Anolis carolinensis", '', ''))
sorted_fasta_select.append(SeqRecord(record_dict["13735.ENSPSIP00000016267"].seq, "CASQ2.P.sinensis", '', ''))
#
# Latimeria is an interesting outgroup that no one knows exactly where to place. Leave out.
# sorted_fasta_select.append(SeqRecord(record_dict["7897.ENSLACP00000008103"].seq, "CASQ2.Latimeria_chalumnae", '', ''))
#
# sorted_fasta_select.append(SeqRecord(record_dict["7955.ENSDARP00000020399"].seq, "CASQ2.Danio_rerio", '', ''))


count = SeqIO.write(sorted_fasta_select, output_fasta_CASQ2_vertebrates, "fasta")
print("Saved %i records from %s to %s" % (count, input_fasta, output_fasta_CASQ2_vertebrates))

# Bring this back if looking at co-evolution
# Closest CASQ2 fish clade goes like this:
# Danio rerio, ENSDARP00000020399 (above)
# Gadus morhua, ENSGMOP00000011842
# Oryzias latipes, ENSORLP00000022393
# Xiphophorus maculatus, ENSXMAP00000004211
# Oreochromis niloticus, ENSONIP00000020146
# Gasterosteus aculeatus, ENSGACP00000004907
# Takifugu rubripes, ENSTRUP00000027966
# Tetraodon nigroviridis, ENSTNIP00000016949
# sorted_fasta_select.append(SeqRecord(record_dict["8049.ENSGMOP00000011842"].seq, "Gadus_morhua", '', ''))
# sorted_fasta_select.append(SeqRecord(record_dict["8090.ENSORLP00000022393"].seq, "Oryzias_latipes", '', ''))
# sorted_fasta_select.append(SeqRecord(record_dict["8083.ENSXMAP00000004211"].seq, "Xiphophorus_maculatus", '', ''))
### # Exclude. Bad record.
### # sorted_fasta_select.append(SeqRecord(record_dict["8128.ENSONIP00000020146"].seq, "CASQ2.Oreochromis_niloticus", '', ''))
# sorted_fasta_select.append(SeqRecord(record_dict["69293.ENSGACP00000004907"].seq, "Gasterosteus_aculeatus", '', ''))
### # Must exclude. Dubious insertion in the middle of a highly conserved region. Probably bad assembly. 
### # sorted_fasta_select.append(SeqRecord(record_dict["31033.ENSTRUP00000027966"].seq, "CASQ2.Takifugu_rubripes", '', ''))
# sorted_fasta_select.append(SeqRecord(record_dict["99883.ENSTNIP00000016949"].seq, "Tetraodon_nigroviridis", '', ''))

sorted_fasta_select.append(SeqRecord(record_dict["9606.ENSP00000357057"].seq, "CASQ1.H.sapiens", '', ''))
# sorted_fasta_select.append(SeqRecord(record_dict["9544.ENSMMUP00000023454"].seq, "CASQ1_Macaca_mulatta", '', ''))
sorted_fasta_select.append(SeqRecord(record_dict["9615.ENSCAFP00000018363"].seq, "CASQ1.C.lupus.familiaris", '', ''))
sorted_fasta_select.append(SeqRecord(record_dict["10090.ENSMUSP00000003554"].seq, "CASQ1.M.musculus", '', ''))
# sorted_fasta_select.append(SeqRecord(record_dict["13735.ENSPSIP00000004567"].seq, "CASQ1_Pelodiscus_sinensis", '', ''))
sorted_fasta_select.append(SeqRecord(record_dict["8364.ENSXETP00000000541"].seq, "CASQ1.X.tropicalis", '', ''))
# CASQ1A
# sorted_fasta_select.append(SeqRecord(record_dict["7955.ENSDARP00000056539"].seq, "CASQ1A_D_rerio", '', ''))
# # CASQ1B
# sorted_fasta_select.append(SeqRecord(record_dict["7955.ENSDARP00000011545"].seq, "CASQ1B_D_rerio", '', ''))
# sorted_fasta_select.append(SeqRecord(record_dict["7897.ENSLACP00000003116"].seq, "CASQ1_Latimeria_chalumnae", '', ''))

# Bring this back if looking at co-evolution
# CASQ1 worm clade goes like this:
# Trichinella spiralis, EFV56745
# Pristionchus pacificus, PPA18702
# Caenorhabditis japonica, CJA09943
# Caenorhabditis briggsae, CBG07571
# Caenorhabditis elegans, F40E10.3.2
# Caenorhabditis remanei, CRE15304
# Caenorhabditis brenneri, CBN23215

# sorted_fasta_select.append(SeqRecord(record_dict["6334.EFV56745"].seq, "CASQ1_Trichinella_spiralis", '', ''))
# sorted_fasta_select.append(SeqRecord(record_dict["54126.PPA18702"].seq, "CASQ1_Pristionchus_pacificus", '', ''))
# sorted_fasta_select.append(SeqRecord(record_dict["281687.CJA09943"].seq, "CASQ1_Caenorhabditis_japonica", '', ''))
# sorted_fasta_select.append(SeqRecord(record_dict["6238.CBG07571"].seq, "CASQ1_Caenorhabditis_briggsae", '', ''))
sorted_fasta_select.append(SeqRecord(record_dict["6239.F40E10.3.2"].seq, "CASQ1.C.elegans", '', ''))
# sorted_fasta_select.append(SeqRecord(record_dict["31234.CRE15304"].seq, "CASQ1_Caenorhabditis_remanei", '', ''))
# sorted_fasta_select.append(SeqRecord(record_dict["135651.CBN23215"].seq, "CASQ1_Caenorhabditis_brenneri", '', ''))

count = SeqIO.write(sorted_fasta_select, output_fasta_CASQ2_casq1, "fasta")
print("Saved %i records from %s to %s" % (count, input_fasta, output_fasta_CASQ2_casq1))