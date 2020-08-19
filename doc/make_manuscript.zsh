#! /bin/zsh
#

output=./output
FAST="N"

for i in "$@"
do
case $i in
    -f|--fast)
    FAST="Y"
    shift # past argument=value
    ;;
    *)
          # unknown option
    ;;
esac
done

# Generates a document with question marks in place of unknown references and references stored in the aux file in the form of arguments that were supplied to \cite commands.
pdflatex -shell-escape -output-directory=$output -jobname=casq2_manuscript manuscript.tex | tee $output/1_pdflatex.log

# XeLaTeX -shell-escape -output-directory=$output -jobname=casq2_manuscript manuscript.tex | tee $output/1_pdflatex.log

if [ "$FAST" = "Y" ]; then
    echo "Exiting early per request. No references will be built."
else
    # # The old way, with bibtex:
    # #
    # # Read the aux file and produce a formatted bibliography.
    # # bibtex ./output/manuscript_with_refs.aux
    # bibtex $output/casq2_manuscript.aux | tee $output/2_bibtex.log

    # # Now that the bibliography exists, it will be added to the main document on this run. Also on this run, the correct citation labels will be written to the aux file.
    # pdflatex -shell-escape -output-directory=$output -jobname=casq2_manuscript manuscript.tex | tee $output/3_pdflatex.log

    # # Regenerate the document again, this time using the correct citation labels from the aux file.
    # pdflatex -shell-escape -output-directory=$output -jobname=casq2_manuscript manuscript.tex | tee $output/4_pdflatex.log

    # The new way, with biber:
    biber $output/casq2_manuscript.bcf | tee $output/2_biber.log

    # Regenerate the document again, this time using the correct citation labels
    pdflatex -shell-escape -output-directory=$output -jobname=casq2_manuscript manuscript.tex | tee $output/3_pdflatex.log

    # Regenerate the document again!
    pdflatex -shell-escape -output-directory=$output -jobname=casq2_manuscript manuscript.tex | tee $output/3_pdflatex.log
fi

# Providing a supplement:
# - No page numbers, since the journal sometimes adds a front page.
# - No "Supplementary Information" title, since the journal provides.
# - Do not build separately, since we want figure refs to be intact.
# In other words, just extract from the main manuscript.
pdfjam "./output/casq2_manuscript.pdf" '42-45' --outfile "./publication/nsmb/3_revision/supplement_CASQ2_Titus.pdf"

# View
open $output/casq2_manuscript.pdf