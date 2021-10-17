
# The following code written in R and can be used for pre-sampling of bootstrapping


# Output includes sampled iterations for different sample_size (as .csv files) that can be directly used for applying 'pa' and measuring the RCIW for different size of sampling.

# Please specify the following variables
# 'project' refers to the project name.
# 'commit' refers to a certain commit of the project.
# 'input_file' is a csv file containing benchmark results.
# 'path_to_root' refers to the path of your workspace.



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


data <- read.csv(input_file, header=FALSE)
for (k in 1:nrow(data)){
	benchmark = data[k,][1]

	for (i in 2:15){
		for (j in 1:100){
			trial = j
			sampled <- data[k,][sample(2:31,i*2)]
			for (m in 1:i){
				iteration = m
				original_file_name= paste(path_to_root,"original_r_",i,".csv")
				target_file_name= paste(path_to_root,"target_r_",i,".csv")
				str_original = paste(project,";", commit,";", benchmark,";", params,";", instance,";", trial,";",fork,";",iteration,";",mode,";",unit,";",value_count,sampled[m])
				str_target = paste(project, ";",commit, ";",benchmark, ";",params, ";",instance, ";",trial,";",fork,";",iteration,";",mode,";",unit,";",value_count,sampled[m+i])
				df1=data.frame(str_original)
				df2=data.frame(str_target)
				write.table(df1, original_file_name,append=TRUE, sep = "", eol="\n")
				write.table(df2, target_file_name,append=TRUE, sep = "", eol="\n")
			}
		}

	}
}