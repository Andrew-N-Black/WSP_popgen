#!/bin/sh -l
#SBATCH -A fnrdewoody
#SBATCH -N 1
#SBATCH -n 10
#SBATCH -t 1-00:00:00
#SBATCH --job-name=fst.persite
#SBATCH -e %x
#SBATCH -o %x

##########################################################################
###                          Samarth Mathur, PhD                     	###
###                        The Ohio State University                 	###
###                                                                     ###
###     Date Created: 09/27/22                  Last Modified: 10/09/22 ###
###########################################################################
###########################################################################
###                     angsd.sh                        				###
###########################################################################

cd $SLURM_SUBMIT_DIR
#module load biocontainers/default
#module load bwa
#module load samtools

# Get folded 2D-SFS
# (MS-SC)

cd /scratch/bell/mathur20/pupfish/angsd/fst

#/depot/fnrdewoody/apps/angsd/misc/realSFS -P 128 \
#-ref /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
#-anc /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
#/scratch/bell/mathur20/pupfish/angsd/sfs/MS_ESU2.saf.idx \
#/scratch/bell/mathur20/pupfish/angsd/sfs/SC_ESU1.saf.idx  > MS_SC.2D.sfs


# Calculate global Fst for each bootrap 2D-SFS


#cd /scratch/bell/mathur20/pupfish/angsd/fst/

#/depot/fnrdewoody/apps/angsd/misc/realSFS fst index -P 80 \
#/scratch/bell/mathur20/pupfish/angsd/sfs/MS_ESU2.saf.idx \
#/scratch/bell/mathur20/pupfish/angsd/sfs/SC_ESU1.saf.idx \
#-sfs MS_SC.2D.sfs \
#-fstout MS_SC

#Fst sliding window (window size = 100kb, step = 50kb)
#/depot/fnrdewoody/apps/angsd/misc/realSFS fst stats2 \
#MS_SC.fst.idx -win 100000 -step 50000 \
#> MS_SC.fst_100.50 

# Per site
/depot/fnrdewoody/apps/angsd/misc/realSFS fst print \
MS_SC.fst.idx \
> MS_SC.persite.fst



# Get folded 2D-SFS
# (ESU1-ESU2)

#cd /scratch/bell/mathur20/pupfish/angsd/fst

#/depot/fnrdewoody/apps/angsd/misc/realSFS -P 128 \
#-ref /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
#-anc /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
#/scratch/bell/mathur20/pupfish/angsd/sfs/ESU1.saf.idx \
#/scratch/bell/mathur20/pupfish/angsd/sfs/MS_ESU2.saf.idx > ESU1_ESU2.2D.sfs


# Calculate global Fst for each bootrap 2D-SFS


#cd /scratch/bell/mathur20/pupfish/angsd/fst/

#/depot/fnrdewoody/apps/angsd/misc/realSFS fst index -P 80 \
#/scratch/bell/mathur20/pupfish/angsd/sfs/ESU1.saf.idx \
#/scratch/bell/mathur20/pupfish/angsd/sfs/MS_ESU2.saf.idx \
#-sfs ESU1_ESU2.2D.sfs \
#-fstout ESU1_ESU2

#Fst sliding window (window size = 100kb, step = 50kb)
#/depot/fnrdewoody/apps/angsd/misc/realSFS fst stats2 \
#ESU1_ESU2.fst.idx -win 100000 -step 50000 \
#> ESU1_ESU2.fst_100.50 

# Per site
/depot/fnrdewoody/apps/angsd/misc/realSFS fst print \
ESU1_ESU2.fst.idx \
> ESU1_ESU2.persite.fst


# Get folded 2D-SFS
# (LR-SC)

cd /scratch/bell/mathur20/pupfish/angsd/fst

#/depot/fnrdewoody/apps/angsd/misc/realSFS -P 128 \
#-ref /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
#-anc /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
#/scratch/bell/mathur20/pupfish/angsd/sfs/LR_ESU1.saf.idx \
#/scratch/bell/mathur20/pupfish/angsd/sfs/SC_ESU1.saf.idx  > LR_SC.2D.sfs


# Calculate global Fst for each bootrap 2D-SFS


#cd /scratch/bell/mathur20/pupfish/angsd/fst/

#/depot/fnrdewoody/apps/angsd/misc/realSFS fst index -P 80 \
#/scratch/bell/mathur20/pupfish/angsd/sfs/LR_ESU1.saf.idx \
#/scratch/bell/mathur20/pupfish/angsd/sfs/SC_ESU1.saf.idx \
#-sfs LR_SC.2D.sfs \
#-fstout LR_SC

#Fst sliding window (window size = 100kb, step = 50kb)
#/depot/fnrdewoody/apps/angsd/misc/realSFS fst stats2 \
#LR_SC.fst.idx -win 100000 -step 50000 \
#> LR_SC.fst_100.50 

# Per site
/depot/fnrdewoody/apps/angsd/misc/realSFS fst print \
LR_SC.fst.idx \
> LR_SC.persite.fst

