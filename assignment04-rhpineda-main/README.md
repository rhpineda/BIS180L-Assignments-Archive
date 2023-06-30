# LAB: "Tidyverse Practice"
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
# Assignment_04
Template for BIS180L Assignment_04

You will need to push your completed:

* Assignment_4_template_1.Rmd 
* Assignment_4_template_2.Rmd 
* Knitted html for both of the above files
* Notes on tidyverse tutorial.
