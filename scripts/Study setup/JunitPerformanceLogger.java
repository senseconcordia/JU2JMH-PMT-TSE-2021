
/*
The following code written in Java and can be used for measuring the throughput of JUnit tests.
It is used in RQ2 of the paper namely "Automated Generation and Evaluation of JMH Microbenchmark Suites from Unit Tests", TSE2021

In order to use:
1- place this Java class inside the project.
2- initialize the number of iteration (measurement_iterations) you wish to measure, and the measuring time (measurement_time), and the csv file path for result storing.
3- inside the JUnit class you want to evaluate, create a new JUnit @Rule refrencing to 'JunitaPerformanceLogger'.
4- run junit tests, and the results would be printed in output file.

*/



import java.io.FileWriter;
import java.util.concurrent.TimeUnit;

import org.junit.*;
import org.junit.rules.TestRule;
import org.junit.rules.Timeout;
import org.junit.runner.Description;
import org.junit.runners.model.Statement;



public class JunitPerformanceLogger implements TestRule {
	
	// please re-initialize the following variables 
	public Integer measurement_iterations = 30;
	public Integer measurement_time = 1; 
	public String path_to_output = "PATH_TO_OUTPUT_CSV_FILE"

	@Override
	public Statement apply(Statement base, Description description) {
		return new Statement() {
			@Override
			public void evaluate() throws Throwable {
				FileWriter mydata = new FileWriter(path_to_output,true);
				for (int i = 0; i < measurement_iterations; i++) {
					long operations = 0;
					long start = System.nanoTime();
					long TIME = 0;
					while (TIME <= measurement_time*1000000000L) {
						try {
							base.evaluate();
						} finally {

							operations += 1;
						}
						
							TIME = System.nanoTime() - start;
					}

				
				String compeletName = description.getDisplayName();
				String test = compeletName.substring(0, compeletName.indexOf("("));
				String packageName = compeletName.substring(compeletName.indexOf("(") + 1,
						compeletName.lastIndexOf(")"));
				try {
				mydata.write(packageName + "." + test + ", " + (throughput / ((TIME) / (measurement_time*1000000000)))+", ops/s");
				}catch (Exception e) {
					// TODO: handle exception
				}
				}
				try {
					mydata.write("\n");
					}catch (Exception e) {
						// TODO: handle exception
					}
				mydata.close();
			}
		}
	}
}
