#!/bin/sh -l
#SBATCH -A fnrpredator
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 150:00:00
#SBATCH --job-name=gadma3pop
#SBATCH -e %x
#SBATCH -o %x

##########################################################################
###                          Samarth Mathur, PhD                     	###
###                        The Ohio State University                 	###
###                                                                     ###
###     Date Created: 04/27/22                  Last Modified: 04/10/23 ###
###########################################################################
###########################################################################
###                     gadma_3pop.sh              						###
###########################################################################

cd $SLURM_SUBMIT_DIR

module load use.own
module load conda-env/gadma-py3.8.5

### ## LR (ESU1) = 15 ; SC (ESU1) = 14 ; MS (ESU2) = 15 ###
## Mutation rate: 2.18e-7

 # CREATE PARAM FILE #
cd /scratch/bell/mathur20/pupfish/gadma/run2_newMu/

count=1
for i in 1 2 3
do
	for j in 1 2 3 
	do
		for k in 1 2 3
		do
		echo \
"#GADMA_newMu_Run2 model_$count structure: [$i, $j, $k]
# Pupfish  3 Pop: MS_ESU2, SC_ESU1, LR_ESU1
Output directory : /scratch/bell/mathur20/pupfish/gadma/run2_newMu/models/m$count
Input data : /scratch/bell/mathur20/pupfish/gadma/run2_newMu/sfs/MS_SC_LR.dadi.txt
Population labels : [MS_ESU2, SC_ESU1, LR_ESU1]
Projections : [14, 14, 14]
Sequence length: 963557041
Linked SNP's : True
Pts: [20, 30, 40]
Theta0: Null
Mutation rate: 2.18e-07
Time for generation : 1
Use moments or dadi : dadi
Multinom : True
Lower bounds : Null
Upper bounds : Null
Parameter identifiers: Null
Only sudden : False
Initial structure : [$i, $j, $k]
Relative parameters : False
No migrations : True
Name of local optimization : optimize_log
Number of repeats : 16
Number of processes : 16
Draw models every N iteration : 500
Units of time in drawing : thousand years
Epsilon : 0.001" > params/gadma.run$count.params 
		count=$[$count+1]
done
done
done


# Create Job file
for i in `seq 1 1 27`
do
	echo "#!/bin/sh -l
#SBATCH -A fnrpredator
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -t 14-00:00:00
#SBATCH --job-name=gadma.run$i
#SBATCH -e gadma.run$i
#SBATCH -o gadma.run$i

cd $SLURM_SUBMIT_DIR

module load use.own
module load conda-env/gadma-py3.8.5
gadma -p /scratch/bell/mathur20/pupfish/gadma/run2_newMu/params/gadma.run$i.params" \
> jobs/gadma.run$i.job
done
