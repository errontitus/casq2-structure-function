#! /bin/zsh
#

mkdir -p output 

cd ./native
source run.zsh
cd ..

cd ./yb
source run.zsh
cd ..

phx_table_one_native=./native/output_native_table_one.csv

phx_table_one_anom=./yb/output_anom_table_one.csv

python make_table_xtal_stats.py $phx_table_one_native $phx_table_one_anom

