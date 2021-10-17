
# The following code written in R and can be used to analyze three factors affecting a benchmark in bug detection.
# It is used in RQ3 of the paper namely "Automated Generation and Evaluation of JMH Microbenchmark Suites from Unit Tests", TSE2021


# Please specify the four following variables
# 'default_iteration' refers to the number of iterations (=repeatition) that a benchmark is executed (default is 30).
# 'groups' refers to the number of groups you want to make.
# 'input_file' is a csv file containing all benchmarks' iterations results.
# 'output_file' is a csv file with calculated RSD attached to the file.


default_iteration = 30 
groups = 4
input_file = "PATH_TO_INPUT_FILE"
output_file = "PATH_TO_OUTPUT_FILE"

original_size = c()
original_stability = c()
original_hiiting = c()

data <- read.csv(input_file, header=FALSE)
row_numbers = nrow(data)

for (i in 1:row_numbers){
	original_size[i] = log(mean(as.numeric(data[i,][2:default_iteration+1])),10)
	original_stability[i] = (sd(as.numeric(data[i,][2:iteration+1]))/mean(as.numeric(data[i,][2:iteration+1]))) * 100
	original_hiiting[i] = log((as.numeric(data[i,][62]) * mean(as.numeric(data[i,][2:default_iteration+1]))),10)
}

min_size = min(original_size)
max_size = max(original_size)
min_stability = min(original_stability)
max_stability = max(original_stability)
min_hitting = min(original_hiiting)
max_hitting = max(original_hiiting)

size_step = (max_size - min_size)/groups
stability_step = (max_stability - min_stability)/groups
hitting_step = (max_hitting - min_hitting)/groups

data <- cbind(data, data.frame(original_size), data.frame(original_stability), data.frame(original_hiiting))

for(i in 1:(groups*3)){
	gp <-c(length=row_numbers)
	data <- cbind(data, data.frame(gp=gp))
}


for (i in 1:row_numbers){
		for(j in 1:groups){
			if (original_size[i] >= (min_size+size_step*(j-1)) && original_size[i] < (min_size+size_step*(j))){
				data[i,][66 + (j-1)]='T'
			} else{
				data[i,][66 + (j-1)]='F'
			}

			if (original_stability[i] >= (min_stability+stability_step*(j-1)) && original_stability[i] < (min_stability+stability_step*(j))){
				data[i,][66 + groups + (j-1)]='T'
			} else{
				data[i,][66 + groups + (j-1)]='F'
			}

			if (original_hiiting[i] >= (min_hitting+hitting_step*(j-1)) && original_hiiting[i] < (min_hitting+hitting_step*(j))){
				data[i,][66 + (groups*2) + (j-1)]='T'
			} else{
				data[i,][66 + (groups*2) + (j-1)]='F'
			}
		}
}


df <- data.frame(data)
write.csv(df,output_file, row.name=TRUE)




