
/*
The following code written in Java and can be used for measuring the hitting_count of a mutant (performance bug) against a performance benchmark.
It is used in RQ3 of the paper namely "Automated Generation and Evaluation of JMH Microbenchmark Suites from Unit Tests", TSE2021

In order to use:
1- place this Java class inside the project.
2- pass the mutant statement through hit() >> HittingCounter.hit(Mutant Statement)
3- the number of times that the mutant statement is executed can be obtained by calling get_hitting_count()
*/



public class HittingCounter {
	public static long counter;
	
	public static Object hit(Object o) {
		HittingCounter.counter +=1;
		return o;
	}
	
	 public static int get_hitting_count() {
		 int tmp = HittingCounter.counter;
		 HittingCounter.counter=0;
		 return tmp;
	 }
	

}