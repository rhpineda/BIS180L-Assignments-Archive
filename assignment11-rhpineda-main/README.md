# LAB: "Genetic Networks 1 - Clustering and Genetic Networks 2 - Co-Expression"
## Genetic Networks 1 - Clustering Summary:
- BACKGROUND
  - We are using hierarchical clustering and k-means
  - Clustering is how to find similar rows or columns in the dataset
  - HIERARCHICAL CLUSTERING
      1. Calc a distance b/w row and coluns
      2. start all items as its own cluster
      3. find closest points
      4. merge, keep larger distance
      5. repeat 3 & 4
    - need to normalize the data so we can cluster it
    - use `voom` in the `limma` package
    - Dont need to use all the genes in our network
      - just use the 1000 most variable genes
      - calc coefficient of variation
    - use `pvclust` to det which # of subclusters have good support
      - random samples od data and clustering is done, see how often branches in the original dataset appears in the resample
      - if a branch appears a lot in the resample, evidence of being "real"
    - HEATMAPS
      - alternativce way to visualizing h-clustering results
  - K-MEANS CLUSTERING
    1. randomly assign each sample in dataset to one of k clusters
    2. calc the center of each cluster
    3. update assignments by assigning samples to the the new closest center
    4. repeat 2 & 3
    - estimating the ideal number of clusters is using `gap statistic`
    - use the `clusgap` fxn to see when k-1 and k+1 stasrt to look the same
## Genetic Networks 2 - Co-Expression Summary:
- BACKGROUND
  - Need to interpret data given knowledge of biological processes
  -  K-means clustering allows to search higher dimensional space for patterns in the data
  -  when we combine PC plots w/ k-means plots we assign a clolor to each cluster
  -  we are building mutual rank based gene co-expresson network now
- CALC MUTUAL RANKS
  - create correlation matrix
  - rank correlations NOT SYMMETRIC
  - compute pairwise geom means (mutual ranks) SYMMETRIC
  - choose rank baed cutoff to make adj matrix
- GRAPH STATISTICS FOR NETWORK COMPARISON
  - Graph density = total # edges bw nodes out of all possible edges b/w nodes
  - Average path length = how connected are two nodes to another
  - two very important genes
    - degree centrality - most # of edges
    - betweenness centrality - most shorthest paths going though

      
