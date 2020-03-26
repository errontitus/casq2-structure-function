import sys
from ete3 import PhyloTree
from ete3 import NCBITaxa
from Bio import SeqIO
from Bio.SeqRecord import SeqRecord

input_tree = sys.argv[1]
input_fasta = sys.argv[2]
output_fasta_ordered_select = sys.argv[3]
output_fasta_ordered_all = sys.argv[4]

# There's a way to save these extra attributes, but it's a bit awkward (not supported by newick format)
# So we fetch them anew each time.
ncbi = NCBITaxa()
tree = PhyloTree(input_tree, sp_naming_function=lambda name: name.split('.',1)[0])
tax2names, tax2lineages, tax2rank = tree.annotate_ncbi_taxa()
print tree.get_ascii(attributes=["name", "sci_name", "taxid"])

record_dict = SeqIO.to_dict(SeqIO.parse(input_fasta, "fasta"))

# Homo sapiens
# Macaca mulatta
# Canis lupus familiaris
# Mus musculus
# Gallus gallus
# Anolis carolinensis
# Danio rerio
sorted_fasta_select = []
sorted_fasta_select.append(SeqRecord(record_dict["9606.ENSP00000261448"].seq, "Homo sapiens", '', ''))
sorted_fasta_select.append(SeqRecord(record_dict["9544.ENSMMUP00000011753"].seq, "Macaca mulatta", '', ''))
sorted_fasta_select.append(SeqRecord(record_dict["9615.ENSCAFP00000014348"].seq, "Canis lupus familiaris", '', ''))
sorted_fasta_select.append(SeqRecord(record_dict["10090.ENSMUSP00000029454"].seq, "Mus musculus", '', ''))
sorted_fasta_select.append(SeqRecord(record_dict["9031.ENSGALP00000036165"].seq, "Gallus gallus", '', ''))
sorted_fasta_select.append(SeqRecord(record_dict["28377.ENSACAP00000003186"].seq, "Anolis carolinensis", '', ''))
sorted_fasta_select.append(SeqRecord(record_dict["7955.ENSDARP00000020399"].seq, "Danio rerio", '', ''))
count = SeqIO.write(sorted_fasta_select, output_fasta_ordered_select, "fasta")
print("Saved %i records from %s to %s" % (count, input_fasta, output_fasta_ordered_select))

# Note: in theory we can sort the fasta records using the link_to_alignment method.
# Our method is more robust.
# tree.link_to_alignment(input_fasta, alg_format="fasta")
sorted_fasta_all = []
skip = True
for leaf in tree.iter_leaves():
    # The iterative way to get the species name. Not needed since we included this operation in the generator above.
    # taxid = int(leaf.name.split(".",1)[0])
    # species = ncbi.get_taxid_translator([taxid])
    species = leaf.sci_name
    if species == "Homo sapiens":
        skip = False
    if not skip:
        seq = record_dict[leaf.name].seq
        print species
        print seq
        record = SeqRecord(seq, species, '', '')
        sorted_fasta_all.append(record)

count = SeqIO.write(sorted_fasta_all, output_fasta_ordered_all, "fasta")
print("Saved %i records from %s to %s" % (count, input_fasta, output_fasta_ordered_all))

