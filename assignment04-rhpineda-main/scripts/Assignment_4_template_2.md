---
title: "Assignment 4, part 2"
output: 
  html_document: 
    keep_md: yes
    df_print: paged
---

__Name:__ Ricardo Pineda

__Student ID:__ 917486212



```r
library(tidyverse)
```

```
## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
## ✔ dplyr     1.1.0     ✔ readr     2.1.4
## ✔ forcats   1.0.0     ✔ stringr   1.5.0
## ✔ ggplot2   3.4.1     ✔ tibble    3.2.1
## ✔ lubridate 1.9.2     ✔ tidyr     1.3.0
## ✔ purrr     1.0.1     
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ℹ Use the ]8;;http://conflicted.r-lib.org/conflicted package]8;; to force all conflicts to become errors
```

```r
library(Biostrings)
```

```
## Loading required package: BiocGenerics
## 
## Attaching package: 'BiocGenerics'
## 
## The following objects are masked from 'package:lubridate':
## 
##     intersect, setdiff, union
## 
## The following objects are masked from 'package:dplyr':
## 
##     combine, intersect, setdiff, union
## 
## The following objects are masked from 'package:stats':
## 
##     IQR, mad, sd, var, xtabs
## 
## The following objects are masked from 'package:base':
## 
##     anyDuplicated, aperm, append, as.data.frame, basename, cbind,
##     colnames, dirname, do.call, duplicated, eval, evalq, Filter, Find,
##     get, grep, grepl, intersect, is.unsorted, lapply, Map, mapply,
##     match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     Position, rank, rbind, Reduce, rownames, sapply, setdiff, sort,
##     table, tapply, union, unique, unsplit, which.max, which.min
## 
## Loading required package: S4Vectors
## Loading required package: stats4
## 
## Attaching package: 'S4Vectors'
## 
## The following objects are masked from 'package:lubridate':
## 
##     second, second<-
## 
## The following objects are masked from 'package:dplyr':
## 
##     first, rename
## 
## The following object is masked from 'package:tidyr':
## 
##     expand
## 
## The following objects are masked from 'package:base':
## 
##     expand.grid, I, unname
## 
## Loading required package: IRanges
## 
## Attaching package: 'IRanges'
## 
## The following object is masked from 'package:lubridate':
## 
##     %within%
## 
## The following objects are masked from 'package:dplyr':
## 
##     collapse, desc, slice
## 
## The following object is masked from 'package:purrr':
## 
##     reduce
## 
## Loading required package: XVector
## 
## Attaching package: 'XVector'
## 
## The following object is masked from 'package:purrr':
## 
##     compact
## 
## Loading required package: GenomeInfoDb
## 
## Attaching package: 'Biostrings'
## 
## The following object is masked from 'package:base':
## 
##     strsplit
```

**Exercise 16:**
For each of the the following regions classify them as well- or poorly aligned, or uncertain/intermediate and explain your reasoning:

* 39.1K to 39.4K
  - check again This regions is poorly aligned because of the amount of gaps present in the alignment. There are also chunks of aligned sequences that have different nucleotides.
* 31.6K to 31.9K
  - This is poorly aligned as there are plenty of gaps with only a short stretches of sequences that are aligned.
* 24.7K to 24.9K
 - This is a well aligned regions as there are few gaps and few mismatches.
* 14.5K to 14.7K
 - This is an intermediate level of alignment as there are stretches of sequence with few mismatches but is interspersed with noticeable gaps

**Exercise 17:** 

```r
inpath <- "../output/mafft_maxiter100_195v2_op.5.fa"
outpath <- "../output/mafft_maxiter100_195v2_op.5_trimmed_75pct.fa"
alignment <- readDNAMultipleAlignment(inpath)
alignment
```

