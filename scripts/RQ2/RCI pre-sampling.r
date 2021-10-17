
# The following code written in R and can be used for pre-sampling of bootstrapping
# It is used in RQ2 of the paper namely "Automated Generation and Evaluation of JMH Microbenchmark Suites from Unit Tests", TSE2021


# Output includes all benchmarks results in a form of .csv files and proper for applying 'pa'.
# Output contains 2 files which one refers to the original results and the other refers to mutation results. 

# Please specify the following variables
# 'project' refers to the project name.
# 'commit' refers to a certain commit of the project.
# 'input_file' is a csv file containing benchmark results.
# 'path_to_root' refers to the path of your workspace.
# you may also change the number of iterations in 'default_iterations' 


project = "PROJECT_NAME"
commit = "COMMIT_NUMBER"
input_file = "PATH_TO_CSV_INPUT_FILE"
path_to_root = "PATH_TO_ROOT"
benchmark = ""
params = "NA"
instance = 1
trial = 1
fork = 1
iteration = ""
mode = "thrpt"
unit = "ops/s"
value_count = 1
value = ""

default_iterations = 30


data <- read.csv(input_file, header=FALSE)
for (k in 1:nrow(data)){
	benchmark = data[k,][1]
	results <- data[k,][2:61]
	for (m in 1:30)
		iteration = m
		original_file_name= paste(path_to_root,"original.csv")
		target_file_name= paste(path_to_root,"target.csv")
		str_original = paste(project,";", commit,";", benchmark,";", params,";", instance,";", trial,";",fork,";",iteration,";",mode,";",unit,";",value_count,results[m])
		str_target = paste(project, ";",commit, ";",benchmark, ";",params, ";",instance, ";",trial,";",fork,";",iteration,";",mode,";",unit,";",value_count,results[m+default_iterations])
		df1=data.frame(str_original)
		df2=data.frame(str_target)
		write.table(df1, original_file_name,append=TRUE, sep = "", eol="\n")
		write.table(df2, target_file_name,append=TRUE, sep = "", eol="\n")
	}
}