source("utils.R")

results <- readCSV("", "results_both.csv")

results <- results[
  #results$"#variables" == 50 & 
  results$"#configurations" == 1000 & 
  results$"max domain size" == 10 & 
  results$"enable or groups" == 'false'
  ,]

count <- split(results, list(results$"#variables", results$"#configurations", results$"max domain size", results$"enable or groups"), drop=TRUE)
count <- lapply(count, function(x) nrow(x))
print(count[count < 100])

diff <- results$"Sicstus" - results$"alternative"
diff <- diff / 1000
factor <- results$"Sicstus" / results$"alternative" 

boxplot((results$"alternative" / 1000), (results$"Sicstus" / 1000), horizontal=TRUE, names=c("alternative", "sicstus"))

print(summary(results$"Sicstus" / 1000))
print(summary(results$"alternative" / 1000))
print(summary(diff))
print(summary(factor))

# Scalability w.r.t number of variables
plot(results$"#variables", (results$"Sicstus" / 1000) ** (1/2), pch=18, col="black", bg="black", main="variables")
points(results$"#variables", (results$"alternative" / 1000) ** (1/2), pch=18, col="red", bg="red")

# Scalability w.r.t number of configurations
plot(results$"#distinct configurations", (results$"Sicstus" / 1000), pch=18, col="black", bg="black", main="configurations")
points(results$"#distinct configurations", (results$"alternative" / 1000), pch=18, col="red", bg="red")

# Comparison
plot((results$"Sicstus" / 1000), pch=18, col="black", bg="black")
points((results$"alternative" / 1000), pch=18, col="red", bg="red")
