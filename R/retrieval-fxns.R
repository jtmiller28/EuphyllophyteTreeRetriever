### Title: Functions for retrieving Euphyllophyte trees
### Author: JT Miller

### Retrieve Trees #############################################################
#' Download zipped bootstrap trees from the OSF repository, unzip a desired number
#' of bootstrapped trees to a output directory
#'
#'
#' @param all_trees Boolean. If true, gather all bootstraps available, if FALSE, use num_trees to designate desired number of trees
#' @param num_trees Numeric. Specify the number of bootstraps to gather, max is all trees (1004)
#' @param output_dir Character string. Specify the location for where bootstrap tree directry will be stored
#' @param tree_type Character string. Either "dated" or "undated" bootstraps
#' @param setSeed Boolean. If you are specifying a number of bootstraps, you can set this to TRUE and specify randomSeed to ensure reproducible bootstrap subsets are gathered
#' @param randomSeed numeric. Reproducible seed to set if setSeed is TRUE
#' @param osf_tokjen Character string. The string that authorizes use of the OSF repo, this will be removed once the data is public
#'
#' examples
#' get_bootstrap_trees(all_trees = FALSE, num_trees = 100, output_dir = "path/to/desired/dir/", tree_type = "dated", setSeed = TRUE, randomSeed = 111)

get_bootstrap_trees <- function(all_trees = TRUE, # if TRUE, output directory will contain all bootstrapped trees
                                num_trees = NA, # number of trees to pull
                                output_dir, # output dir to store trees
                                tree_type = "dated",
                                setSeed = TRUE,
                                randomSeed = 111,
                                osf_token = NA # this will be removed once we have moved to public domain
){
  # load required packages
  require(osfr)
  # authorize access (remove later)
  osfr::osf_auth(token = osf_token)

  # load project
  project <- osfr::osf_retrieve_node("9tbha")

  # if dated trees are target
  if(tree_type == "dated"){
    # list the files to grab in project
    tree_files <- osfr::osf_ls_files(project, n_max = Inf, pattern = "zipped-dated-trees")
    # download the zipped files
    osfr::osf_download(tree_files, output_dir, conflicts = "overwrite")
    # find path to zip
    path_zip <- file.path(output_dir, "zipped-dated-trees.zip")
    # list the file names inside of the zip
    tree_list <- unzip(path_zip, list = TRUE)$Name
    if(all_trees == FALSE){
      # set seed if desired
      if(setSeed){set.seed(randomSeed)}
      # sample desired number of trees
      selected_trees <- sample(tree_list, num_trees)
    } else{
      selected_trees <- tree_list # grab all of them
    }
    # unzip only these trees into output directory
    unzip(path_zip, files = selected_trees, exdir = file.path(output_dir, "dated-trees"))
  }

  # if undated trees are target
  if(tree_type == "undated"){
    # list the files to grab in project
    tree_files <- osfr::osf_ls_files(project, n_max = Inf, pattern = "zipped-undated-trees")
    # download the zipped files
    osfr::osf_download(tree_files, output_dir, conflicts = "overwrite")
    # find path to zip
    path_zip <- file.path(output_dir, "zipped-undated-trees.zip")
    # list the file names inside of the zip
    tree_list <- unzip(path_zip, list = TRUE)$Name
    if(all_trees == FALSE){
      # set seed if desired
      if(setSeed){set.seed(randomSeed)}
      # sample desired number of trees
      selected_trees <- sample(tree_list, num_trees)
    } else{
      selected_trees <- tree_list # grab all of them
    }
    # unzip only these trees into output directory
    unzip(path_zip, files = selected_trees, exdir = file.path(output_dir, "undated-trees"))
  }

}
################################################################################
