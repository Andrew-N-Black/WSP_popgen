#!/bin/sh
#SBATCH -A fnrtowhee
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -t 14-00:00:00
#SBATCH --job-name=phylo_tree
#SBATCH -e phylo_tree.err
#SBATCH -o phylo_tree.o



module purge
module load biocontainers
module load vcf-kit/0.2.9
module load bioinfo
module load bcftools/1.15.1
module load iqtree/2.1.2

##WGR tree

#Generate a vcf file for all 45 WGR C.tularosa samples and C.variegatus from genotype likelihood

cd final_bams

angsd -GL 2 -out wgs_tree \
 -sites ./FINAL.SITES -P 64 -bam bam.list -doGlf 2 -doMajorMinor 1 -doMaf 1 \
 -ref GCF_016077235.1_ASM1607723v1_genomic.fna \
 -doBcf 1 -doPost 1 -docounts 1 -dogeno 5

#Generate fasta-alignment from variant calls -this step concatenate all single-nucleotide variants from the VCF for each sample.
#The resulting sequence alignment file (vcf_kit_tree.o) contained a total of 215,846 sites and is the input for IQ-TREE 

vk phylo fasta pup.species.vcf


##tree generation -maximum likelihood tree with 1000 boostraps 

iqtree -s vcf_kit_tree.o -B 1000 -alrt 1000 -m GTR+ASC -T 64 -pre pup.species.nuclear -st DNA

##mt tree

#mitogenomes were first aligned using clustalX 2.1  
#the generated final_alignment_file.fasta was used to create maximumlikelihood tree with 1000 boostraps

iqtree -s final_alignment_file.fasta -B 1000 -alrt 1000 -T 64

