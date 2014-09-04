source("utils.R")

results <- readCSV("", "results.csv")

count <- split(results, list(results$"#variables", results$"#configurations", results$"max domain size", results$"enable or groups"), drop=TRUE)
count <- lapply(count, function(x) nrow(x))
print(count[count < 100])

#### RQ1 ####

# Scalability over features
print("Scalability w.r.t features")
scalF <- results[results$"#configurations" == 100 & results$"max domain size" == 10 & results$"enable or groups" == 'false',]
scalF <- scalF[,c("#variables", "Synthesis", "Sicstus")] 
scalF <- data.frame(scalF[1], lapply(scalF[2], function(x) (x/1000)**(1/2)), check.names = FALSE)
plot(scalF$"#variables", scalF$"Synthesis", xlab="Number of variables", ylab="Square root of time", cex=0.8, pch=18, xaxt="n")
axis(1, at = c(5, 50, 100, 200, 500, 1000, 2000), las=2)
meanScalF <- aggregate(scalF$"Synthesis", by=list(scalF$"#variables"), FUN=mean)
points(meanScalF$"Group.1", meanScalF$"x", pch=21, col="red", bg="red")

scalF.lm <- lm(scalF$"Synthesis" ~ scalF$"#variables")
scalF.r.squared <- summary(scalF.lm)$r.squared
print(scalF.r.squared)
abline(scalF.lm)

# Scalability over configurations
print("Scalability w.r.t configurations")
scalC <- results[results$"#variables" == 50 & results$"max domain size" == 10 & results$"enable or groups" == 'false',]
scalC <- scalC[,c("#distinct configurations", "Synthesis", "#configurations")]
scalC <- data.frame(scalC[1], lapply(scalC[2], function(x) (x/1000)), scalC[3], check.names = FALSE)
plot(scalC$"#distinct configurations", scalC$"Synthesis", xlab="Number of configurations", ylab="Time (s)", cex=0.8, pch=18, xaxt="n")
axis(1, at = c(50, 200, 500, 1000, 2000, 5000, 10000), las=2)
meanScalC <- aggregate(scalC$"Synthesis", by=list(scalC$"#configurations"), FUN=mean)
points(meanScalC$"Group.1", meanScalC$"x", pch=21, col="red", bg="red")

scalC.lm <- lm(scalC$"Synthesis" ~ scalC$"#distinct configurations")
scalC.r.squared <- summary(scalC.lm)$r.squared
print(scalC.r.squared)
abline(scalC.lm)

# Scalability over max number of domain values
print("Scalability w.r.t max domain size")
scalD <- results[results$"#variables" == 10 & results$"#configurations" == 10000 & results$"enable or groups" == 'false',]
scalD <- scalD[,c("real max domain size", "Synthesis", "max domain size")]
scalD <- data.frame(scalD[1], lapply(scalD[2], function(x) (x/1000)), scalD[3], check.names = FALSE)
plot(scalD$"real max domain size", scalD$"Synthesis", xlab="Maximum domain size", ylab="Time (s)", cex=0.8, pch=18, xaxt="n")
axis(1, at = c(5, 200, 500, 1000, 2000, 5000, 10000), las=2)
meanScalD <- aggregate(data.frame(scalD$"Synthesis", scalD$"real max domain size"), by=list(scalD$"max domain size"), FUN=mean)
points(meanScalD$"scalD..real.max.domain.size.", meanScalD$"scalD.Synthesis", pch=21, col="red", bg="red")

scalD.lm <- lm(scalD$"Synthesis" ~ scalD$"real max domain size")
scalD.r.squared <- summary(scalD.lm)$r.squared
print(scalD.r.squared)
abline(scalD.lm)

# Scalability over features with OR groups
scalFor <- results[results$"#configurations" == 1000 & results$"max domain size" == 10 & results$"enable or groups" == 'true',]
scalFor <- scalFor[,c("#variables", "Or")] 
scalFor <- data.frame(scalFor[1], lapply(scalFor[2], function(x) (x/60000)), check.names = FALSE)
plot(scalFor$"#variables", scalFor$"Or", xlab="Number of variables", ylab="Time (min)", cex=0.8, pch=18, xaxt="n", yaxt="n")
axis(1, at = c(5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100), las=2)
axis(2, at = c(1, 5, 10, 15, 20, 25, 30, 40), las=2)
meanScalFor <- aggregate(scalFor$"Or", by=list(scalFor$"#variables"), FUN=mean)
points(meanScalFor$"Group.1", meanScalFor$"x", pch=21, col="red", bg="red")


# Bar plots
filteredTimes <- results[results$"enable or groups" == 'false',]
filteredTimes$"Feature and attribute extraction" <- filteredTimes$"Domain extraction" + filteredTimes$"Feature and attribute extraction"
filteredTimes$"Other steps" <- 
  filteredTimes$"Feature and attribute extraction" + 
  filteredTimes$"Implication and Mutex graph" + 
  filteredTimes$"Hierarchy" +
  filteredTimes$"Place attributes" +
  filteredTimes$"Mandatory features" +
  filteredTimes$"Feature groups" +
  filteredTimes$"Binary implies" + 
  filteredTimes$"Binary excludes"
times <- filteredTimes[, c(
  #"Feature and attribute extraction", 
  "Binary implications", 
  #"Implication and Mutex graph", 
  #"Hierarchy", 
  #"Place attributes", 
  #"Mandatory features", 
  #"Mutex", 
  #"Or", 
  #"Xor", 
  #"Group processing", 
  #"Feature groups",
  #"Binary implies", 
  #"Binary excludes", 
  "Complex constraints",
  #"Cross tree constraints",
  #"AFM construction",
  "Other steps"
)]

times <- as.matrix(lapply(times, function(x) mean(x/filteredTimes$"Synthesis")))
barplot(times,
        xaxt="n",
        #xlab="Percentage of the total synthesis duration", 
        col=c("grey", "lightgrey","darkgrey"),
        #col=c("red","green"),
        legend = row.names(times), 
        horiz=TRUE, 
        beside=FALSE,
        xpd=TRUE
        )
axis(1, at = seq(0, 1, 0.1), las=2)



#### RQ2 ####
overapprox <- na.omit(results)
overapprox <- (overapprox$"#output configurations" - overapprox$"#distinct configurations") / overapprox$"#output configurations"
#steps <- data.frame(c(0,seq(0,0.9,0.1)),c(0,seq(0.1,1,0.1)))
#overapprox <- apply(steps, 1, function(d) (sum(overapprox > d[1] & overapprox <=d[2])) / NROW(overapprox))
#barplot(overapprox, 
        #horiz=TRUE, 
        #beside=FALSE,
        #names.arg=c("0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%"),
        #xaxt="n", 
#        yaxt="n")
#axis(2, at = seq(0,1,0.1), las=2)
plot(ecdf(overapprox), xpd=FALSE, xlab="Overapproximation", ylab="Distribution", main="")