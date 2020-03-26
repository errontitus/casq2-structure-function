#! /bin/zsh
#

mkdir -p output
rm ./output/*

# mkdir -p output/tetramer
# mkdir -p output/octamer

cd output

# pdb2pqr [options] --ff=amber ../results/shared_pdb/dimer_and_tetramer/output/tetramer_deo_native_no_het.pdb ./output/

# Some additional changes to the apbs input file made by hand and detailed below.
#
# The input file produced by pdb2pqr has no ions in it.
#
# We add a reasonable set of ions to create a electric double layer. Otherwise the protein surface will be uniformly electronegative. Typical ion choices are 0.15 M, with a radius of 2.0 (when multiple radii are specified, only the larger is used). I'm not sure where this conventional value comes from, although it corresponds roughly to the ionic radius of Cl-.

#
# Grid points
#
# We typically increase grid points (dime) to to get higher grid sampling and also to make sure that we start at a far enough distance to justify the assumption that the starting potential is 0. Grid resolution is fglen/dime, i.e. the dimension of the box around the molecule divided by the number of grid points. f=fine for fine grid.
#
# For example, here we increase dime to 385 in one dimension and 513 in another to improve resolution. 


#
# Size of starting box.
#
# cglen (c=coarse) is the box used for the outer boundary condition and should be far enough away from the molecule to justify the starting boundary assumption. For example, see the documentation for the bcfl keyword. A typical starting assumption may be to treat the entire biomolecule as a single spherical charge, summing up all its internal charges, with radius equal to the "radius" of the protein. cglen values should be far enough away such that potential is effectively zero at this distance. 
#
# No changes made here to the PDB2PQR defaulted value.

#
# Choice of solver.
#
# Use the non-linear PB (npbe). Important because the Taylor approximation for the linear PB has a kT term that will produce wildly divergent value for large kT.


####################### 

pdb2pqr --ff=AMBER --apbs-input --chain ../../../filament/output/tetramer_deo_native_no_het.pdb ./tetramer_deo_native_no_het.pqr 

# | tee tetramer_deo_native_no_het_pdb2pqr.log

# original dime 193 193 289
settings_tetramer="elec 
    mg-auto
    dime 385 385 577
    cglen 139.5414 139.5414 213.6312
    fglen 102.0832 102.0832 145.6654
    cgcent mol 1
    fgcent mol 1
    mol 1
    npbe
    bcfl sdh
    pdie 2.0000
    sdie 78.5400
    srfm smol
    chgm spl2
    sdens 10.00
    srad 1.40
    swin 0.30
    temp 298.15
    calcenergy total
    calcforce no
    ion charge +1 conc 0.15 radius 2.0
    ion charge -1 conc 0.15 radius 2.0"

echo "read
    mol pqr tetramer_deo_native_no_het.pqr
end" > apbs_settings.in 
echo $settings_tetramer >> apbs_settings.in 
echo "    write pot dx ./tetramer_deo_native_no_het.pqr
end
print elecEnergy 1 end
quit" >> apbs_settings.in 

# run apbs
apbs ./apbs_settings.in 
# | tee tetramer_deo_native_no_het_apbs.log


####################### 




# awk '1;/calcforce/{exit}' ./tetramer_deo_native_no_het.in > apbs_settings.in 

# echo "    ion charge +1 conc 0.15 radius 2.0" >> apbs_settings.in 
# echo "    ion charge -1 conc 0.15 radius 2.0" >> apbs_settings.in 

# sed -n "/write pot/,$ p" ./tetramer_deo_native_no_het.in >> apbs_settings.in 

# tail -5 ./tetramer_deo_native_no_het-pqr.in >> >> apbs_settings.in 

# sed -n '/calcforce/,$p' ./output/tetramer_deo_native_no_het-pqr.in
