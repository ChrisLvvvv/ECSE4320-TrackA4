# Usage:
#   gnuplot -e "work='lookup'; nkeys=100000; out='results/plots/speedup_lookup_n100000.png'" plots/speedup.gp

set datafile separator ","
set terminal pngcairo size 900,650
set output out

set key left top
set grid
set xlabel "Threads"
set ylabel "Speedup vs 1 thread"
set title sprintf("Speedup vs Threads (work=%s, nkeys=%d)", work, nkeys)

plot \
  "< awk -F, 'NR>1 && $2==\"" . work . "\" && $1==\"coarse\" && $4==" . nkeys . " {print $3, $5}' results/raw/a4_speedup_mean.csv" using 1:2 with linespoints title "coarse", \
  "< awk -F, 'NR>1 && $2==\"" . work . "\" && $1==\"striped\" && $4==" . nkeys . " {print $3, $5}' results/raw/a4_speedup_mean.csv" using 1:2 with linespoints title "striped"
