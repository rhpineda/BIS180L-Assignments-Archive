# LAB: "Bash for loops AND BLAST Part I"
BLAST I Summary:
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
