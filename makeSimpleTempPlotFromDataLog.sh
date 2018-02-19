#!/bin/sh

awk -F ';' 'NR>1 {printf "%s %4.2f %4.2f %4.2f\n", $1,$2,$3,$4}' $1 > voltage
mkdir -p plots
gnuplot plot_temperatures.gnuplot
echo "Done"