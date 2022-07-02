#Defined population order
#==> pop_1.txt <==
#SC-p_R1_val_1

#==> pop_2.txt <==
#LR-p_R1_val_1

#==> pop_3.txt <==
#MS-p_R1_val_1

#Calculate average Fst from sliding window  for SC vs LR
awk '{print $6}' pupish_analyze_raw.Sfst | sed 's/1:2=//g' | awk '{ sum += $1 } END { print(sum / NR) }'
#0.0776292

#Calculate average Fst from sliding window for SC vs MS
awk '{print $7}' pupish_analyze_raw.Sfst | sed 's/1:3=//g' | awk '{ sum += $1 } END { print(sum / NR) }'
#0.467825

#Calculate average Fst from sliding window for LR vs MS
awk '{print $8}' pupish_analyze_raw.Sfst | sed 's/2:3=//g' | awk '{ sum += $1 } END { print(sum / NR) }'
#0.46221
