









#Define Populations
#head pop*
#==> pop_1.txt <==
#SC-p_R1_val_1
#==> pop_2.txt <==
#LR-p_R1_val_1
#==> pop_3.txt <==
#MS-p_R1_val_1

#Parse fst, fstS, and fet files
cut -f 8  pupish_analyze_raw.fst  | cut -c 5-20 > LR.MS.fst.txt
cut -f 7  pupish_analyze_raw.fst | cut -c 5-20 > SC.MS.fst.txt
cut -f 6  pupish_analyze_raw.fst | cut -c 5-20 > SC.LR.fst.txt

cut -f 8  pupish_analyze_raw.Sfst  | cut -c 5-20 > LR.MS.fstS.txt
cut -f 7  pupish_analyze_raw.Sfst | cut -c 5-20 > SC.MS.fstS.txt
cut -f 6  pupish_analyze_raw.Sfst | cut -c 5-20 > SC.LR.fstS.txt

cut -f 8  pupish_analyze_raw.fet  | cut -c 5-20 > LR.MS.fet.txt
cut -f 7  pupish_analyze_raw.fet | cut -c 5-20 > SC.MS.fet.txt
cut -f 6  pupish_analyze_raw.fet | cut -c 5-20 > SC.LR.fet.txt
