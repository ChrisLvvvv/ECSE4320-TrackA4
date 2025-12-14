# Usage:
#   gnuplot -e "nkeys=100000; out='results/plots/throughput_n100000.png'" plots/throughput.gp

set datafile separator ","
set terminal pngcairo size 1000,650
set output out

set key left top
set grid
set xlabel "Threads"
set ylabel "Throughput (ops/s)"
set title sprintf("Throughput vs Threads (nkeys=%d)", nkeys)

# Helper: plot one workload with 2 lines (coarse/striped)
# Columns: impl,work,threads,nkeys,mean_ops_per_sec

set multiplot layout 1,3 title sprintf("Throughput vs Threads (nkeys=%d)", nkeys)

# lookup
set title "work=lookup"
plot \
  "< awk -F, 'NR>1 && $2==\"lookup\" && $1==\"coarse\" && $4==" . nkeys . " {print $3, $5}' results/raw/a4_bench_mean.csv" using 1:2 with linespoints title "coarse", \
  "< awk -F, 'NR>1 && $2==\"lookup\" && $1==\"striped\" && $4==" . nkeys . " {print $3, $5}' results/raw/a4_bench_mean.csv" using 1:2 with linespoints title "striped"

# insert
set title "work=insert"
plot \
  "< awk -F, 'NR>1 && $2==\"insert\" && $1==\"coarse\" && $4==" . nkeys . " {print $3, $5}' results/raw/a4_bench_mean.csv" using 1:2 with linespoints title "coarse", \
  "< awk -F, 'NR>1 && $2==\"insert\" && $1==\"striped\" && $4==" . nkeys . " {print $3, $5}' results/raw/a4_bench_mean.csv" using 1:2 with linespoints title "striped"

# mixed
set title "work=mixed"
plot \
  "< awk -F, 'NR>1 && $2==\"mixed\" && $1==\"coarse\" && $4==" . nkeys . " {print $3, $5}' results/raw/a4_bench_mean.csv" using 1:2 with linespoints title "coarse", \
  "< awk -F, 'NR>1 && $2==\"mixed\" && $1==\"striped\" && $4==" . nkeys . " {print $3, $5}' results/raw/a4_bench_mean.csv" using 1:2 with linespoints title "striped"

unset multiplot
