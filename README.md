# EuphyllophyteTreeRetriever
**EuphyllophyteTreeRetriever**: Retrieve consensus and boostrapped trees from Carruthers et al. *in prep*. 

## Installation: 

``` r
remotes::install_github("jtmiller28/EuphyllophyteTreeRetriever")
```

## Current retrieval functions
Download bootstrap trees
``` r
EuphyllophyteTreeRetriever::get_bootstrap_trees(all_trees = TRUE, # if true, gather all bootstrapped trees available
                                                num_trees = NA, # if all_trees = FALSE, specify the number of trees to pull (less than or equal to 1004)
                                                output_dir = "path/to/dir", # directory where the folder containing the bootstrap trees will be made
                                                tree_type = "dated", # dated or undated
                                                setSeed = TRUE, # set to TRUE if you want to make a repeatable subset pull of the bootstraps 
                                                randomSeed = 111 # if setSeed is TRUE, designate numeric seed
                                                )
```
