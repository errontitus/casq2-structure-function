#! /bin/zsh
#

mkdir -p output

python make_ortholog_fasta_select.py "../../data/orthology/eggnog_calsequestrin_all.fasta" "./output/casq2_vertebrates_only.fasta" "./output/casq2_casq1_all.fasta"

clustalo -i ./output/casq2_casq1_all.fasta -o ./output/casq2_casq1_all_aligned.fasta --auto --force -v --output-order=input-order --outfmt=clu 

clustalo --full --percent-id --force --distmat-out=./output/casq2_casq1_all.distmat -i ./output/casq2_casq1_all.fasta