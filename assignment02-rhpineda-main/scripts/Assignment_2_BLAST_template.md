# Template for Assignment_2 BLAST Lab

__Name:__ Ricardo Pineda IV

__Student ID:__ 917486212

__Where applicable (or when in doubt) provide the code you used to answer the questions__

__Exercise 1__: What is the [sequence format](https://www.genomatix.de/online_help/help/sequence_formats.html) for these sequences?  Do the files contain RNA or DNA sequences?  How do you know?

This file looks likes a FASTA file. The file contains DNA sequences because there are T's instead of U's.

__Exercise 2__: For the refseq file, the header line contains a number of fields, each separated by a "|".  

_Exercise 2a_: Use `zgrep` and `more` to display the first set of header lines (without printing the sequences themselves).  What command did you use?

`zgrep ">" ncbi_virus_110119_2.txt | zmore | head -5`

_Exercise 2b_: For the first entry in the refseq file (starts with `>MH781015`), figure out what each item in the header is. List each field and what you think it is.   

  + `>MH781015`  -> Accession number
  + `Dengue virus 2 isolate G3AE` ->  sequence title
  + `complete genome` -> sequence completeness
  + `Dengue virus` -> viral species
  + `Mexico` -> Country where the virus was isolated
  + `Aedes aegypti` -> mystery/  host species
  
__Exercise 3__: How many of the viruses come from a domesticated cat (_Felis catus_) host?  How many come from a human host?  How many were isolated in the United States? Show the commands used to answer these questions.

+ Felis catus -> `zgrep -c "|Felis catus" ncbi_virus_110119_2.txt`
    + count = `276`
+ Human -> `zgrep -c "|Homo sapiens" ncbi_virus_110119_2.txt`  
    + count = `29911`
+ In the US -> `zgrep -c  "|USA|" ncbi_virus_110119_2.txt`  
    + count = `19893`
    
__Exercise 4__: Create a simple (markdown formatted) table with the following information for the refseq and patientseq files:
1. Size of the file (in kilobytes, megabytes, or gigabytes.  Indicate your units).
2. Number of sequences in the file.
3. Total number of basepairs or amino acids in the file 
4. Average sequence length.

|  Sequence  | Size  | #Seq in File | Total # of bp in file | Average sequence length |
|:----------:|-------|:------------:|-----------------------|-------------------------|
|   Refseq   | 1.5GB |    122200    | 1519312049            | 12432                   |
| Patientseq | 171KB |       8      | 568168                | 71021                   |

+ size `ls -lFh`
+ #seq in refseq `zgrep -c  ">" ncbi_virus_110119_2.txt` 
+ #seq in patientseq `zgrep -c  ">" patient_viral.txt.gz`
+ bp: `grep -v ">" ncbi_virus_110119_2.txt | less | wc - wm` AND `zgrep -v ">" patient_viral.txt.gz | less | wc -wm`
  + have to account for `\n` and use #lines for that so `-wm`
  + REFERENCE `python3` -> `1538366953 - 19054904` = `1519312049`
  + PATIENT `python3` -> `575274 - 7106` = `568168`
+ Avg seq length `1538366953/122200`
+ Avg seq length `575274/8`

__Exercise 5:__  How long did it take BLAST to run?

+ 35.201 seconds

+ Hepatitis B

__Exercise 7:__ Run a new BLAST but limit the results to 2 subjects per query sequence.  (Show your code).  Which patient sequence do you think comes from the virus that causes the respiratory disease? If you are unsure, do some literature/web searches on the different viruses.

`time blastn -max_target_seqs 2 -db ../input/ncbi_virus_110119_2.txt -query ../input/patient_viral.txt -evalue 1e-3 -outfmt '7 stitle evalue pident length'  > blastout.default`

+ I think it comes from patient H because it's a SARS like virus so it should result in some flu-like symptoms.

__Exercise 8:__ Consider the host species listed for the hits.  Remembering that our samples came from a human patient, which hosts are most evolutionarily distant? Could the viruses generating these hits still have come from the patient sample or does this represent contamination from another source? (Again some web or literature searches will be helpful).

+ There were nonhuman hits that were included like bats and Streptococcus. The bacteria is the most evolutionary distant and could come from a human while a bat could come from another source.


__Exercise 9:__ Predict how changing the word size will affect search sensitivity and speed.  Explain your reasoning.  

+ I predict that increasing the word size will decrease sensitive and make the overall computation quicker. A larger word size means that only seeds with high alignments so there will be fewer overall hits and only having high scoring hits. Since there are less seeds to look through, then it means that less computation is required.

__Exercise 10:__ Provide the code used and then record the time in a markdown table
```
for WS in {9..19..2} 28
  do
    echo "Starting blastn with word size $WS"
    time blastn -max_target_seqs 10000 -db ../input/ncbi_virus_110119_2.txt -query ../input/bestcandidate.txt -evalue 1e-3 -outfmt '7 std title' -word_size $WS > blastout.WS$WS.tsv
  done
```

|  WS  | 9        |     11    | 13        | 15       | 17       | 19       | 28       |
|:----:|----------|:---------:|-----------|----------|----------|----------|----------|
| Time | 1m15.28s | 0m18.568s | 0m11.940s | 0m6.202s | 0m4.943s | 0m4.382s | 0m2.532s |
|Unique hits | 2506|2506|2503|2485|2419|1790|327|


__Exercise 11:__
_Exercise 11a:_ Modify the code above so that it counts the number of unique hits.

Code to find unique hits in word size 9 file

```
cut -f 2 blastout.WS9.tsv | sort | uniq | grep -vc "#"
```

_Exercise 11b:_ Use a for loop that builds on the command from 11a to count the number of unique hits in each file. Add these results to the table in Exercise 10.  Did word size affect time and sensitivity in the direction you predicted from Exercise 9?  (FYI a word size of 7 takes 16 minutes to run, but I decided to spare you that pain).  If you didn't already do this above, explain why word size is affecting the results in the way that it does.

```
for WS in {9..19..2} 28
  do
   echo unique hits for $WS
   cut -f 2 blastout.WS$WS.tsv | sort | uniq | grep -vc "#" 
  done
```

The word size affected time and sensitivity as predicted. Longer words = less seeds to look through = less computation and less hits

__Exercise 12:__ Repeat the `blastn` searches but now comparing `megablast`, `dc-megablast`, and `blastn`.  Use a word_size of 11 but keep the evalue limit of 1e-3.  Add the time and number of (unique) hits to your table.  Comment on the differences.  For these sequences is word_size or algorithm (task) more important for the number of sequences found?
```
for task in megablast dc-megablast blastn
  do
    echo --------------------
    echo $task time
    time blastn -max_target_seqs 10000 -db ../input/ncbi_virus_110119_2.txt -query ../input/bestcandidate.txt -evalue 1e-3 -outfmt '7 std title' -word_size 11 -task $task > blastout.output$task.tsv
    echo $task unique hits
    cut -f 2 blastout.output$task.tsv | sort | uniq | grep -vc "#" 
  done
```
The number of hits were roughly the same across all of the algorithms but the time it took varied much more. word_size is more important. Given the same word_size, but different algorithm, the number of hits is about the same while given the same algorithm, but different word_size, the number of hits is much different like in exercise 10. 

|   algorithm  | Time    |Unique Hits
|:------------:|---------|:---------:|
|   megablast  | 16.307s | 2506       |
| dc-megablast | 50.442s | 2501       |
| blastn       | 33.407s | 2501       |
| tblastx      |3m54.957s| 2695|

**MV** -0.5 blastn hits should be 2509

__Exercise 13:__ How many unique sequences were found by tblastx?  Add the tblastx result to your table and comment here.

There was 2695 unique hits and I also tried using all 4 threads and it wasn't as fast as I though it would be, only 43s faster.

```
time tblastx -db ../input/ncbi_virus_110119_2.txt -query ../input/bestcandidate.txt -evalue 1e-3 -outfmt '7 std stitle' -max_target_seqs 10000 -num_threads 3 > blastout.tblastx.tsv

cut -f 2 blastout.tblastx.tsv | sort | uniq | grep -vc "#" 
```
