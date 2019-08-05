for i in {1..3}
do 
	perf stat -e cpu-clock,task-clock,cycles,instructions,branches,branch-misses,cache-references,cache-misses $1
done
