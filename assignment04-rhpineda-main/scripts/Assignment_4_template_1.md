---
title: "Assignment 4, part 1"
output: 
  html_document:
    keep_md: yes
    df_print: paged
---

__Name:__ Ricardo Pineda IV

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
library(UpSetR)
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

```r
headers <- readLines("../input/blastout.mega.WS11.tsv.gz", n = 4)
headers <- headers[4]
headers
```

```
## [1] "# Fields: query acc.ver, subject acc.ver, % identity, alignment length, mismatches, gap opens, q. start, q. end, s. start, s. end, evalue, bit score, subject title"
```

```r
headers <- headers %>%
  str_remove("# Fields: ") %>% # get rid of the extraneous information
  str_split(", ") %>% #split into pieces 
  unlist() %>% #convert to vector
  make.names() %>% #make names the R can understand
  str_replace(fixed(".."), ".") %>% # get rid of double .. in names.
  str_replace("X.identity", "pct.identity") # "%" got replaced with X, we can do better.
headers
```

```
##  [1] "query.acc.ver"    "subject.acc.ver"  "pct.identity"     "alignment.length"
##  [5] "mismatches"       "gap.opens"        "q.start"          "q.end"           
##  [9] "s.start"          "s.end"            "evalue"           "bit.score"       
## [13] "subject.title"
```

```r
megaWS11 <- read_tsv("../input/blastout.mega.WS11.tsv.gz", col_names=headers, comment="#")
```

```
## Rows: 13992 Columns: 13
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: "\t"
## chr  (3): query.acc.ver, subject.acc.ver, subject.title
## dbl (10): pct.identity, alignment.length, mismatches, gap.opens, q.start, q....
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
megaWS28 <- read_tsv("../input/blastout.mega.WS28.tsv.gz", col_names=headers, comment="#")
```

```
## Rows: 1047 Columns: 13
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: "\t"
## chr  (3): query.acc.ver, subject.acc.ver, subject.title
## dbl (10): pct.identity, alignment.length, mismatches, gap.opens, q.start, q....
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
blastnWS11 <- read_tsv("../input/blastout.task_blastn.WS11.tsv.gz", col_names=headers, comment="#")
```

```
## Rows: 12545 Columns: 13
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: "\t"
## chr  (3): query.acc.ver, subject.acc.ver, subject.title
## dbl (10): pct.identity, alignment.length, mismatches, gap.opens, q.start, q....
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
dc_megaWS11 <- read_tsv("../input/blastout.task_dc-megablast.WS11.tsv.gz", col_names=headers, comment="#")
```

```
## Rows: 10691 Columns: 13
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: "\t"
## chr  (3): query.acc.ver, subject.acc.ver, subject.title
## dbl (10): pct.identity, alignment.length, mismatches, gap.opens, q.start, q....
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
tblastx <- read_tsv("../input/blastout.tblastx.tsv.gz", col_names=headers, comment="#")
```

