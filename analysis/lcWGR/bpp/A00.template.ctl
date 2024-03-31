seed =  -1

seqfile =seq_file.fa *used the mt or nuclear fasta alignment files
Imapfile = pup.Imap.txt
outfile = out.1.txt
mcmcfile = mcmc.1.txt

speciesdelimitation = 0   * fixed species delimitation
speciestree = 0           * fixed species tree

species&tree = 2  MS SC
                  15 15
                 (MS,SC);

 usedata = 1    * 0: no data (prior); 1:seq like
 nloci = 20    * number of data sets seq_file.fa

 cleandata = 0    * remove sites with ambiguity data (1:yes, 0:no)?

thetaprior = gamma 3 2000      # Gamma(a, b) for theta, estimate thetas
tauprior = gamma 3 2000
#thetaprior = 3 0.003 e      # Inverse-Gamma(a, b) for theta, estimate thetas
# tauprior = 3 0.002        # Inverse-Gamma(a, b) for root tau
# thetaprior = gamma 2 1000   # Gamma(a,b) for theta
# tauprior = gamma 2 1000   # Gamma(a,b) for root tau

#finetune = 1: 5 0.001 0.001 0.1 0.3 0.33 1.0
#At2:finetune = 1: 15 0.001 0.001 0.002 0.2 0.33 1.0  # finetune for GBtj, GBspr, theta, tau, mix, locusrate, seqerr
#finetune = 1: 25 0.001 0.001 0.0013 0.2 0.33 1.0
       finetune = 1 * 

#print = 1 0 0 0   * MCMC samples, locusrate, heredityscalars Genetrees
 burnin = 10000
 sampfreq = 2
 nsample = 100000
 #threads = 2
