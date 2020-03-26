#! /bin/zsh
#

chains=ABCDEFGHIJKLMN
for (( i=0; i<${#chains}; i++ )); do
    letter=${chains:$i:1}
    echo $letter

    cp template_hollow_dimer_tunnel.txt tmp.txt
    file=hollow_dimer_tunnel_$letter.txt
    awk -v chain="$letter" '/chain1/{gsub(/A/, chain)};{print}' tmp.txt > tmp2.txt
    awk -v chain="$letter" '/chain2/{gsub(/A/, chain)};{print}' tmp2.txt > $file
done

chains=ACEGIKM
for (( i=0; i<${#chains}; i++ )); do
    letter=${chains:$i:1}
    echo $letter

    cp template_hollow_dimer_cavity.txt tmp.txt
    file=hollow_dimer_cavity_$letter.txt
    awk -v chain="$letter" '/chain1/{gsub(/A/, chain)};{print}' tmp.txt > tmp2.txt
    awk -v chain="$letter" '/chain2/{gsub(/A/, chain)};{print}' tmp2.txt > $file
done

chains=BDFHJL
for (( i=0; i<${#chains}; i++ )); do
    letter=${chains:$i:1}
    echo $letter

    cp template_hollow_tetramer_cavity.txt tmp.txt
    file=hollow_tetramer_cavity_$letter.txt
    awk -v chain="$letter" '/chain1/{gsub(/B/, chain)};{print}' tmp.txt > tmp2.txt
    awk -v chain="$letter" '/chain2/{gsub(/B/, chain)};{print}' tmp2.txt > $file
done

rm tmp.txt
rm tmp2.txt

# Old approach...

# chains=ABCDEFGHIJKLMN
# for (( i=0; i<${#chains}; i++ )); do
#     letter=${chains:$i:1}
#     echo $letter

#     file=hollow_dimer_pore_$letter.txt
#     awk -v chain="$letter" '/chain1/{gsub(/A/, chain)};{print}' hollow_dimer_pore.txt > tmp.txt
#     awk -v chain="$letter" '/chain2/{gsub(/A/, chain)};{print}' tmp.txt > $file

#     file=hollow_dimer_tunnel_$letter.txt
#     awk -v chain="$letter" '/chain1/{gsub(/A/, chain)};{print}' hollow_dimer_tunnel.txt > tmp.txt
#     awk -v chain="$letter" '/chain2/{gsub(/A/, chain)};{print}' tmp.txt > $file
# done

# # Requires manual touchup afterward.
# chains=BCDEFGHIJKLM
# for (( i=0; i<${#chains}; i++ )); do
#     letter=${chains:$i:1}
#     echo $letter

#     file=hollow_tetramer_pore_$letter.txt
#     cp hollow_tetramer_pore.txt tmp.txt
#     awk -v chain="$letter" '/chain1/{gsub(/A/, chain)};{print}' tmp.txt > tmp2.txt
#     awk -v chain="$letter" '/chain2/{gsub(/A/, chain)};{print}' tmp2.txt > $file
# done