```
## Rows: 385017 Columns: 13
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: "\t"
## chr  (3): query.acc.ver, subject.acc.ver, subject.title
## dbl (10): pct.identity, alignment.length, mismatches, gap.opens, q.start, q....
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
blast.results <- bind_rows(list(megaWS11=megaWS11,
                                megaWS28=megaWS28, 
                                blastnWS11=blastnWS11, 
                                dc_megaWS11=dc_megaWS11,
                                tblastx=tblastx), 
                           .id="strategy")
head(blast.results)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["strategy"],"name":[1],"type":["chr"],"align":["left"]},{"label":["query.acc.ver"],"name":[2],"type":["chr"],"align":["left"]},{"label":["subject.acc.ver"],"name":[3],"type":["chr"],"align":["left"]},{"label":["pct.identity"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["alignment.length"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["mismatches"],"name":[6],"type":["dbl"],"align":["right"]},{"label":["gap.opens"],"name":[7],"type":["dbl"],"align":["right"]},{"label":["q.start"],"name":[8],"type":["dbl"],"align":["right"]},{"label":["q.end"],"name":[9],"type":["dbl"],"align":["right"]},{"label":["s.start"],"name":[10],"type":["dbl"],"align":["right"]},{"label":["s.end"],"name":[11],"type":["dbl"],"align":["right"]},{"label":["evalue"],"name":[12],"type":["dbl"],"align":["right"]},{"label":["bit.score"],"name":[13],"type":["dbl"],"align":["right"]},{"label":["subject.title"],"name":[14],"type":["chr"],"align":["left"]}],"data":[{"1":"megaWS11","2":"Seq_H","3":"MG772933","4":"89.112","5":"21702","6":"2276","7":"68","8":"1","9":"21664","10":"33","11":"21685","12":"0.00e+00","13":"26904","14":"MG772933 |Bat SARS-like coronavirus isolate bat-SL-CoVZC45| complete genome|Severe acute respiratory syndrome-related coronavirus|China|Rhinolophus sinicus"},{"1":"megaWS11","2":"Seq_H","3":"MG772933","4":"89.000","5":"6791","6":"719","7":"23","8":"23043","9":"29825","10":"22992","11":"29762","12":"0.00e+00","13":"8377","14":"MG772933 |Bat SARS-like coronavirus isolate bat-SL-CoVZC45| complete genome|Severe acute respiratory syndrome-related coronavirus|China|Rhinolophus sinicus"},{"1":"megaWS11","2":"Seq_H","3":"MG772933","4":"77.289","5":"546","6":"116","7":"7","8":"22299","9":"22840","10":"22305","11":"22846","12":"6.53e-82","13":"315","14":"MG772933 |Bat SARS-like coronavirus isolate bat-SL-CoVZC45| complete genome|Severe acute respiratory syndrome-related coronavirus|China|Rhinolophus sinicus"},{"1":"megaWS11","2":"Seq_H","3":"MG772934","4":"88.660","5":"18272","6":"2035","7":"34","8":"3297","9":"21549","10":"3247","11":"21500","12":"0.00e+00","13":"22229","14":"MG772934 |Bat SARS-like coronavirus isolate bat-SL-CoVZXC21| complete genome|Severe acute respiratory syndrome-related coronavirus|China|Rhinolophus sinicus"},{"1":"megaWS11","2":"Seq_H","3":"MG772934","4":"89.094","5":"6785","6":"706","7":"26","8":"23052","9":"29825","10":"22931","11":"29692","12":"0.00e+00","13":"8399","14":"MG772934 |Bat SARS-like coronavirus isolate bat-SL-CoVZXC21| complete genome|Severe acute respiratory syndrome-related coronavirus|China|Rhinolophus sinicus"},{"1":"megaWS11","2":"Seq_H","3":"MG772934","4":"92.696","5":"3190","6":"226","7":"6","8":"1","9":"3187","10":"33","11":"3218","12":"0.00e+00","13":"4593","14":"MG772934 |Bat SARS-like coronavirus isolate bat-SL-CoVZXC21| complete genome|Severe acute respiratory syndrome-related coronavirus|China|Rhinolophus sinicus"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>
**Exercise 1:** What are the total number of hits for each search strategy? __hint:__ start with the `blast.results` tibble and use `group_by()` and `summarize_()`. Do not type out the results manually, instead make sure that your code generates a table (that is included in the knitted output).  You should need 1 to 3 lines of code for this and you should not need to run separate commands for the different search strategies.

```r
blast.results %>% 
  group_by(strategy) %>%
  summarize("Hits" = n())
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["strategy"],"name":[1],"type":["chr"],"align":["left"]},{"label":["Hits"],"name":[2],"type":["int"],"align":["right"]}],"data":[{"1":"blastnWS11","2":"12545"},{"1":"dc_megaWS11","2":"10691"},{"1":"megaWS11","2":"13992"},{"1":"megaWS28","2":"1047"},{"1":"tblastx","2":"385017"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>
**Exercise 2:** Using the `blast.results` tibble, for each search strategy, calculate:
* Average alignment length
* Maximum alignment length
* Total alignment length (sum of all alignment lengths)
* Average percent identity  
For full credit start with `blast.results` and only call the `summarize` function once (you can have multiple arguments in the `summarize` function).  Your code should produce a table as output (you do not need to type the table manually). 


```r
#str(blast.results)
blast.results %>% 
  group_by(strategy) %>%
  select(strategy, pct.identity, alignment.length) %>%
  summarise("Avg Alm Length" = mean(alignment.length),
            "Max Alm Length" = max(alignment.length),
            "Total Alm Length" = sum(alignment.length),
            "Average % Identity" = mean(pct.identity))
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["strategy"],"name":[1],"type":["chr"],"align":["left"]},{"label":["Avg Alm Length"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["Max Alm Length"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["Total Alm Length"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["Average % Identity"],"name":[5],"type":["dbl"],"align":["right"]}],"data":[{"1":"blastnWS11","2":"1695.2564","3":"26651","4":"21266991","5":"70.32399"},{"1":"dc_megaWS11","2":"1964.4258","3":"26651","4":"21001676","5":"69.77778"},{"1":"megaWS11","2":"921.9385","3":"21702","4":"12899763","5":"75.72907"},{"1":"megaWS28","2":"6434.3448","3":"21702","4":"6736759","5":"81.86662"},{"1":"tblastx","2":"106.7988","3":"2824","4":"41119360","5":"48.85633"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


**Exercise 3**: We have multiple hits per subject and we want to focus on the unique hits.  Make a new object called `uniq.blast.results` that retains the single longest alignment for each subject in each strategy. _Hint: use one of the `slice` functions._ 


```r
uniq.blast.results <- blast.results %>%
  group_by(strategy, subject.acc.ver) %>%
  slice_max(order_by = alignment.length,  n = 1)
uniq.blast.results
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
  </script>
</div>


**Exercise 4:** Repeat the summary from Exercise 2, but now on the unique hits.  How do the results fit with your understanding of these different search strategies?

- This fits with my understanding because I expect a lot of short possible alignments when using tblastx because we are checking multiple possible frames compared to the other search strategies. In the uniq table, the average alignment is much larger while the total is much smaller as there are no longer a lot of hits for each subject.


```r
#str(blast.results)
uniq.blast.results %>% 
  group_by(strategy) %>%
  select(strategy, pct.identity, alignment.length) %>%
  summarise("Avg Alm Length" = mean(alignment.length),
            "Max Alm Length" = max(alignment.length),
            "Total Alm Length" = sum(alignment.length),
            "Average % Identity" = mean(pct.identity))
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["strategy"],"name":[1],"type":["chr"],"align":["left"]},{"label":["Avg Alm Length"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["Max Alm Length"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["Total Alm Length"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["Average % Identity"],"name":[5],"type":["dbl"],"align":["right"]}],"data":[{"1":"blastnWS11","2":"6345.836","3":"26651","4":"15921703","5":"67.30217"},{"1":"dc_megaWS11","2":"6341.223","3":"26651","4":"15859399","5":"67.22375"},{"1":"megaWS11","2":"2883.051","3":"21702","4":"7224925","5":"72.33937"},{"1":"megaWS28","2":"13803.630","3":"21702","4":"4513787","5":"80.02975"},{"1":"tblastx","2":"1077.517","3":"2824","4":"2903907","5":"65.89471"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

```r
blast.results %>% 
  group_by(strategy) %>%
  select(strategy, pct.identity, alignment.length) %>%
  summarise("Avg Alm Length" = mean(alignment.length),
            "Max Alm Length" = max(alignment.length),
            "Total Alm Length" = sum(alignment.length),
            "Average % Identity" = mean(pct.identity))
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["strategy"],"name":[1],"type":["chr"],"align":["left"]},{"label":["Avg Alm Length"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["Max Alm Length"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["Total Alm Length"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["Average % Identity"],"name":[5],"type":["dbl"],"align":["right"]}],"data":[{"1":"blastnWS11","2":"1695.2564","3":"26651","4":"21266991","5":"70.32399"},{"1":"dc_megaWS11","2":"1964.4258","3":"26651","4":"21001676","5":"69.77778"},{"1":"megaWS11","2":"921.9385","3":"21702","4":"12899763","5":"75.72907"},{"1":"megaWS28","2":"6434.3448","3":"21702","4":"6736759","5":"81.86662"},{"1":"tblastx","2":"106.7988","3":"2824","4":"41119360","5":"48.85633"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

**Exercise 5**: For the full `blast.results` set (not the unique ones), answer the following questions for each search strategy.  You do not need to type out the results so long as your knitted markdown has the answer output in a table.  For full credit, your code should only call `summarize` once (but with multiple arguments).

* What proportion of hits have an e-value of 0?
* What proportion of hits have a percent identity < 50?
* What proportion of hits have an E-value of 0 _and_ have a percent identity less than 50?


```r
str(blast.results)
```

```
## spc_tbl_ [423,292 × 14] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
##  $ strategy        : chr [1:423292] "megaWS11" "megaWS11" "megaWS11" "megaWS11" ...
##  $ query.acc.ver   : chr [1:423292] "Seq_H" "Seq_H" "Seq_H" "Seq_H" ...
##  $ subject.acc.ver : chr [1:423292] "MG772933" "MG772933" "MG772933" "MG772934" ...
##  $ pct.identity    : num [1:423292] 89.1 89 77.3 88.7 89.1 ...
##  $ alignment.length: num [1:423292] 21702 6791 546 18272 6785 ...
##  $ mismatches      : num [1:423292] 2276 719 116 2035 706 ...
##  $ gap.opens       : num [1:423292] 68 23 7 34 26 6 5 169 65 12 ...
##  $ q.start         : num [1:423292] 1 23043 22299 3297 23052 ...
##  $ q.end           : num [1:423292] 21664 29825 22840 21549 29825 ...
##  $ s.start         : num [1:423292] 33 22992 22305 3247 22931 ...
##  $ s.end           : num [1:423292] 21685 29762 22846 21500 29692 ...
##  $ evalue          : num [1:423292] 0.00 0.00 6.53e-82 0.00 0.00 ...
##  $ bit.score       : num [1:423292] 26904 8377 315 22229 8399 ...
##  $ subject.title   : chr [1:423292] "MG772933 |Bat SARS-like coronavirus isolate bat-SL-CoVZC45| complete genome|Severe acute respiratory syndrome-r"| __truncated__ "MG772933 |Bat SARS-like coronavirus isolate bat-SL-CoVZC45| complete genome|Severe acute respiratory syndrome-r"| __truncated__ "MG772933 |Bat SARS-like coronavirus isolate bat-SL-CoVZC45| complete genome|Severe acute respiratory syndrome-r"| __truncated__ "MG772934 |Bat SARS-like coronavirus isolate bat-SL-CoVZXC21| complete genome|Severe acute respiratory syndrome-"| __truncated__ ...
##  - attr(*, "spec")=
##   .. cols(
##   ..   query.acc.ver = col_character(),
##   ..   subject.acc.ver = col_character(),
##   ..   pct.identity = col_double(),
##   ..   alignment.length = col_double(),
##   ..   mismatches = col_double(),
##   ..   gap.opens = col_double(),
##   ..   q.start = col_double(),
##   ..   q.end = col_double(),
##   ..   s.start = col_double(),
##   ..   s.end = col_double(),
##   ..   evalue = col_double(),
##   ..   bit.score = col_double(),
##   ..   subject.title = col_character()
##   .. )
##  - attr(*, "problems")=<externalptr>
```

```r
blast.results %>%
  group_by(strategy) %>%
  select(strategy, evalue, pct.identity) %>%
  summarise("Frac of Eval = 0" = (sum(evalue == 0.00)/n()),
            "%id < 50" = (sum(pct.identity < 50)/n()),
            "%id < 50 AND Eval = 0" = sum((sum(pct.identity < 50)/n())/(sum(evalue == 0.00)/n())))
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["strategy"],"name":[1],"type":["chr"],"align":["left"]},{"label":["Frac of Eval = 0"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["%id < 50"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["%id < 50 AND Eval = 0"],"name":[4],"type":["dbl"],"align":["right"]}],"data":[{"1":"blastnWS11","2":"0.14475887","3":"0.000000","4":"0.0000000"},{"1":"dc_megaWS11","2":"0.16986250","3":"0.000000","4":"0.0000000"},{"1":"megaWS11","2":"0.07154088","3":"0.000000","4":"0.0000000"},{"1":"megaWS28","2":"0.93218720","3":"0.000000","4":"0.0000000"},{"1":"tblastx","2":"0.84659379","3":"0.598371","4":"0.7067982"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


**Exercise 6**: Why do you think `tblastx` is so different?

- because of the way the search is done in comparison to the other types of blast.Instead of having some given nt sequence and a reference seq, there are many possible queries and targets when using tblastx leading to a lot of exact hits because we are translating both the reference and the query and seeing if there is an alignment there.

**Exercise 7:** Use the commands above to create the data frame below from `uniq.blast.results` and store it in an object called `upset.table`.  Only the first 6 lines are shown.


```r
#added library at the top of Rmd
upset.table <- uniq.blast.results %>%
  select( subject.acc.ver, strategy) %>%
  table() %>%
  as.data.frame.matrix()
upset.table
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
  </script>
</div>

```r
upset(upset.table)
```

![](Assignment_4_template_1_files/figure-html/Exercise 7-1.png)<!-- -->


**Exercise 8:** Interpret the plot: overall do these strategies generally find the same sequences?  Which strategy/ies are outliers?  How does that relate to what you know about the different search strategies.

 - Most of these strategies find the same sequences such as column 5, but only some sequences are found by all the strategies. The strategies that are outliers are tblastx and megaWS28 where there is a lot of additional or omitted sequences. The missing sequences from megaWS28 could be because this strategy is for finding alignments from similar sequences so there could be a false negative for what we want to find. There is also many unique sequences found for tblastx and these could be false positives for what we want because this strategy dones a lot more searching when translating the sequences.

**Exercise 9:** Let's investigate those errors.  Use the [ ] to view the offending rows of `uniq.blastn`.  what went wrong?



```r
uniq.blastn <- uniq.blast.results %>%  #Filter uniq.blast.results to only get ones w/ complete genome
  ungroup %>%
  filter(strategy == "blastnWS11",
         str_detect(subject.title, "complete genome"))
#head(uniq.blastn)

#uniq.blastn %>%  #way to see that there are multiple isolates for a subject via subject title
  #pull(subject.title) #%>%
  #head()

uniq.blastn[c(1437, 2307, 2081),] %>% select(subject.title) #See before separation
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["subject.title"],"name":[1],"type":["chr"],"align":["left"]}],"data":[{"1":"KX236016 |Infectious bronchitis virus strain ck/CH/LHB/090921 complete genome|Avian coronavirus|China|Gallus gallus"},{"1":"MK071267 |Avian coronavirus AvCoV/Gallus gallus//H120 complete genome|Avian coronavirus||"},{"1":"MG913342 |Avian coronavirus isolate AvCoV/Gallus gallus/Brazil/sample 38/2013 GI-11| complete genome| complete genome|Avian coronavirus|Brazil|Gallus gallus"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

```r
uniq.blastn <- uniq.blastn %>% #Separate subject.title
  separate(subject.title,
           into=c("acc", "isolate", "compute", "name", "country", "host"),
           remove = FALSE,
           sep = "\\|")
```

```
## Warning: Expected 6 pieces. Additional pieces discarded in 1 rows [2081].
```

```
## Warning: Expected 6 pieces. Missing pieces filled with `NA` in 2 rows [1437,
## 2307].
```

```r
uniq.blastn[c(1437, 2307, 2081),] %>%
  select(subject.title, acc, isolate, compute, name, country, host) #investigate offending observations via slicing
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["subject.title"],"name":[1],"type":["chr"],"align":["left"]},{"label":["acc"],"name":[2],"type":["chr"],"align":["left"]},{"label":["isolate"],"name":[3],"type":["chr"],"align":["left"]},{"label":["compute"],"name":[4],"type":["chr"],"align":["left"]},{"label":["name"],"name":[5],"type":["chr"],"align":["left"]},{"label":["country"],"name":[6],"type":["chr"],"align":["left"]},{"label":["host"],"name":[7],"type":["chr"],"align":["left"]}],"data":[{"1":"KX236016 |Infectious bronchitis virus strain ck/CH/LHB/090921 complete genome|Avian coronavirus|China|Gallus gallus","2":"KX236016","3":"Infectious bronchitis virus strain ck/CH/LHB/090921 complete genome","4":"Avian coronavirus","5":"China","6":"Gallus gallus","7":"NA"},{"1":"MK071267 |Avian coronavirus AvCoV/Gallus gallus//H120 complete genome|Avian coronavirus||","2":"MK071267","3":"Avian coronavirus AvCoV/Gallus gallus//H120 complete genome","4":"Avian coronavirus","5":"","6":"","7":"NA"},{"1":"MG913342 |Avian coronavirus isolate AvCoV/Gallus gallus/Brazil/sample 38/2013 GI-11| complete genome| complete genome|Avian coronavirus|Brazil|Gallus gallus","2":"MG913342","3":"Avian coronavirus isolate AvCoV/Gallus gallus/Brazil/sample 38/2013 GI-11","4":"complete genome","5":"complete genome","6":"Avian coronavirus","7":"Brazil"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

- The offending entries are either longer or shorter than expected for `subject.title`. Row 1437 and 2307 of uniq.blastn are too short and have the wrong separator for what's computed, `\\` instead of `|` as the delimiter for the part that says complete genome and shifts rest of the columns to the left. Row 2081 of uniq.blastn has the opposite problem where complete genome is written out twice shifting the columns to the right.

**Exercise 10:** Let's delete those rows  Use the [ ] to remove the offending rows of `uniq.blastn`.  Put the result in a new object called `uniq.blastn.filtered`


```r
uniq.blastn.filtered <- uniq.blastn[c(-1437, -2307, -2081),]
```

**Exercise 11:** Look back to Exercise 3, where you created `uniq.blast.results` Use a similar strategy to retain the two entries with highest percent identity for each combination of name, country, and host in the `uniq.blastn.filtered` data frame.  Put the results back into `uniq.blastn.filtered`.


```r
uniq.blastn.filtered <- uniq.blastn.filtered %>%
  mutate_all(function(x) ifelse(x=="", NA, x))

uniq.blastn.filtered <- na.omit(uniq.blastn.filtered)

nrow(uniq.blastn.filtered)
```

```
## [1] 2167
```



```r
uniq.blastn.filtered <- uniq.blastn.filtered %>%
  group_by(name, country, host) %>%
  slice_max(order_by = pct.identity, n=2)

nrow(uniq.blastn.filtered)
```

```
## [1] 492
```


**Exercise 12:** Finally, filter to retain those with an alignment length >= 5000.  Put the results back in to `uniq.blastn.filtered`


```r
uniq.blastn.filtered <- uniq.blastn.filtered %>%
  filter(alignment.length >= 5000)

nrow(uniq.blastn.filtered)
```

```
## [1] 195
```



**Exercise 13:** Use `[ ]` to subset the ncbi seqs to retain only those present in `uniq.blastn.filtered`.  Put the resulting sequences in an object named `selected.seqs`.  You should have 195 sequences.


```r
#added library(Biostrings) at the top
ncbi.seqs <- readDNAStringSet("../../assignment02-rhpineda/input/ncbi_virus_110119_2.txt")
ncbi.seqs
```

```
## DNAStringSet object of length 122200:
##            width seq                                        names               
##      [1]   10705 GTCTACGTGGACCGACAAAG...TGGAATGGTGCTGTTGAAT MH781015 |Dengue ...
##      [2]  198157 ATGGACAGCATAACTAACGG...AGTACACTACAAAGTTAAC NC_044938 |Heliot...
##      [3]  193886 ACAATTTTATATTATAGTGC...CACTATAATATAAAATTGT NC_044944 |Africa...
##      [4]  190773 TCTTATTACTACTGCTGTAG...TACAGCAGTAGTAATAAGA NC_044950 |Africa...
##      [5]   34080 AATAAATAACGAAACATGCA...GCATGTTTCGTTATTTATT NC_044960 |Bottle...
##      ...     ... ...
## [122196]    2585 CGGTGGCGTTTTTGTAATAA...AGAGAATCTATTTGTTAAA X15984 |Abutilon ...
## [122197]    2632 CGGTGGCATTTATGTAATAA...GTACTCTAAATTTCTTTGG X15983 |Abutilon ...
## [122198]    1291 CGCCAAAAACCTCTGCTAAG...GACGGCTGAGTTGATCTGG M29963 |Coconut f...
## [122199]    6355 GATGTTTTAATAGTTTTCGA...AACCGCCGGTAGCGGCCCA M34077 |Tobacco m...
## [122200]   12297 GTATACGAGGTTAGCTCTTT...TAATTTCCTAACGGCCCCC J04358 |Classical...
```

```r
selected.seqs <- ncbi.seqs[uniq.blastn.filtered$subject.title]
summary(selected.seqs)
```

```
## [1] "DNAStringSet object of length 195 with 0 metadata columns"
```

**Exercise 14:** Read in the patient seq file, extract the Seq_H sequence, and then add it to the `selected.seqs` object using `c()`.  The new sequence object should have 196 sequences. Write it out to a fasta file using the function `writeXStringSet()`, naming the resulting file "selected_viral_seqs.fa".


```r
seqH <- readDNAStringSet("../../assignment02-rhpineda/input/bestcandidate.txt") #extract seqH
selected.seqs <- c(selected.seqs, seqH) #add to selected seq
summary(selected.seqs) #check for 196
```

```
## [1] "DNAStringSet object of length 196 with 0 metadata columns"
```

```r
writeXStringSet(selected.seqs, "../output/selected_viral_seqs.fa")
```

**Exercise 15:** Copy or move your tidyverse notes into the repo, add and commit them.  Enter the file name(s) here:

`/scripts/TidyverseNotes.Rmd`

**Turning in the assignment**

* Click the knit button at the top of the screen to create an html.  Check it to make sure you are happy with its content.
* add your .Rmd and .html files to the repository and commit the changes.
* push the changes