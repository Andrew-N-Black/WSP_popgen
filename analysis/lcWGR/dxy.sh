#!/bin/sh -l
#SBATCH -A fnrpredator
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -t 14-00:00:00
#SBATCH --job-name=pup_maf_MS
#SBATCH -e %x_%j.err
#SBATCH -o %x_%j.out

cd $SLURM_SUBMIT_DIR
module purge
module load biocontainers
module load angsd/0.935

##Calculate Dxy between the pairs of 3 White Sands Pupfish populations

#Run ANGSD with all populations with a -SNP_pval and -skipTriallelic flags
angsd -bam ./bam.list -doMaf 1 -minInd 36 -SNP_pval 1e-6 -skipTriallelic 1 -minMapQ 30 -minQ 35 -doMajorMinor 1 -GL 1 -out ./Dxy/all_pop

#Index the sites file corresponding to the recovered SNPs(header removed)
angsd sites index ./Dxy/sites_maf.txt

#Rerun ANGSD per population using the recovered SNPs

#For MS population
angsd -bam ./bam_MS.list -doMaf 1 -minInd 12 -skipTriallelic 1 -minMapQ 30 -minQ 35 -doMajorMinor 1 -GL 1 -out ./Dxy/MS \
 -sites ./Dxy/sites_maf.txt -ref GCF_016077235.1_ASM1607723v1_genomic.fna

#For SC population
angsd -bam ./bam_SC.list -doMaf 1 -minInd 12 -skipTriallelic 1 -minMapQ 30 -minQ 35 -doMajorMinor 1 -GL 1 -out ./Dxy/SC \
 -sites ./Dxy/sites_maf.txt -ref GCF_016077235.1_ASM1607723v1_genomic.fna

#For LR population
angsd -bam ./bam_LR.list -doMaf 1 -minInd 12 -skipTriallelic 1 -minMapQ 30 -minQ 35 -doMajorMinor 1 -GL 1 -out ./Dxy/LR \
 -sites ./Dxy/sites_maf.txt -ref GCF_016077235.1_ASM1607723v1_genomic.fna

####Then ran Rscript from https://github.com/mfumagalli/ngsPopGen/blob/master/scripts/calcDxy.R to get the Dxy between populations



##Calculate Dxy between C.diabolis vs C.nevadensis

#Run ANGSD with both populations with a -SNP_pval and -skipTriallelic flags
angsd -bam ./bam_other.list -doMaf 1 -minInd 16 -SNP_pval 1e-6 -skipTriallelic 1 -minMapQ 30 -minQ 35 -doMajorMinor 1 -GL 1 -out both_pop

#Index the sites file corresponding to the recovered SNPs(header removed)
angsd sites index sites_other.txt 

#Rerun ANGSD per population using the recovered SNPs.

#For C.diabolis population
angsd -bam ./bam_diabolis.list -doMaf 1 -minInd 5 -skipTriallelic 1 -minMapQ 30 -minQ 35 -doMajorMinor 1 -GL 1 -out ./diabolis -sites ./sites_other -ref ./ref/GCA_018398635.1_UCB_Cbro_1.0_genomic.fna

#For C.nevadensis population
/angsd -bam ./bam_nevadensis.list -doMaf 1 -minInd 10 -skipTriallelic 1 -minMapQ 30 -minQ 35 -doMajorMinor 1 -GL 1 -out ./nevadensis -sites ./sites_other -ref ./ref/GCA_018398635.1_UCB_Cbro_1.0_genomic.fna

####Then ran Rscript from https://github.com/mfumagalli/ngsPopGen/blob/master/scripts/calcDxy.R to get the Dxy between populations
