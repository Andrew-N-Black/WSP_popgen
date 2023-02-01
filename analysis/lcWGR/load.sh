 #Move to the ALL directory
 /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/LOAD/ALL
 
 #Concatenate all high sites for the three populations
 cat ../MS/ms_high_sites.txt ../SC/sc_high_sites.txt ../LR/lr_high_sites.txt > all.high.sites.txt
 
 #Extract only these sites
 vcftools --vcf all.vcf --positions all.high.sites.txt --recode --keep-INFO-all --out all.high.sites
 
 #To print out each SNP to evaluate deleterious:
grep "NW_024037791.1$(printf '\t')75071" all.high.sites.recode.vcf | cut -f 10-  | tr "," "\t" | awk '{ for (i=1;i<=NF;i+=7) print $i }' | cut -d ":" -f1

