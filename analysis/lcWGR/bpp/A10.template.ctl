seed =  -1

seqfile =seq_file.fa *used the mt or nuclear fasta alignment files
Imapfile = pup.Imap.txt
outfile = out.1.txt
mcmcfile = mcmc.1.txt


#speciesdelimitation = 1 0 5      * speciesdelimitation algorithm0 finetune (e)
speciesdelimitation = 1 1 2 1  * speciesdelimitation algorithm1 finetune (a m) #change per the algorithm1, algorithm0 and for different values of 𝜀 and 𝛼 and m
speciestree = 0           * fixed species tree

speciesmodelprior = 1          * 0: uniform labeled histories; 1:uniform rooted trees

species&tree = 2  MS LRSC *used the species tree generated from IQ-TREE, (MS, LR/SC) as the guide tree  
                  15 30
                 (MS,LRSC);

 
usedata = 1    * 0: no data (prior); 1:seq like
nloci = 20    * number of data sets in seqfile

cleandata = 0    * remove sites with ambiguity data (1:yes, 0:no)?

thetaprior =invgamma 3 0.003      # invgamma a b for theta
tauprior = invgamma 3 0.002    # invgamma a b for root tau
       
#thetaprior = gamma 3 2000      # Gamma(a,b) for theta
#tauprior = gamma 3 2000       # Gamma(a,b) for root tau


#finetune = 1: 5 0.001 0.001 0.0001 0.3 0.33 1.0
#At2:finetune = 1: 15 0.001 0.001 0.002 0.2 0.33 1.0  # finetune for GBtj, GBspr, theta, tau, mix, locusrate, seqerr
#finetune = 1: 25 0.001 0.001 0.0013 0.2 0.33 1.0
      finetune = 1

         print = 1 0 0 0   * MCMC samples, locusrate, heredityscalars Genetrees
        burnin = 10000
      sampfreq = 2
       nsample = 100000
#      threads = 1
