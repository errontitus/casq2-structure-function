#! /bin/zsh
#

whichstructure="$1"
print $whichstructure


chains=ACEGIKM
for (( i=0; i<${#chains}; i++ )); do
    letter=${chains:$i:1}
    echo $letter

    # Dimer cavity
    python ../../../bin/structure/hollow-1.2/hollow.py -o ./output/hollow_"$whichstructure"_dimer_cavity_"$letter".pdb -g 0.25 ./output/filament_"$whichstructure"_pseudo_no_het.pdb -c  ./hollow/hollow_dimer_cavity_$letter.txt
done

chains=BDFHJL
for (( i=0; i<${#chains}; i++ )); do
    letter=${chains:$i:1}
    echo $letter

     # Tetramer cavity
     python ../../../bin/structure/hollow-1.2/hollow.py -o ./output/hollow_"$whichstructure"_tetramer_cavity_"$letter".pdb -g 0.25 ./output/filament_"$whichstructure"_pseudo_no_het.pdb -c ./hollow/hollow_tetramer_cavity_$letter.txt
done

chains=ABCDEFGHIJKLMN
for (( i=0; i<${#chains}; i++ )); do
    letter=${chains:$i:1}
    echo $letter

    # Connecting tunnel
    python ../../../bin/structure/hollow-1.2/hollow.py -o ./output/hollow_"$whichstructure"_dimer_tunnel_"$letter".pdb -g 0.25 ./output/filament_"$whichstructure"_pseudo_no_het.pdb -c ./hollow/hollow_dimer_tunnel_$letter.txt
done

# Extra wide radius run to examine other very small branchings off of the main cavity. Since we don't see any Yb in these spaces, and they are very small, we are omitting them from the depiction. But this allows us to double check whether any of these branchings are substantial in size.
python ../../../bin/structure/hollow-1.2/hollow.py -o ./output/hollow_"$whichstructure"_tetramer_cavity_B_wide.pdb -g 0.25 ./output/filament_""$whichstructure""_pseudo_no_het.pdb -c ./hollow/hollow_tetramer_cavity_B_wide.txt
