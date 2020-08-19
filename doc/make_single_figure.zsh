#! /bin/zsh
#

output=./output

pdflatex -shell-escape -output-directory=$output -jobname=$1 single_figure.tex | tee $output/1_$1.log

# Don't use this. It generates output suitable for a printer (rasterized fonts). Convert with Acrobat instead.
# pdftops -eps $output/$1.pdf

# View
# open $output/$1.pdf