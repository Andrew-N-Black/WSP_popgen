#!/bin/sh -l
#SBATCH -A highmem
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --mem=250G
#SBATCH -t 1-00:00:00
#SBATCH --job-name=LR_sfs_boot
#SBATCH -e %x
#SBATCH -o %x

##########################################################################
###                          Samarth Mathur, PhD                     	###
###                        The Ohio State University                 	###
###                                                                     ###
###     Date Created: 12/11/22                  Last Modified: 12/11/22 ###
###########################################################################
###########################################################################
###                     sfs_boot.sh                        				###
###########################################################################

cd $SLURM_SUBMIT_DIR

# Sample 1 SNP from each scaffold (N = 1285) and use it to create SFS #

# Step1: Get random sites
# Run this in R#

#module load biocontainers
#module load r

#R
#library(plyr)
#library(dplyr)
#setwd("/scratch/bell/mathur20/pupfish/angsd/sites")

#allSNPs <- read.table("all_pop.mafs1", header=T)

#chrs <- sort(unique(allSNPs$chromo))

#for (i in 1:30)
#{
#	randSites <- NULL
#	for (chr in chrs)
#	{
#		df <- allSNPs[which(allSNPs$chromo == chr),]
#		df2 <- sample_n(df, 1)
#		randSites <- rbind(randSites,df2)
#	}
#	randSites <- randSites[,c(1,2)]
#	write.table(randSites,paste("randSites/randSite.",i,".sites",sep=""),quote=F,row.names=F)
#}

# Step2: Index random sites

cd /scratch/bell/mathur20/pupfish/angsd/sites/randSites

for i in {1..30}
do
	#sed 's/ /:/g' randSite.$i.sites | sed '1d' > randSites.$i.sites
	/depot/fnrdewoody/apps/angsd/angsd sites index randSites.$i.sites

done

# Get 1-D SFS
cd /scratch/bell/mathur20/pupfish/angsd/sfs_boot/1D/
for i in {1..30}
do

	/depot/fnrdewoody/apps/angsd/misc/realSFS -fold 1 -P 128 \
	/scratch/bell/mathur20/pupfish/angsd/sfs/LR_ESU1.saf.idx
	-sites /scratch/bell/mathur20/pupfish/angsd/sites/randSites/randSites.$i.sites  > LR_ESU1.$i.randSites.1D.sfs

	/depot/fnrdewoody/apps/angsd/misc/realSFS -fold 1 -P 128 \
	/scratch/bell/mathur20/pupfish/angsd/sfs/SC_ESU1.saf.idx
	-sites /scratch/bell/mathur20/pupfish/angsd/sites/randSites/randSites.$i.sites  > SC_ESU1.$i.randSites.1D.sfs

	/depot/fnrdewoody/apps/angsd/misc/realSFS -fold 1 -P 128 \
	/scratch/bell/mathur20/pupfish/angsd/sfs/MS_ESU2.saf.idx
	-sites /scratch/bell/mathur20/pupfish/angsd/sites/randSites/randSites.$i.sites  > MS_ESU2.$i.randSites.1D.sfs
done

# Get 3D SFS

cd /scratch/bell/mathur20/pupfish/angsd/sfs_boot/3D/

for i in {1..30}
do
	/depot/fnrdewoody/apps/angsd/misc/realSFS dadi -P 128 \
	-ref /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
	-anc /scratch/bell/mathur20/pupfish/ref/GCF_016077235.1.fna \
	-sites /scratch/bell/mathur20/pupfish/angsd/sites/randSites/randSites.$i.sites \
	/scratch/bell/mathur20/pupfish/angsd/sfs/LR_ESU1.saf.idx \
	/scratch/bell/mathur20/pupfish/angsd/sfs/LR_ESU1.saf.idx \
	/scratch/bell/mathur20/pupfish/angsd/sfs/LR_ESU1.saf.idx \
	-sfs /scratch/bell/mathur20/pupfish/angsd/sfs_boot/1D/LR_ESU1.$i.randSites.1D.sfs \
	-sfs /scratch/bell/mathur20/pupfish/angsd/sfs_boot/1D/SC_ESU1.$i.randSites.1D.sfs \
	-sfs /scratch/bell/mathur20/pupfish/angsd/sfs_boot/1D/MS_ESU2.$i.randSites.1D.sfs > LR_SC_MS.3D.$i.randSites.sfs
done


