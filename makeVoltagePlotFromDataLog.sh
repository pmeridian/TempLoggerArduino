#!/bin/sh

#skip first line
awk -F ';' 'NR>1 {printf "%s %4.2f\n", $1,$5}' $1 > voltages
mkdir -p plots
gnuplot plot_voltages.gnuplot
echo "Done"