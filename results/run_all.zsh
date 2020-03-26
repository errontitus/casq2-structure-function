#! /bin/zsh
#

source clean.zsh

cd ./shared_pdb
# Builds the common/shared result objects in the required order.
source run.zsh
cd ..

cd ./assembly_kinetics
source run.zsh
cd ..

cd ./cavity
source run.zsh
cd ..

cd ./dimer_interface
source run.zsh
cd ..

cd ./filament_comparison
source run.zsh
cd ..

cd ./filament_overview
source run.zsh
cd ..

cd ./inter_dimer_comparison
source run.zsh
cd ..

cd ./inter_dimer_interface
source run.zsh
cd ..

cd ./inter_dimer_interface_alignment
source run.zsh
cd ..

cd ./materials_and_methods
source run.zsh
cd ..

cd ./orthology
source run.zsh
cd ..

cd ./pedigree_S173I
source run.zsh
cd ..

cd ./table_one
source run.zsh
cd ..

cd ./table_xtal_comparison
source run.zsh
cd ..
