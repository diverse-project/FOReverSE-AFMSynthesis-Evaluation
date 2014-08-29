source("utils.R")

#results <- readCSV("", "results.csv")

# Scalability over features
scalF <- results[results$"#configurations" == 1000 & results$"max domain size" == 10 & results$"enable or groups" == 'false',]
scalF <- scalF[,c("#variables", "Synthesis", "Sicstus")] 
sqrtScalF <- data.frame(scalF[1], lapply(scalF[2], sqrt))
plot(sqrtScalF$"X.variables", sqrtScalF$"Synthesis", xlab="Number of variables", ylab="Square root of time", cex=0.8, pch=18)
#points(sqrtScalF$"X.variables", sqrtScalF$"Sicstus")

# Scalability over configurations
scalC <- results[results$"#variables" == 10 & results$"max domain size" == 10 & results$"enable or groups" == 'false',]
scalC <- scalC[,c("#configurations", "Synthesis")]
plot(scalC$"#configurations", scalC$"Synthesis", xlab="Number of configurations", ylab="Time", cex=0.8, pch=18)

# Scalability over max number of domain values
scalD <- results[results$"#variables" == 10 & results$"#configurations" == 1000 & results$"enable or groups" == 'false',]
scalD <- scalD[,c("max domain size", "Synthesis")]
plot(scalD$"max domain size", scalD$"Synthesis", xlab="Maximum domain size", ylab="Time", cex=0.8, pch=18)


# Scalability over features with OR groups
scalFor <- results[results$"#configurations" == 1000 & results$"max domain size" == 10 & results$"enable or groups" == 'true',]
scalFor <- scalFor[,c("#variables", "Synthesis", "Sicstus")] 
sqrtScalFor <- data.frame(scalFor[1], lapply(scalFor[3], sqrt))
plot(sqrtScalFor$"X.variables", sqrtScalFor$"Sicstus", xlab="Number of variables", ylab="Square root of time", cex=0.8, pch=18)