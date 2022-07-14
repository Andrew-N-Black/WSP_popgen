#!/bin/sh -l
#SBATCH -A fnrchook
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -t 12-00:00:00
#SBATCH --job-name=admix_parse.05
#SBATCH --error=%x_%j.out
#SBATCH --output=%x_%j.out
#SBATCH --mem=100G

module purge
module load bioinfo


/depot/fnrdewoody/apps/angsd/misc/NGSadmix -P 64  \
                -K 1 -minMaf 0.05 -maxiter 50000 -tol 1e-9 -tolLike50 1e-9 \
                -likes /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/FINAL.beagle.gz \
                -outfiles  /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/ADX/FINAL_K1
          

/depot/fnrdewoody/apps/angsd/misc/NGSadmix -P 64  \
                -K 2 -minMaf 0.05 -maxiter 50000 -tol 1e-9 -tolLike50 1e-9 \
                -likes /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/FINAL.beagle.gz \
                -outfiles  /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/ADX/FINAL_K2  

/depot/fnrdewoody/apps/angsd/misc/NGSadmix -P 64  \
                -K 3 -minMaf 0.05 -maxiter 50000 -tol 1e-9 -tolLike50 1e-9 \
                -likes /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/FINAL.beagle.gz \
                -outfiles  /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/ADX/FINAL_K3  

/depot/fnrdewoody/apps/angsd/misc/NGSadmix -P 64  \
                -K 4 -minMaf 0.05 -maxiter 50000 -tol 1e-9 -tolLike50 1e-9 \
                -likes /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/FINAL.beagle.gz \
                -outfiles  /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/ADX/FINAL_K4  

/depot/fnrdewoody/apps/angsd/misc/NGSadmix -P 64  \
                -K 5 -minMaf 0.05 -maxiter 50000 -tol 1e-9 -tolLike50 1e-9 \
                -likes /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/FINAL.beagle.gz \
                -outfiles  /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/ADX/FINAL_K5  
		
#DONE
