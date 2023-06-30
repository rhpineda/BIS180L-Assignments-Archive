# LAB: "MSA and Phylo Tree Construction"
## MSA and Phylo Tree Construction Summary:
- Want to find the evo origins of virus, have sequences of viruses that map to patient seq.
- Use `MAFFT` to align
- Use 'Wasabi` to view the MAFFT output file
  - There are regions that align really wel and other gap rich regions
  - Can use other programs like `glbocks` to more systematically prune poorly aligned regions
  - Alternatively can use `PRANK` to look at a few conserved genes and use aa alignment
- found a reion to tree construction and nee dto use R to subset seqs
  -   in: whole seqs
  -   out: 75% gap cutoff (mask more than 25% gaps)
- BUILD A TREE
- use `FastTree` to make phylo tree
- Want to use maximum likelihood or bayesian approach, NOT maximum parsimony or neighbor joining
- EXAMINE TREE
- upload fasttree output to `iTOL`
- observe tree to find evolutionary origins of COVID
  
