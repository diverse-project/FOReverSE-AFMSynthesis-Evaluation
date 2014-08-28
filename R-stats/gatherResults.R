require(ggplot2)
require(reshape)

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

# Scalability over features
scalF <- results[,c("#variables", "Synthesis", "Sicstus")] 
sqrtScalF <- data.frame(scalF[1], lapply(scalF[2], sqrt), lapply(scalF[3], sqrt))

#par(pch=18)
plot(sqrtScalF$"X.variables", sqrtScalF$"Synthesis", xlab="Number of variables", ylab="Time", cex=0.8, pch=18)
#points(sqrtScalF$"X.variables", sqrtScalF$"Sicstus")

#p <- ggplot(sqrtScalF, aes(`#variables`, Synthesis))
#p <- p + geom_point()
#print(p)

# Scalability over configurations
scalC <- results[results$"#variables" == 10 & results$"max domain size" == 10 & results$"enable or groups" == 'false',]
scalC <- scalC[,c("#configurations", "Synthesis")]

plot(scalC$"#configurations", scalC$"Synthesis", xlab="Number of configurations", ylab="Time", cex=0.8, pch=18)

# Scalability over max number of domain values
scalD <- results[,c("max domain size", "Synthesis")]
plot(scalD$"max domain size", scalD$"Synthesis", xlab="Maximum domain size", ylab="Time", cex=0.8, pch=18)





