#! /bin/zsh
#

mkdir -p output

# Assemble
latex -output-directory=./output -jobname=pedigree_S173I_standalone '\input{pedigree_S173I_standalone.tex}' 

cd output
dvips pedigree_S173I_standalone.dvi
ps2pdf pedigree_S173I_standalone.ps

# dvipdfm pedigree_S173I.dvi

# View
open pedigree_S173I_standalone.pdf

cd ..
