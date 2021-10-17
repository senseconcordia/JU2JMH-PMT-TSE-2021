
# The following code written in R and can be used to calculate Relative Confidence Interval of a data set.
# It is used to evaluate the variability of performance microbenchmarks' results.
# It is used in paper namely "Automated Generation and Evaluation of JMH Microbenchmark Suites from Unit Tests", TSE2021


# Please specify the three following variables
# 'iteration' refers to the number of iterations (=repeatition) that a benchmark is executed (default is 30).
# 'input_file' is a csv file containing all benchmarks' iterations results
# 'output_file' is a csv file with calculated RSD attached to the file
iteration = 30 
input_file = "PATH_TO_CSV_INPUT_FILE"
output_file = "PATH_TO_CSV_OUTPUT_FILE"


data <- read.csv(input_file, header=FALSE,skip=1)
for (i in 1:nrow(data)){
data[i,][iteration+2] <- (sd(as.numeric(data[i,][2:iteration+1]))/mean(as.numeric(data[i,][2:iteration+1])))
}
df <- data.frame(data)
write.csv(df,output_file, row.name=FALSE)