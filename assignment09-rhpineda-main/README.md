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
      - Use `TMM Normalization' 
