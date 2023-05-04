##########################################################################
###                          Samarth Mathur, PhD                     	###
###                        The Ohio State University                 	###
###                                                                     ###
###     Date Created: 12/11/22                  Last Modified: 04/14/23 ###
###########################################################################
###########################################################################
###                     sfs_boot.R                       				###
###########################################################################


# Sample 1 SNP from each scaffold (N = 1285) and use it to create SFS #

# Step1: Get random sites

library(plyr)
library(dplyr)
setwd("/scratch/bell/mathur20/pupfish/gadma/run2_newMu/sfs")

allSFS <- read.table("MS_SC_LR.dadi.txt", header=T)

scaffs <- sort(unique(allSFS$Gene)) # N = 1285

for (i in 1:100)
{
	randSFS <- NULL
	for (scaff in scaffs)
	{
		df <- allSFS[which(allSFS$Gene == scaff),]
		df2 <- df[sample(nrow(df), 1), ] # Randomly select 1 row
		randSFS <- rbind(randSFS,df2)
	}
	write.table(randSFS,paste("/scratch/bell/mathur20/pupfish/gadma/run2_newMu/sfs_boot/randSFS.",i,".txt",sep=""),quote=F,row.names=F)
}



