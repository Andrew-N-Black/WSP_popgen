#!/bin/bash
#SBATCH -A fnrdewoody
#SBATCH -n 64
#SBATCH -t 14-00:00:00
#SBATCH --job-name=bcf
#SBATCH --error=bcf.e
#SBATCH --output=bcf.o
#SBATCH --mem=100G

#Load modules
module load bioinfo
module load bcftools
module load samtools

#Move to bam folder and generate a bcf
angsd -GL 1 -dobcf 1 -dopost 1 -domajorminor 1 -domaf 1 -minQ 30 -P 64 \
-baq 2 -SNP_pval 1e-6 -bam bamlist.txt -ref ref_100k.fa

#Create tab freq file
bcftools query -f'%CHROM\t%POS\t%REF,%ALT\t%INFO/AF\n' angsdput.bcf | bgzip -c > PUP.freqs.tab.gz
tabix -s1 -b2 -e2 PUP.freqs.tab.gz
#Generate ROH file
bcftools roh --AF-file PUP.freqs.tab.gz --output ROH_PUP_PLraw.txt --threads 64 angsdput.bcf

#Extract RG from raw calls
awk '$1=="RG"' ROH_PUP_PLraw.txt > ROH_RG_all.txt

#Parse file into indivudals
for i in `cat sample.names`; do  grep $i ROH_RG_all.txt  > $i.ROH.txt ; done
for i in `ls -1 *ROH.txt`; do python ROHparser.py $i > ${i}_results.txt ; done
