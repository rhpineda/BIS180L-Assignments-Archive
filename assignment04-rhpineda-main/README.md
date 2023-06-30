# LAB: "Tidyverse Practice and MSA and Phylo Tree Construction"
## Tidyverse Practice Summary

- Go over Maloof tidyverse tutorial
- Analyze BLAST results from Assignment 2
  - do we get different hits based on the flavor of BLAST?
  - Does the length and % id cahnge based on which blast method we use?
  - how to subset unique results for sutable evolutionary analysis?
 
- Use the blastout files:
  - `megablast` WS 11 & 28
  - `blastn` WS 11
  - `tblastx`
  - `dc-megablast` WS 11
- Need to read the files and format the m so that it work's better with R
- Nicer to work with when all in a single object
- Study the new tibble and find stuff like avg alignment length and % id
- Make new tibble w/ just the longest alignment for each subject in each strategy
  - Find that avg length is longer b/c only 1 hit per subject
- Make UpSet plot using the UpSetR library to see the differences b/w the search strategies to see if the 2500 hits are the same hits for all the search strategies
- filter the results to make phylogenetic tree reconstruction. Only use one set so blastnWS11 and only complete genomes for the virus.
- need to rm multiple isolates of the same virus and keep the highest %id hits
- use `bioconducter` to get fasta seqs of listed uniq and filtered hits
- 
## MSA and Phylo Tree Construction Summary:
- Want to find the evo origins of virus, have sequences of viruses that map to patient seq.
- Use MAFFT to align
- Use 'Wasabi` to view the MAFFT output file
  - There are regions that align really wel and other gap rich regions
  - Can use other programs like glbocks to more systematically prune poorly aligned regions
  - Alternatively can use PRANK to look at a few conserved genes and use aa alignment
- found a region for tree construction and need to use R to subset seqs
  - in: whole seqs
  - out: 75% gap cutoff (mask more than 25% gaps)
- BUILD A TREE
  - use FastTree to make phylo tree
  - Want to use maximum likelihood or bayesian approach, NOT maximum parsimony or neighbor joining
- EXAMINE TREE
  - upload fasttree output to iTOL
  - observe tree to find evolutionary origins of COVID
