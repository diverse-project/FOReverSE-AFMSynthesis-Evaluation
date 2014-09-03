source("utils.R")

dirs <- list.dirs("/run/media/gbecan/SeagateExtHD/gbecan/afm-synthesis/results")[-1]
files <- lapply(dirs, function(dir) readCSV(dir, "/metrics.csv"))
results <- Reduce(function(...) merge(..., all=T), files)
write.csv(results,"results.csv")