```
## DNAMultipleAlignment with 196 rows and 49784 columns
##        aln                                                  names               
##   [1] -------------------------...------------------------ Seq_H
##   [2] ------------ATA-----TTAGG...------------------------ MG772933 |Bat SAR...
##   [3] ------------ATA-----TTAGG...------------------------ MG772934 |Bat SAR...
##   [4] ------------ATA-----TTAGG...------------------------ KU182964 |Bat cor...
##   [5] --GGGG---GGGATA-----TTAGG...------------------------ KY938558 |Bat cor...
##   [6] -------------------------...------------------------ KY770860 |Bat cor...
##   [7] -------------------------...------------------------ JX993987 |Bat cor...
##   [8] -------------------------...------------------------ KY770859 |Bat cor...
##   [9] ------------------------G...------------------------ KY770858 |Bat cor...
##   ... ...
## [188] -------------------------...------------------------ HM034837 |Human c...
## [189] -------------------------...------------------------ MH940245 |Human c...
## [190] -------------------------...------------------------ KY674921 |Human c...
## [191] -----G----AGTTT--------GA...------------------------ MK167038 |Human c...
## [192] -----------GAT--------AAA...------------------------ KM349743 |Betacor...
## [193] -----------GAT--------AAA...------------------------ KM349742 |Betacor...
## [194] -----------GAT--------AAA...------------------------ KM349744 |Betacor...
## [195] -----------GAT--------AAA...------------------------ NC_026011 |Betaco...
## [196] -------C---TATC-----TACGG...------------------------ MH938449 |Alphaco...
```

```r
#trim emds
alignment <- DNAMultipleAlignment(alignment,start=1000,end=48449)
#mark >25% gap
alignment <- maskGaps(alignment, min.fraction=0.25, min.block.width=1)
#Proportion masked, row and columns
maskedratio(alignment)
```

```
## [1] 0.0000000 0.5212013
```

```r
#Change to stringset?
alignment <- alignment %>% as("DNAStringSet") 

#Clean names
newnames <- names(alignment) %>% 
  tibble(name=.) %>%
  mutate(name=str_replace_all(name," ","_")) %>% #replace " " with "_" because some programs truncate name at " "
  separate(name, 
           into=c("acc", "isolate", "complete", "name", "country", "host"),
           sep="_?\\|_?") %>%
  mutate(name=str_replace(name, "Middle_East_respiratory_syndrome-related","MERS"),   # abbreviate
         name=str_replace(name, "Severe_acute_respiratory_syndrome-related", "SARS"), # abbreviate
         newname=paste(acc,name,country,host,sep="|")) %>% # select columns for newname
  pull(newname) #return newname
```

```
## Warning: Expected 6 pieces. Missing pieces filled with `NA` in 1 rows [1].
```

```r
names(alignment) <- newnames
alignment %>% writeXStringSet(outpath)
```

__A:__ What is the sister taxon to Seq_H? What is the host for the virus in this group (provide the Latin and common names)  
_hint: if you are having trouble finding Seq H in the tree, search for it using the (Aa) magnifying glass_
- Sister Taxon ID's
  - MG772934|SARS_coronavirus|China|Rhinolophus_sinicus
  - MG772933|SARS_coronavirus|China|Rhinolophus_sinicus

- Host
  - Latin: *Rhinolophus sinicus*
  - Common Name: Chinese rufous horseshoe bat

__B:__ Consider Seq_H plus its sister taxa as defining one taxonomic group with three members. Look at the sister taxon of this group (it is a large group). What is a general description for the viruses in this sister group? List at least 3 different hosts found in this group. Give Latin and common names (if there is a common name).

- The sister taxa are all generally coronaviruses, mostly SARS coronavirus or bat coronavirus.

- Hosts
  1. Least horseshoe bat (*Rhinolophus pusillus*) | From JX993987
  2. Greater horseshoe bat (*Rhinolophus ferrumequinum*) | From KY770860
  3. Wrinked-lipped free-tailed bat (*Chaerephon plicatus*) | From JX993988

__C:__ Now consider Seq_H plus all of the other taxa used in question __B__ as one taxonomic group.  The sister to this group has two members.  What are the hosts of this group.

- Sister ID
  - KY352407
  - NC_014470
  - GU190215

- Host
  - Horseshoe bats *Rhinolophus* | From KY352407
  - Blasius' horseshoe bat *Rhinolophus blasii* | From NC_014470 and GU190215
  
__D:__ Given your above findings, what do you think the host of the most recent common ancestor to the viruses in parts A and B was? (You can answer giving the common name for the general type of organism, e.g. rat, mouse, bat, ape, etc. you do not need to give a precise species).

- I believe that the most likely common ancestor to the viruses in part A and B were bats because using maximum parsimony that would require the least amount of evolutionary changes.

__E:__ Do you think that Seq_H evolved from a virus with a human host?  Why or why not?  If not, what did it evolve from? 

- I believe that Seq_H evolved from a virus from a bat. This is because the sister taxa also have bats as the host species. Seq_H evolving with a human host requires an additional evolutionary change.
