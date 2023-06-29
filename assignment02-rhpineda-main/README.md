# LAB: "Bash for loops, BLAST Part I, BLAST Part II"
## BLAST I Summary: (Exercises 1-8)

- Gvn: Have viral seq from infected patients, where is the origin?  
- get FASTA files of:  
    1. Genomic viral seqs "refseq"    
    2. Sequences from patient "patientseq"  
- Rough FASTA header format:  
  - Accession | Seq title | seq completeness | viral spec | origin | host  
1. Make blast db from refseq
    - `makeblastdb -in refseq.txt -dbtype nucl`
2. run blast with db refseq and query patientseq
    - `blastn -db refseqfilepath -query patientseqfilepath -evalue 1e-3 > blastout.default`
3. Change format of BLAST output  
    - normally the output is a list of hits with alignments.
    - Not very useful since our patientseq query has multiple seqs
    - More useful to have each hit summarized on a single line, use the blast+7 output.
    - `blastn  -db ../input/ncbi_virus_110119_2.txt -query ../input/patient_viral.txt -evalue 1e-3 -outfmt '7 std stitle' > blastout.default.tsv`
4. Limit the # of results
    - add `-max_target_seqs` after `blastn` to limit target seqs  

## BLAST II Summary: (Exercises 9-13)

5. Focus on best candidate
    - copy best candidate seq from evolutionary distant hit in patientseq
    - Choose the one that didn't come from a human, so no bacterial contamination
    - See how changing word size changes comutation time using bash for loop
    - Longer words = less seeds to look through = less computation and less hits
    - We have different "flavors" of blast
      - megablast (WS28) for similar seq
      - dc-megblast for interspecies comparisons
      - blastn for interspecies comparisons
      - blastn-short for sequences less than 30 nucleotides
``` 
for WS in {9..19..2} 28
  do
    blastn -max_target_seqs 10000 -db ../input/ncbi_virus_110119_2.txt -query ../input/bestcandidate.txt -evalue 1e-3 -outfmt '7 std title' -word_size $WS > output$WS.txt
    echo "blastn hits with word size $WS"
    grep "hits" output$WS.txt 
  done
 ```



