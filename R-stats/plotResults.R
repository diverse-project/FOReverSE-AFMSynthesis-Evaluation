source("utils.R")

results <- readCSV("", "results.csv")

count <- split(results, list(results$"#variables", results$"#configurations", results$"max domain size", results$"enable or groups"), drop=TRUE)
count <- lapply(count, function(x) nrow(x))

# Scalability over features
scalF <- results[results$"#configurations" == 100 & results$"max domain size" == 10 & results$"enable or groups" == 'false',]
scalF <- scalF[,c("#variables", "Synthesis", "Sicstus")] 
scalF <- data.frame(scalF[1], lapply(scalF[2], function(x) sqrt(x/1000)), check.names = FALSE)
plot(scalF$"#variables", scalF$"Synthesis", xlab="Number of variables", ylab="Square root of time", cex=0.8, pch=18, xaxt="n")
axis(1, at = c(5, 50, 100, 200, 500, 1000, 2000), las=2)
meanScalF <- aggregate(scalF$"Synthesis", by=list(scalF$"#variables"), FUN=mean)
points(meanScalF$"Group.1", meanScalF$"x", pch=21, col="red", bg="red")

# Scalability over configurations
scalC <- results[results$"#variables" == 50 & results$"max domain size" == 10 & results$"enable or groups" == 'false',]
scalC <- scalC[,c("#distinct configurations", "Synthesis", "#configurations")]
scalC <- data.frame(scalC[1], lapply(scalC[2], function(x) (x/1000)), scalC[3], check.names = FALSE)
plot(scalC$"#distinct configurations", scalC$"Synthesis", xlab="Number of configurations", ylab="Time (s)", cex=0.8, pch=18, xaxt="n")
axis(1, at = c(50, 200, 500, 1000, 2000, 5000, 10000), las=2)
meanScalC <- aggregate(scalC$"Synthesis", by=list(scalC$"#configurations"), FUN=mean)
points(meanScalC$"Group.1", meanScalC$"x", pch=21, col="red", bg="red")

# Scalability over max number of domain values
scalD <- results[results$"#variables" == 10 & results$"#configurations" == 10000 & results$"enable or groups" == 'false',]
scalD <- scalD[,c("real max domain size", "Synthesis", "max domain size")]
scalD <- data.frame(scalD[1], lapply(scalD[2], function(x) (x/1000)), scalD[3], check.names = FALSE)
plot(scalD$"real max domain size", scalD$"Synthesis", xlab="Maximum domain size", ylab="Time (s)", cex=0.8, pch=18, xaxt="n")
axis(1, at = c(5, 200, 500, 1000, 2000, 5000, 10000), las=2)
meanScalD <- aggregate(data.frame(scalD$"Synthesis", scalD$"real max domain size"), by=list(scalD$"max domain size"), FUN=mean)
points(meanScalD$"scalD..real.max.domain.size.", meanScalD$"scalD.Synthesis", pch=21, col="red", bg="red")

# Scalability over features with OR groups
scalFor <- results[results$"#configurations" == 1000 & results$"max domain size" == 10 & results$"enable or groups" == 'true',]
scalFor <- scalFor[,c("#variables", "Synthesis", "Sicstus")] 
scalFor <- data.frame(scalFor[1], lapply(scalFor[2], function(x) (x/60000)), check.names = FALSE)
plot(scalFor$"#variables", scalFor$"Synthesis", xlab="Number of variables", ylab="Time (min)", cex=0.8, pch=18, xaxt="n", yaxt="n")
axis(1, at = c(5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100), las=2)
axis(2, at = c(1, 5, 10, 15, 20, 25, 30, 40), las=2)
meanScalFor <- aggregate(scalFor$"Synthesis", by=list(scalFor$"#variables"), FUN=mean)
points(meanScalFor$"Group.1", meanScalFor$"x", pch=21, col="red", bg="red")