#!/bin/sh

awk -F ';' '{printf "%s %4.2f %4.2f %4.2f\n", $1,$2,$3,$4}' DATALOG.txt >/tmp/temperatures
gnuplot plot_temperatures.gnuplot
echo "Prepared /tmp/temperatures.png"