set xdata time
set timefmt "%d/%m/%Y %H:%M:%S"
set format x "%d/%m"
set format y "%3.1E"
set termoption dash
set yrange [0:10]
set terminal pngcairo enhanced font "arial,16" fontscale 1.0 size 1024, 768 
#set terminal png
set grid

set xtics 86400

set output "plots/voltage.png"

plot "voltages" using 1:($3/100) w l t "V", 