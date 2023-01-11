#!/bin/sh -l
#SBATCH -A fnrdewoody
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 150:00:00
#SBATCH --job-name=gadma_CI
#SBATCH -e %x
#SBATCH -o %x

##########################################################################
###                          Samarth Mathur, PhD                     	###
###                        The Ohio State University                 	###
###                                                                     ###
###     Date Created: 12/23/22                  Last Modified: 01/05/23 ###
###########################################################################
###########################################################################
###                     gadma_CI.sh              						###
###########################################################################

cd $SLURM_SUBMIT_DIR

module load use.own
module load conda-env/gadma-py3.8.5

cd /scratch/bell/mathur20/pupfish/gadma/3pop_boot/

gadma-run_ls_on_boot_data -j 10 \
-b boot_sfs/ \
-d best_logLL_model_dadi_code.py \
-o results/ \

gadma-run_ls_on_boot_data results/result_table.pkl
