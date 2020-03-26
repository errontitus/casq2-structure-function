#! /bin/zsh
#

mkdir -p output/native_D144A_2X
mkdir -p output/native_E174A_2X

mkdir -p output/native_E174Q_2X

mkdir -p output/native_D144Q_2X
mkdir -p output/native_D144Q_E174Q_2X

cd native_D144A_2X

pdb2pqr --ff=AMBER --apbs-input --chain ../../../dimer_and_tetramer/output/inter_dimer_deo_native_no_het.pdbALA144.pdbALA144.pdb ./inter_dimer_deo_native_no_het.pdbALA144.pdbALA144.pqr | tee inter_dimer_deo_native_no_het.pdbALA144.pdbALA144_pdb2pqr.log

echo "read
    mol pqr inter_dimer_deo_native_no_het.pdbALA144.pdbALA144.pqr
end" > apbs_settings.in 
echo $settings_inter_dimer >> apbs_settings.in 
echo "    write pot dx ./inter_dimer_deo_native_no_het.pdbALA144.pdbALA144.pqr
end
print elecEnergy 1 end
quit" >> apbs_settings.in 

# run apbs
apbs ./apbs_settings.in | tee inter_dimer_deo_native_no_het.pdbALA144.pdbALA144_apbs.log

cd ..

#######################

cd native_E174A_2X

pdb2pqr --ff=AMBER --apbs-input --chain ../../../dimer_and_tetramer/output/tetramer_deo_native_no_het.pdbALA174.pdbALA174.pdb ./tetramer_deo_native_no_het.pdbALA174.pdbALA174.pqr | tee tetramer_deo_native_no_het.pdbALA174.pdbALA174_pdb2pqr.log

echo "read
    mol pqr tetramer_deo_native_no_het.pdbALA174.pdbALA174.pqr
end" > apbs_settings.in 
echo $settings >> apbs_settings.in 
echo "    write pot dx ./tetramer_deo_native_no_het.pdbALA174.pdbALA174.pqr
end
print elecEnergy 1 end
quit" >> apbs_settings.in 

# run apbs
apbs ./apbs_settings.in | tee tetramer_deo_native_no_het.pdbALA174.pdbALA174.log

cd ..

#######################


cd .. 
cd native_D144Q_2X

pdb2pqr --ff=AMBER --apbs-input --chain ../../../dimer_and_tetramer/output/tetramer_deo_native_no_het.pdbGLN144.pdbGLN144.pdb ./tetramer_deo_native_no_het.pdbGLN144.pdbGLN144.pqr | tee tetramer_deo_native_no_het.pdbGLN144.pdbGLN144_pdb2pqr.log

echo "read
    mol pqr tetramer_deo_native_no_het.pdbGLN144.pdbGLN144.pqr
end" > apbs_settings.in 
echo $settings >> apbs_settings.in 
echo "    write pot dx ./tetramer_deo_native_no_het.pdbGLN144.pdbGLN144.pqr
end
print elecEnergy 1 end
quit" >> apbs_settings.in 

# run apbs
apbs ./apbs_settings.in | tee tetramer_deo_native_no_het.pdbGLN144.pdbGLN144.log


# cp ./tetramer_deo_native_no_het.in apbs_settings.in 
# apbs ./apbs_settings.in | tee tetramer_deo_native_no_het_apbs.log


cd octamer

pdb2pqr --ff=AMBER --apbs-input --chain ../../../filament/output/octamer_deo_native_no_het.pdb ./octamer_deo_native_no_het.pqr | tee octamer_deo_native_no_het_pdb2pqr.log

# original dime 225 225 513
# could increase to 577.
settings_octamer="elec 
    mg-auto
    dime 225 225 513
    cglen 162.7665 162.7665 394.8427
    fglen 115.7450 115.7450 252.2604
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
    mol pqr octamer_deo_native_no_het.pqr
end" > apbs_settings.in 
echo $settings_octamer >> apbs_settings.in 
echo "    write pot dx ./octamer_deo_native_no_het.pqr
end
print elecEnergy 1 end
quit" >> apbs_settings.in 

# run apbs
apbs ./apbs_settings.in | tee octamer_deo_native_no_het_apbs.log