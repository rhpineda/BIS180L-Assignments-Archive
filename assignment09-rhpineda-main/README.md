# LAB: "DGE from Illumina RNAseq"
## DGE from Illumina RNAseq Summary:
- BACKGROUND
  - DGE important b/c you have insight into biological processes due to a condition
  - Gene is differentially expressed when expression more than expected variance w/i a trt type
  - Multiple testing problem, so even at a a < 0.05 1500 fake DEG in human genome
    - reduce P val; few replicates/trt reducing power
  - RNAseq data requires negative binomial dist
    - Not poisson dist b/c exp mean and var not equal
  - NORMALIZATION
    - need to normalize for library size, 10 reads from one sample versus 20
    - RPKM can be used but some info is lost with a 1kbp read w/ 10 reads being treated the same as 100bp read w/ 1 read
    - genes w/ very high expression can also skew results
      - Use `TMM Normalization' to account for this
      - Use `edgeR` or `DESeq2` via `Bioconductor`
  - REGEX
    - Went over the tutorial, look at script for how to do things
- BAM TO READ COUNTS
  - Previously mapped RNAseq reads to genome
    - Have `bam/sam` files taht tell us where in the genome the reads are mapped
    - Have `gtf` files telling us where genes are
    - use `Rsubread` to figure out which reads belong to which gene
    - could also use `kallisto` to map reads to cDNA fasta files and get the coults in one step
- FINDING DEG w/ `edgeR`
  - General steps:  
   1. Load the RNAseq counts
   2. Normalize the counts
   3. QC the counts
   4. Create a df that describes the experiment
   5. Det the dispersion parameter, how over disperesed is the data??
   6. Fit a statistical model for gene expression as a fxn of exp parameters
   7. Test the significance of experimental parameteres for explaining gene expression
   8. Examine results
