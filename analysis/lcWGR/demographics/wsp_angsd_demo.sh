#!/bin/sh -l
#SBATCH -A highmem
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --mem=100G
#SBATCH -t 1-00:00:00
#SBATCH --job-name=2Dsfs
#SBATCH -e %x
#SBATCH -o %x

##########################################################################
###                          Samarth Mathur, PhD                     	###
###                        The Ohio State University                 	###
###                                                                     ###
###     Date Created: 09/27/22                  Last Modified: 11/11/22 ###
###########################################################################
###########################################################################
###                     angsd.sh                        				###
###########################################################################

cd $SLURM_SUBMIT_DIR
module load biocontainers/default
module load bwa
module load samtools

# Get genotype likelihood of all samples

cd /scratch/bell/mathur20/pupfish/angsd/gl/

#/depot/fnrdewoody/apps/angsd/angsd -P 128 \
#-doCounts 1 -GL 1 -doGlf 2 -doMajorMinor 4 -doMaf 1 -minMaf 0.05 -rmTriallelic 1  \
#-minInd 36 -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -C 50 -baq 1 -minMapQ 30 -minQ 35 -setMinDepth 275 -setMaxDepth 425 -SNP_pval 1e-6  \
#-ref /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
#-bam /scratch/bell/mathur20/pupfish/lists/allSample.bamlist \
#-out allSample \

# Get genotype calls for all samples at SNPs (N=245,648)

#/home/mathur20/angsd/angsd -P 128 \
#-doBcf 1  -GL 1 -doMaf 2 -doMajorMinor 1 -doCounts 1 \
#-SNP_pval 0.000001 -doGeno 5 -doPost 1 -postCutoff 0.95 \
#--ignore-RG 0 -minMaf 0.05 \
#-setMinDepthInd 5 -minInd 5 -geno_minDepth 5 \
#-bam /scratch/bell/mathur20/pupfish/lists/allSample.bamlist \
#-out allSample

#/depot/fnrdewoody/apps/angsd/angsd -P 128 \
#-doBcf 1 -dopost 3  -gl 1 -domajorminor 1 -domaf 1 \
#-dogeno 2 \
#-b /scratch/bell/mathur20/pupfish/lists/allSample.bamlist \
#-pest /scratch/bell/mathur20/pupfish/angsd/sfs/ \
#-out angsdput2

# Get 1D SFS for all samples and each population (1. LR_ESU1 2. SC_ESU1 3. MS_ESU2) separately

#cd /scratch/bell/mathur20/pupfish/angsd/sfs

#/depot/fnrdewoody/apps/angsd/angsd -P 128 \
#-dosaf 1 -minQ 35 -GL 1 \
#-anc /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
#-bam /scratch/bell/mathur20/pupfish/lists/allSample.bamlist \
#-out allSample 

#/depot/fnrdewoody/apps/angsd/angsd -P 64 \
#-dosaf 1 -minQ 35 -GL 1 \
#-anc /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
#-bam /scratch/bell/mathur20/pupfish/lists/LR_ESU1.bamlist.txt \
#-out LR_ESU1 

#/depot/fnrdewoody/apps/angsd/angsd -P 64 \
#-dosaf 1 -minQ 35 -GL 1 \
#-anc /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
#-bam /scratch/bell/mathur20/pupfish/lists/SC_ESU1.bamlist.txt \
#-out SC_ESU1 


#/depot/fnrdewoody/apps/angsd/angsd -P 64 \
#-dosaf 1 -minQ 35 -GL 1 \
#-anc /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
#-bam /scratch/bell/mathur20/pupfish/lists/MS_ESU2.bamlist.txt \
#-out MS_ESU2 

#/depot/fnrdewoody/apps/angsd/angsd -P 64 \
#-dosaf 1 -minQ 35 -GL 1 \
#-anc /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
#-bam /scratch/bell/mathur20/pupfish/lists/ESU1.bamlist.txt \
#-out ESU1 


#/depot/fnrdewoody/apps/angsd/misc/realSFS LR_ESU1.saf.idx -fold 1 -P 128 > LR_ESU1.1D.sfs

# Get folded 2D-SFS

cd /scratch/bell/mathur20/pupfish/angsd/sfs

/depot/fnrdewoody/apps/angsd/misc/realSFS dadi -P 128 \
-ref /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
-anc /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
LR_ESU1.saf.idx SC_ESU1.saf.idx -sfs LR_ESU1.1D.sfs -sfs SC_ESU1.1D.sfs > LR_SC.2D.sfs




