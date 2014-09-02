source("utils.R")

results <- readCSV("", "results.csv")

count <- split(results, list(results$"#variables", results$"#configurations", results$"max domain size", results$"enable or groups"), drop=TRUE)
count <- lapply(count, function(x) nrow(x))

# Scalability over features
scalF <- results[results$"#configurations" == 1000 & results$"max domain size" == 10 & results$"enable or groups" == 'false',]
scalF <- scalF[,c("#variables", "Synthesis", "Sicstus")] 
scalF <- data.frame(scalF[1], lapply(scalF[2], function(x) sqrt(x/1000)), check.names = FALSE)
plot(scalF$"#variables", scalF$"Synthesis", xlab="Number of variables", ylab="Square root of time", cex=0.8, pch=18)
#points(sqrtScalF$"X.variables", sqrtScalF$"Sicstus")

# Scalability over configurations
scalC <- results[results$"#variables" == 10 & results$"max domain size" == 10 & results$"enable or groups" == 'false',]
scalC <- scalC[,c("#configurations", "Synthesis", "Sicstus")]
scalC <- data.frame(scalC[1], lapply(scalC[2], function(x) (x/1000)), check.names = FALSE)
plot(scalC$"#configurations", scalC$"Synthesis", xlab="Number of configurations", ylab="Time (s)", cex=0.8, pch=18)

# Scalability over max number of domain values
scalD <- results[results$"#variables" == 10 & results$"#configurations" == 10000 & results$"enable or groups" == 'false',]
scalD <- scalD[,c("max domain size", "Synthesis")]
scalD <- data.frame(scalD[1], lapply(scalD[2], function(x) (x/1000)), check.names = FALSE)
plot(scalD$"max domain size", scalD$"Synthesis", xlab="Maximum domain size", ylab="Time (s)", cex=0.8, pch=18)


# Scalability over features with OR groups
scalFor <- results[results$"#configurations" == 1000 & results$"max domain size" == 10 & results$"enable or groups" == 'true',]
scalFor <- scalFor[,c("#variables", "Synthesis", "Sicstus")] 
scalFor <- data.frame(scalFor[1], lapply(scalFor[2], function(x) sqrt(x/1000)), check.names = FALSE)
plot(scalFor$"#variables", scalFor$"Synthesis", xlab="Number of variables", ylab="Square root of time", cex=0.8, pch=18)