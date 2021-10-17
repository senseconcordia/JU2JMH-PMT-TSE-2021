# The following code written in R and can be used Wilcoxon signed-rank test and Cliff delta effect size
# It is used in RQ2 of the paper namely "Automated Generation and Evaluation of JMH Microbenchmark Suites from Unit Tests", TSE2021
# the analyze is about finding significant differences between origianl results and mutation results, using statistical tests

# Please specify the three following variables
# 'default_iteration' refers to the number of iterations (=repeatition) that a benchmark is executed (default is 30).
# 'input_file' is a csv file containing all benchmarks' iterations results.
# 'output_file' is a csv file with calculated RSD attached to the file.


default_iteration = 30 
input_file = "PATH_TO_INPUT_FILE"
output_file = "PATH_TO_OUTPUT_FILE"

wilcoxon = c()
cliff = c()

data <- read.csv(input_file, header=FALSE)
row_numbers = nrow(data)

for (i in 1:row_numbers){
	wilcoxon[i] = wilcox.test(as.numeric(data[i,][2:default_iteration+1]),as.numeric(data[i,][default_iteration+2:2*default_iteration+2])
	cliff[i] = cliff.delta(as.numeric(data[i,][2:default_iteration+1]),as.numeric(data[i,][default_iteration+2:2*default_iteration+2])
}



data <- cbind(data, data.frame(wilcoxon), data.frame(cliff))
df <- data.frame(data)
write.csv(df,output_file, row.name=TRUE)




