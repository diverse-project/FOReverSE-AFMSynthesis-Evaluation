
readCSV <- function(dir,path) {
  fullPath = paste(dir,path,sep="")
  if (file.exists(fullPath)) {
    read.csv(fullPath,check.name=FALSE, na.strings="N/A") 
  } else {
    NULL
  }
}

dirs <- list.dirs("../results")[-1]
files <- lapply(dirs, function(dir) readCSV(dir, "/metrics.csv"))
results <- Reduce(function(...) merge(..., all=T), files)
scalF <- results[,c("#features", "Synthesis")]
plot(scalF)
