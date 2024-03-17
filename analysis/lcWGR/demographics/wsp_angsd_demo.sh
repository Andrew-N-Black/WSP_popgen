#!/bin/sh -l
#SBATCH -A highmem
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --mem=500G
#SBATCH -t 1-00:00:00
#SBATCH --job-name=3Dsfs
#SBATCH -e %x
#SBATCH -o %x

##########################################################################
###                          Samarth Mathur, PhD                     	###
###                        The Ohio State University                 	###
###                                                                     ###
###########################################################################
###########################################################################
###                     wsp_angsd_demo.sh                        		###
###########################################################################

cd $SLURM_SUBMIT_DIR
module load bioinfo
module load bwa
module load samtools

# Get genotype likelihood of all samples

#cd /scratch/bell/mathur20/pupfish/angsd/gl/

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

cd /scratch/bell/mathur20/pupfish/angsd/sfs

#/depot/fnrdewoody/apps/angsd/angsd -P 128 \
#-dosaf 1 -minQ 35 -GL 1 \
#-anc /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
#-bam /scratch/bell/mathur20/pupfish/lists/LR_ESU1.bamlist.txt \
#-out LR_ESU1 

#/depot/fnrdewoody/apps/angsd/angsd -P 128 \
#-dosaf 1 -minQ 35 -GL 1 \
#-anc /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
#-bam /scratch/bell/mathur20/pupfish/lists/SC_ESU1.bamlist.txt \
#-out SC_ESU1 


#/depot/fnrdewoody/apps/angsd/angsd -P 128 \
#-dosaf 1 -minQ 35 -GL 1 \
#-anc /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
#-bam /scratch/bell/mathur20/pupfish/lists/ESU2.bamlist.txt \
#-out MS_ESU2 

#/depot/fnrdewoody/apps/angsd/angsd -P 128 \
#-dosaf 1 -minQ 35 -GL 1 \
#-anc /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
#-bam /scratch/bell/mathur20/pupfish/lists/ESU1.bamlist.txt \
#-out ESU1 

# all samples together #

#/depot/fnrdewoody/apps/angsd/angsd -P 128 \
#-dosaf 1 -minQ 35 -GL 1 \
#-anc /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
#-bam /scratch/bell/mathur20/pupfish/lists/allSample.bamlist \
#-out allSample 

# Get folded 1D SFS #

#/depot/fnrdewoody/apps/angsd/misc/realSFS LR_ESU1.saf.idx -fold 1 -P 128 > LR_ESU1.1D.sfs
#/depot/fnrdewoody/apps/angsd/misc/realSFS SC_ESU1.saf.idx -fold 1 -P 128 > SC_ESU1.1D.sfs
#/depot/fnrdewoody/apps/angsd/misc/realSFS MS_ESU2.saf.idx -fold 1 -P 128 > MS_ESU2.1D.sfs
#/depot/fnrdewoody/apps/angsd/misc/realSFS ESU1.saf.idx -fold 1 -P 128 > ESU1.1D.sfs

# Get 3D-SFS

cd /scratch/bell/mathur20/pupfish/angsd/sfs

/depot/fnrdewoody/apps/angsd/misc/realSFS dadi -P 128 \
-ref /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
-anc /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
MS_ESU2.saf.idx SC_ESU1.saf.idx LR_ESU1.saf.idx -sfs MS_ESU2.1D.sfs -sfs SC_ESU1.1D.sfs -sfs LR_ESU1.1D.sfs > MS_SC_LR.3D.sfs


# Convert 3D-sfs to dadi
#realsfs2dadi.pl :
#Coverts output of 'realSFS dadi' command to dadi-snp format understood by dadi and moments.
#argument 1: input file generated with
#realSFS dadi pop1.saf.idx pop2.saf.idx -sfs pop1.sfs -sfs pop2.sfs -ref reference.fasta -anc ancestral.fasta >dadiout
#subsequent arguments: numbers of individuals in each population (must match the number and order of populations 
#analyzed by realSFS)
#prints to STDOUT
#Example:
#realsfs2dadi.pl dadiout 20 20 >mypops_dadi.data

### ## LR (ESU1) = 15 ; SC (ESU1) = 14 ; MS (ESU2) = 15 ###

/home/mathur20/2bRAD_denovo/realsfs2dadi.pl MS_SC_LR.3D.sfs  15 14 15 > MS_SC_LR.dadi.txt

