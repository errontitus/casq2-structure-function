#! /bin/zsh
#

output=./output

# for f in ./figures/*.tex;  do FILENAME=`basename ${f}`; echo ${FILENAME}; done

for f in ./figures/*intra_dimer_interface_6*.tex;  do FILENAME=$(echo "$f" | cut -f 2 -d '.' | cut -f 3 -d '/'); 
    echo ${FILENAME}; 
    source make_single_figure.zsh ${FILENAME}; 

    # Don't use this. It generates output suitable for a printer (rasterized fonts). Convert with Acrobat instead.
    # cp $output/${FILENAME}.eps ./publication/nsmb/4_revision/${FILENAME}.eps;
done


# source make_single_figure.zsh ext_intra_dimer_interface_6OVW_vs_other_overlay
# source make_single_figure.zsh ext_intra_dimer_interface_6OVW_vs_other_B_factor

# cp $output/main_S173I_genetics_and_biochemistry.eps ./publication/nsmb/3_revision/main_fig_1_S173I_genetics_and_biochemistry.eps



