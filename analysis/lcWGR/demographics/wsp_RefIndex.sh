#!/bin/sh -l
#SBATCH -A fnrpupfish
#SBATCH -N 1
#SBATCH -n 5
#SBATCH -t 14-00:00:00
#SBATCH --job-name=refIndex
#SBATCH -e %x
#SBATCH -o %x

##########################################################################
###                          Samarth Mathur, PhD                     	###
###                        The Ohio State University                 	###
###                                                                     ###
###     Date Created: 09/27/22                  Last Modified: 10/07/22 ###
###########################################################################
###########################################################################
###                     refIndex.sh                        				###
###########################################################################

cd $SLURM_SUBMIT_DIR
module load bioinfo
module load bwa
module load samtools

# Index reference 

cd /scratch/bell/mathur20/pupfish/ref

bwa index GCF_016077235.1.fna
samtools faidx GCF_016077235.1.fna

