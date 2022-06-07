#!/bin/sh -l
#SBATCH -A fnrtowhee
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -t 12-00:00:00
#SBATCH --job-name=admix_all
#SBATCH --error=%x_%j.out
#SBATCH --output=%x_%j.out
#SBATCH --mem=100G

module purge
module load bioinfo


j="1"
while [ $j -lt 20 ]
do
	for i in {1..7}
	do
                 /depot/fnrdewoody/apps/angsd/misc/NGSadmix -P 64  \
                -K ${i} -minMaf 0.05 -maxiter 50000 -tol 1e-9 -tolLike50 1e-9 \
                -likes /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pupfish_filtered.beagle.gz \
                -outfiles  /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/adm/r${j}/filtered_k${i}
                i=$[$i+1]

	done
	j=$[$j+1]
done
