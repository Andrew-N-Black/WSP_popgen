    This python script will parse the output ROH file from BCFtools/roh in step5 script
    and calculate ROH and F(ROH) of length >= 100kb and >= 1mb

    usage:
    #Set the species name in this python script
        genus-species = "Panthera-tigris-altaica"
        accession = "GCF_000464555.1"
    #Note the quotation marks before and after the arguments

    #Then in your cluster directory, type in:
    python ROHparser.py

    Jong Yoon Jeon     June 19 2022

================================================================================================="""
import sys

#Set the species name and accession number
genus_species = sys.argv[1]
print("The species names is " + genus_species)

"""-------------------------------------------------------------------------------------------------
Do not edit below this line
-------------------------------------------------------------------------------------------------"""
#Set working directory and designate input file
path_to_directory = "/scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/"

#Estimate ROH based on "PL"
roh_input = path_to_directory  + genus_species 
roh_output = path_to_directory + genus_species + "_PL.txt"
ref_index_file = "/scratch/bell/blackan/PUPFISH/C.tularosa/assembly/ncbi/Cyprinodon-tularosa/GCF_016077235.1_ref/ref.fa.fai"

#Calculate the length of the reference genome
#If we use autosomal genome length to calculate ROH later, len_ref should be changed to len_autosome
len_ref = 0
ref_fh = open(ref_index_file, 'r')
for line in ref_fh:
    line = line.rstrip("\n")
    field = line.split("\t")
    len_ref += float(field[1])
print("The length of this reference genome is " + str(len_ref))

#Check the number of samples in ROH calculation
#sam_file = path_to_directory + "/theta/bam.filelist"
#sam_fh = open(sam_file, 'r')
num_sam = 15
print("The number of samples is " + str(num_sam))

#Open input and output files
input = open(roh_input, 'r')
output = open(roh_output, 'w')

#Set counters
num_roh_100kb = 0
num_roh_1mb = 0
len_roh_100kb = 0
len_roh_1mb = 0

#Count the number of roh and sum up the length of roh line by line
print("ROH file parsing started")
for line in input:
    if line.startswith("RG"):
        line = line.rstrip("\n")
        field = line.split("\t")
        if float(field[7]) >= 30: #Pick only regions of the mean phred score >= 30
            if float(field[5]) > 100000 and float(field[5]) <= 1000000: #ROH > 100kb and <= 1mb
                num_roh_100kb += 1
                len_roh_100kb += float(field[5])
            elif float(field[5]) > 1000000: #ROH > 1mb
                num_roh_1mb += 1
                len_roh_1mb += float(field[5])
num_roh_100kb = num_roh_100kb/num_sam
num_roh_1mb = num_roh_1mb/num_sam
len_roh_100kb = len_roh_100kb/num_sam
len_roh_1mb = len_roh_1mb/num_sam

#Total number and length of ROH, F(ROH)
num_roh_tot = num_roh_100kb + num_roh_1mb
len_roh_tot = len_roh_100kb + len_roh_1mb
F_roh_1mb = len_roh_1mb/len_ref
F_roh_tot = len_roh_tot/len_ref

#Print the result on screen
print("Based on Likelihoods:" \
      + "Number of ROH > 100kb and <= 1mb: " + str(num_roh_100kb) + "\tLength of ROH > 100kb and <= 1mb: " + str(len_roh_100kb) \
      + "\nNumber of ROH > 1mb: " + str(num_roh_1mb) + "\tLength of ROH > 1mb: " + str(len_roh_1mb) \
      + "\nNumber of ROH in total: " + str(num_roh_tot) + "\tLength of ROH in total: " + str(len_roh_tot) \
      + "\nF(ROH) > 100kb: " + str(F_roh_tot) + "\tF(ROH) > 1mb: " + str(F_roh_1mb))

#Save the result in an output file
output.write("Number of ROH > 100kb and <= 1mb: " + str(num_roh_100kb) + "\tLength of ROH > 100kb and <= 1mb: " + str(len_roh_100kb) \
             + "\nNumber of ROH > 1mb: " + str(num_roh_1mb) + "\tLength of ROH > 1mb: " + str(len_roh_1mb) \
             + "\nNumber of ROH in total: " + str(num_roh_tot) + "\tLength of ROH in total: " + str(len_roh_tot) \
             + "\nF(ROH) > 100kb: " + str(F_roh_tot) + "\tF(ROH) > 1mb: " + str(F_roh_1mb))
output.close()
input.close()
exit(0)
