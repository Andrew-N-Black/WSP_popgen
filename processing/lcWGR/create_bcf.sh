#!/bin/bash
#SBATCH -A fnrdewoody
#SBATCH -n 64
#SBATCH -t 14-00:00:00
#SBATCH --job-name=bcf
#SBATCH --error=bcf.e
#SBATCH --output=bcf.o
#SBATCH --mem=100G
module load bioinfo
module load bcftools
module load samtools
#Move to bam folder

#angsd -GL 1 -dobcf 1 -dopost 1 -domajorminor 1 -domaf 1 -minQ 30 -P 64 \
#-baq 2 -SNP_pval 1e-6 -bam bamlist.txt -ref /scratch/bell/blackan/PUPFISH/C.tularosa/assembly/ncbi/Cyprinodon-tularosa/GCF_016077235.1_ref/ref_100k.fa

bcftools query -f'%CHROM\t%POS\t%REF,%ALT\t%INFO/AF\n' angsdput.bcf | bgzip -c > PUP.freqs.tab.gz
tabix -s1 -b2 -e2 PUP.freqs.tab.gz
bcftools roh --AF-file PUP.freqs.tab.gz --output ROH_PUP_PLraw.txt --threads 64 angsdput.bcf

awk '$1=="RG"' ROH_PUP_PLraw.txt > ROH_RG_all.txt
for i in `cat sample.names`; do  grep $i ROH_RG_all.txt  > $i.ROH.txt ; done
