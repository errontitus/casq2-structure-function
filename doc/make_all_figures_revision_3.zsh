#! /bin/zsh
#

output=./output

# for f in ./figures/*.tex;  do FILENAME=`basename ${f}`; echo ${FILENAME}; done

for f in ./figures/*.tex;  do FILENAME=$(echo "$f" | cut -f 2 -d '.' | cut -f 3 -d '/'); 
    echo ${FILENAME}; 
    source make_single_figure.zsh ${FILENAME}; 

    # Don't use this. It generates output suitable for a printer (rasterized fonts). Convert with Acrobat instead.
    # cp $output/${FILENAME}.eps ./publication/nsmb/3_revision/${FILENAME}.eps;
done


# name=$(echo "$filename" | cut -f 1 -d '.')

# for i in "$@"
# do

# done


# source make_single_figure.zsh main_S173I_genetics_and_biochemistry
# source make_single_figure.zsh main_filament_overview
# source make_single_figure.zsh main_intra_dimer_interface
# source make_single_figure.zsh main_inter_dimer_interface
# source make_single_figure.zsh main_filament_cavity
# source make_single_figure.zsh main_inter_dimer_interface_CPVT
# source make_single_figure.zsh main_graphical_summary

# source make_single_figure.zsh ext_biochemistry
# source make_single_figure.zsh ext_inter_dimer_interface_BSA_comparison
# source make_single_figure.zsh ext_filament_comparison
# source make_single_figure.zsh ext_intra_dimer_interface_maps
# source make_single_figure.zsh ext_intra_dimer_interface_6OVW_vs_other_overlay
# source make_single_figure.zsh ext_intra_dimer_interface_6OVW_vs_other_B_factor
# source make_single_figure.zsh ext_inter_dimer_interface
# source make_single_figure.zsh ext_inter_dimer_interface_maps
# source make_single_figure.zsh ext_inter_dimer_interface_maps_non_liganded

# cp $output/main_S173I_genetics_and_biochemistry.eps ./publication/nsmb/3_revision/main_fig_1_S173I_genetics_and_biochemistry.eps



