# LAB: "Rice SNPs"
## Rice SNPs Summary:
- Download Rice SNPs data
- PCA/ MDS PLOT
- dataset a bit too large for easy use so new tibble using just 10k SNPs using `sample()`
- need to convert gt data to numeric form
  - convert NA's to average gt of SNP
  - Better way is to use linkage data and neighboring SNPs
  - Plot the PCs, find that most of the variation can be seen in just 3 PCs
- ADDING PHENO
- download new dataset w pheno info for each SNPs
- join SNP data and pheno data
- make scatter plot of PC1 vs PC2 and color by characteristics, see some clustering based on characteristic
- ASSIGN POP W/ `FASTSTRUCTURE`
- gt file
  - convert gt so that `FastStructure` works w/ it
- `.fam` file
  - fam file describes ind in the study
-  `.bim` file
  - provides info on the alleles
- Run and load FastStrucute
- Compare `fastStructure` and the PCA plot
- faststructure output looks like the one from comp genomics w/ the different populations admixture
- 
