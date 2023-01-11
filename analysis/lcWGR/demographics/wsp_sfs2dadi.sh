#!/bin/sh -l
#SBATCH -A fnrpupfish
#SBATCH -N 1
#SBATCH -n 10
#SBATCH -t 14-00:00:00
#SBATCH --job-name=sfs2dadi
#SBATCH -e %x
#SBATCH -o %x

##########################################################################
###                          Samarth Mathur, PhD                     	###
###                        The Ohio State University                 	###
###                                                                     ###
###     Date Created: 10/09/22                  Last Modified: 10/11/22 ###
###########################################################################
###########################################################################
###                     sfs2dadi.sh                        				###
###########################################################################

cd $SLURM_SUBMIT_DIR
module load bioinfo
module load bwa
module load samtools

## LR (ESU1) = 15 ; SC (ESU1) = 14 ; MS (ESU2) = 15

#realsfs2dadi.pl :
#Coverts output of 'realSFS dadi' command to dadi-snp format understood by dadi and moments.
#argument 1: input file generated with
#realSFS dadi pop1.saf.idx pop2.saf.idx -sfs pop1.sfs -sfs pop2.sfs -ref reference.fasta -anc ancestral.fasta >dadiout
#subsequent arguments: numbers of individuals in each population (must match the number and order of populations 
#analyzed by realSFS)
#prints to STDOUT
#Example:
#realsfs2dadi.pl dadiout 20 20 >mypops_dadi.data

#cd /scratch/bell/mathur20/pupfish/gadma/2pop/SC_MS/sfs/
#/home/mathur20/2bRAD_denovo/realsfs2dadi.pl SC_MS.2D.sfs  14 15 > SC_MS.2D.dadi.sfs

#cd /scratch/bell/mathur20/pupfish/gadma/2pop/ESU1_2/sfs/
#/home/mathur20/2bRAD_denovo/realsfs2dadi.pl ESU1_ESU2.2D.sfs  29 15 > ESU1_2.2D.dadi.sfs

cd /scratch/bell/mathur20/pupfish/gadma/3pop/sfs/
/home/mathur20/2bRAD_denovo/realsfs2dadi.pl MS_SC_LR.3D.sfs  15 14 15 > MS_SC_LR.dadi.txt
