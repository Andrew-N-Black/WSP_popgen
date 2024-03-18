#!/bin/sh -l
#SBATCH -A fnrquail
#SBATCH -N 1
#SBATCH -n 70
#SBATCH -t 12-00:00:00
#SBATCH --job-name=admix_all.10
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
                 NGSadmix -P 64  \
                -K ${i} -minMaf 0.05 -maxiter 50000 -tol 1e-9 -tolLike50 1e-9 \
                -likes FINAL.beagle.gz \
                -outfiles  ADX/R${j}/FINAL_K${i}
                i=$[$i+1]

	done
	j=$[$j+1]
done
