# Assignment_8_1.md

Student Name: Ricardo Pineda
Student ID: 917486212

Insert answers to Illumina exercises 1 - 7 here.  Submit this .md by git. This file does not need to be knit but should include code blocks where requested.


__Notes__
GOAL:  Illumina read mapping and QC  
- phred score is quality  
Find a SNP b/w R500 and IMB211  
Find genes that are differentially expressed  

Check FASTQ quality (short read data)  
	- multiqc  
Trim read to keep good reads  
	- trimmomatic
	- alias'd trimmomatic to open easier
	- source bashrc
Split by barcode  
	- auto_barcode  
# map to ref  
	- bowtie2



__Exercise 1:__  

__a__ What is the read length? (can you do this without manually counting?)  
	- 100 (I just copied and pasted the seq into RStudio and looked at bottom right to see how long the seq is)
__b__ What is the machine name?  
	- HWI-ST611_0203
__c__ How may reads are in this file? (show how you figured this out)
	- 1000000 I did `zless GH.lane64.fastq.gz | wc -l` divided by 4 since each read's information takes up 4 lines.    
__d__ Are the quality scores Phred+33 or Phred+64? (how did you figure this out?)
	- Phred+64, there were few uppercase letters for the phred scores and they were primarily shown as lowercase letters.  
	
__Exercise 2:__ Compare your fastq results to the examples of [good sequence](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/good_sequence_short_fastqc.html) and [bad sequence](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/bad_sequence_fastqc.html) on the fastqc website.  Comment on any FastQC items that have an "X" by them in the report.  What might have caused these issues? (hint: think about barcodes). 

	- Per base seq quality
		- Illumina reads tend to fall off in quality toward the ends of reads.
	- Per base seq content
		- There might be an over representation of T at position 6 because position 1-5 is the is the adapter and the rest of the sequence is the read so maybe the ligation reaction requires a T at this position.


__Exercise 3:__

__Modify__ and then run this command

    trimmomatic SE -phred64 GH.lane67.fastq.gz GH.lane67.trimmed.fastq SLIDINGWINDOW:5:15 MINLEN:70

__a__ What trimmomatic command did you use?  
- `trimmomatic SE -phred64 GH.lane67.fastq.gz GH.lane67.trimmed.fastq SLIDINGWINDOW:4:20 MINLEN:50`
__b__ How many reads were removed by trimming?  
- 42107
__c__ Trimmomatic has the option to remove Illumina adapters.  Why did we not do that here?  
- we want to keep the barcodes so we can then seperate the reads by sample later on.

**MV** -0.12 adapters are already removed

__d__ rerun FastQC on the trimmed sequences.  Which issues did the trimming fix?  
- it fixed the per base sequence quality issue. 

(If you want a good challenge you can try to figure out how many reads were trimmed...)

__Excercise 4:__ Look at the [README for auto_barcode](https://github.com/mfcovington/auto_barcode) and figure out how to run it to split your samples.  Specify that the split fastq files are placed in the directory `split_fq`.  __Use the perl (.pl) version of the script__

__a__ what command did you use?  

In scripts wd...

```
barcode_split_trim.pl \
  --id demo \
  --barcode /home/exouser/Assignments/assignment08-rhpineda/input/Brapa_fastq/barcode_key_GH.txt \
  --list \
  --outdir /home/exouser/Assignments/assignment08-rhpineda/input/Brapa_fastq/split_fq \
  /home/exouser/Assignments/assignment08-rhpineda/input/Brapa_fastq/GH.lane67.trimmed.fastq
```

__b__ what percentage of reads did not match a barcode?  What are possible explanations?

- 6.1%  
	- There could have been some mismatch during sequencing so the read has the a wrong base in the adapter region
	- There could have been barcodes not added to the list

__Exercise 5:__  
__a:__ What library has the worst quality based on the `Sequence Quality Histograms`?  Is it bad enough to concern you?
	- R500_NPD_3_INTERNODE
		- Not bad enough to be a concern, still has a high Phred score
		
**MV** -0.25 incorrect library
		
__b:__ Click on each of the other tests.  Which three libraries are most problematic?  In which tests?  
	- In both overrepresented sequences and per sequence GC content
		- R500_NPD_1_LEAF
		- R500_NPD_2_LEAF
		- R500_NPD_3_LEAF
__c:__ Do you think the libraries should be removed from downstream analysis?  
	- Yeah, it's probably a good idea to get rid of bad data so it won't reduce quity of our outputs.
__Exercise 6:__ using a bash for loop run tophat on all of the fastq files.  Show your code here.

[DO IN split wd]
```
fastqs=$(ls *.fq)
for file in $fastqs
  do
   $(tophat --phred64-quals --o "../../../output/${file}" -p 4 ../../Brapa_reference/BrapaV1.5_chrom_only   $file )
  done
```

__EXERCISE 7, 8, 9, AND 10 WILL BE PART OF THURSDAY'S LAB__

__Exercise 7__: Take a look at the `align_summary.txt` file.  
__a__  What percentage of reads mapped to the reference?  
- 81.1%  
__b__  Give 2 reasons why reads might not map to the reference.
- The reference could be incomplete or the read could be of poor quality.  

__Exercise 8__:  
Can you distinguish likely SNPs from sequencing/alignment errors?  How?  
- Yes, you need to see if there's consistently variation in a position because if there's some one-off mismatch, then that might just be some misread in igv I should discount mismatches that only 1 read has at a position. I should also rely on reads that have good quality over those with low quality to tell us if there is SNP or not. Lastly we need enough coverage for a position to tell us if there's a SNP or not so igv I'm looking for a band of color.

__Exercise 9__:
View each gene listed below in IGV. (You can type the gene ID into the IGV search bar).  For each gene, does the computationaly predicted annotation (blue bars) appear to be correct or incorrect given our RNA-seq data? If incorrect, describe what is wrong.  
__a__ Bra001706  
	- Incorrect, the prediction is missing an exon that can be seen with a lot of our reads.
__b__ Bra001700  
	- Appears to be correct  
	
**MV** -0.5 last exon is longer than the annotation
	
__c__ Bra001702  
	- Incorrect. In the R500 cultivar, the predicted long exon of Bra001702 appears to be two separate exons in the reads. In the IMB211 cultivar, the small exon of Bra001702 appears to be much larger in the reads.
__d__ Bra012917
	- Incorrect. In both cultivars the predicted large exon of Bra012917 on the right does not map to anything on our reads. There is also exons that appear in the reads but noot the annotated version.

__Exercise 10__:
Comment on the trust-worthiness of computational annotation.  
	- Computational annotation is pretty good at getting at least some of exons present in our reads but should not be completely relied on as it often does not get the whole answer.

