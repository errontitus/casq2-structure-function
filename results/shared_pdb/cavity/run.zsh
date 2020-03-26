#! /bin/zsh
#

mkdir -p output
rm ./output/*

pymol -cq make_filament_deo_native_for_hollow.pml
pymol -cq make_filament_deo_yb_for_hollow.pml

# if [[ ! -a ./output/hollow_deo_yb_dimer_tunnel_N.pdb ]]; then
    source run_hollow.zsh "deo_yb"
# fi

# if [[ ! -a ./output/hollow_deo_native_dimer_tunnel_N.pdb ]]; then
    source run_hollow.zsh "deo_native"
# fi
