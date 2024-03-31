#SBATCH --job-name=align-inter
#SBATCH -A highmem
#SBATCH -t 1-00:00:00 
#SBATCH -N 1 
#SBATCH -n 128
#SBATCH --mem=500G

ml bioinfo
ml bwa
ml bcftools/1.5
ml samtools/1.5
ml BBMap/37.93
module load popoolation2/1201
module load fftw/3.3.8
ml R/3.4.2
ml samblaster/0.1.24
ml fastqc/0.11.7
ml picard-tools/2.18.2


#Below is for only ok.bed alignments
./PPalign_ok.sh align_wsp_ok.config
./PPanalyze.sh analyze_OKAY.config

#Below is for only genic alignments
./PPalign_genes.sh align_genes.config
./PPanalyze.sh analyze_GENES.config

#Intergeneic only
./PPalign_inter.sh align_inter.config
 ./PPanalyze.sh analyze_INTER.config

#Define Populations order is defined as
#head pop*
#==> pop_1.txt <==
#SC-p_R1_val_1
#==> pop_2.txt <==
#LR-p_R1_val_1
#==> pop_3.txt <==
#MS-p_R1_val_1

#Parse fst files
cut -f 6  pupish_analyze_raw.fst | cut -c 5-20 > SC.LR.fst.txt
cut -f 7  pupish_analyze_raw.fst | cut -c 5-20 > SC.MS.fst.txt
cut -f 8  pupish_analyze_raw.fst  | cut -c 5-20 > LR.MS.fst.txt

#Get global average for each pairwise compairison
awk '{ sum += $1 } END { print(sum / NR) }'  LR.MS.fstS.txt
awk '{ sum += $1 } END { print(sum / NR) }'  SC.MS.fstS.txt
awk '{ sum += $1 } END { print(sum / NR) }'  SC.LR.fstS.txt
   

