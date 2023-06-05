 #!/bin/bash
#SBATCH -A fnrchook
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 14-00:00:00
#SBATCH --error=snpN.err
#SBATCH --output=snpN.out
#SBATCH --job-name=snpEff-all

module load bioinfo
module load samtools
module load bedops
module load vcftools
module use biocontainers
module load snpEff/4.3
module load bedops

#Call variants using bcftools
bcftools mpileup -f /scratch/bell/blackan/PUPFISH/ref/NCBI/ref_100kb.fa \
 -b bamlist | bcftools call -mv -Ov -o WSP.vcf
 
#Build custom db
snpEff build -c snpEff.config -gff3 -v WSP &> build.logfile.txt

#effect prediction
snpEff ann -stats -c snpEff.config \
-no-downstream -no-intergenic -no-intron -no-upstream -no-utr -v \
WSP WSP.vcf > WSP_eff.vcf


# vcf to bed
vcf2bed < WSP_eff.vcf > WSP_eff.bed 


# Remove sites with warnings

grep "WARNING" WSP_eff.vcf | sed -e '1d' | cut -f1,2 > bad_sites_all.txt


vcftools --vcf WSP_eff.vcf --recode --recode-INFO-all \
--stdout --exclude-positions bad_sites_all.txt \
> all_good_snps.vcf


# Get high, moderate, low, and no-impact variants

grep "HIGH" all_good_snps.vcf | sed -e '1d' | cut -f1,2 > all_high_sites.txt

grep "LOW" all_good_snps.vcf | sed -e '1d' | cut -f1,2 > all_low_sites.txt

grep "MODERATE" all_good_snps.vcf | sed -e '1d' | cut -f1,2 > all_mod_sites.txt

grep "MODIFIER" all_good_snps.vcf | sed -e '1d' | cut -f1,2 > all_nc_sites.txt

# Population Allele frequncies #
# Get frequency
#bcftools concat -o all.bcf -O u  *bcf
for i in high low mod nc
do
	vcftools --vcf all_good_snps.vcf --recode --recode-INFO-all \
	--stdout --positions all_${i}_sites.txt \
	> all_${i}_snps.vcf

done

for i in high low mod nc
do
	vcftools --vcf all_${i}_snps.vcf --freq \
	--out all_${i}_freq

done

# Get MAF

for i in high low mod nc
do
	sed -e '1d' all_${i}_freq.frq | cut -f6 \
	> all_${i}_minor.freq
done

cut -f 10- all_nc_snps.vcf > all_nc.geno
cut -f 10- all_high_snps.vcf > all_high.gen
cut -f 10- all_mod_snps.vcf > all_mod.geno
cut -f 10- all_low_snps.vcf > all_low.geno

## FOR ESTIMATING GENETIC LOAD FOR EACH INDIIVUDAL ##
# To get the allele counts from the genotypes #
# 0/0 = 0 allele ; 0/1 = 1 allele; 1/1/ = 2 alleles
mkdir ind_geno
for  ((i=1;i<=51;i++)); 
do


	cut -f${i} all_high.geno | cut -f1 -d ':' > ind_geno/all_ind${i}_high.geno

	cut -f${i} all_mod.geno | cut -f1 -d ':' > ind_geno/all_ind${i}_moderate.geno

	cut -f${i} all_low.geno | cut -f1 -d ':' > ind_geno/all_ind${i}_low.geno

	cut -f${i} all_nc.geno | cut -f1 -d ':' > ind_geno/all_ind${i}_modifier.geno
done

cd ind_geno
pr -mts' ' all_*_high.geno > all_high_allind_allele
 
 
 #Move to the ALL directory
 /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/LOAD/ALL
 
 #Concatenate all high sites for the three populations
 cat ../MS/ms_high_sites.txt ../SC/sc_high_sites.txt ../LR/lr_high_sites.txt > all.high.sites.txt
 
 #Extract only these sites
 vcftools --vcf all.vcf --positions all.high.sites.txt --recode --keep-INFO-all --out all.high.sites
 
 #To print out each SNP to evaluate deleterious:
grep "NW_024037791.1$(printf '\t')75071" all.high.sites.recode.vcf | cut -f 10-  | tr "," "\t" | awk '{ for (i=1;i<=NF;i+=7) print $i }' | cut -d ":" -f1

