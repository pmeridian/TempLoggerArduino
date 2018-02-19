set xdata time
set timefmt "%d/%m/%Y %H:%M:%S"
set format x "%d/%m"
set format y "%3.1E"
set termoption dash
set yrange [15:30]
set terminal pngcairo enhanced font "arial,16" fontscale 1.0 size 1024, 768 
#set terminal png
set grid

set xtics 86400

#Plot absolute temp
set output "plots/temp.png"
#plot "<sed -e 's%T1=%%g' /" using 1:3 with p t "temp"

#Plot relative differences
#set output "/var/www/TEMP/temperatures_diff.png"
#set yrange [-6:3]
#plot ["2014-05-19 10:00:00":] "temperatures" using 1:($4-$3) with p t "LM35_1-SHT75",  "temperatures" using 1:($5-$3) with p t "LM35_2-SHT75" ,  "temperatures" using 1:($5-$4) with p t "LM35_2-LM35_1"

#plot "temperatures" using 1:3 w p rgb "green" t "SHT75",  "temperatures" using 1:4 w p rgb "blue" t "LM35_1", "temperatures" using 1:5 w p rgb "red" t "LM35_2"
plot ["16/02/2018 00:00":] "temperatures" using 1:3 w l t "T1", "temperatures" using 1:4 w l t "T2",  "temperatures" using 1:5 w l t "T3"
#plot "temperatures" using 1:3 w l t "T1", "temperatures" using 1:4 w l t "T2",  "temperatures" using 1:5 w l t "T3"

set output "plots/temp_diff.png"
set yrange [-1:1]
plot ["16/02/2018 00:00":] "temperatures" using 1:($3-$4) w l t "T1-T2", "temperatures" using 1:($3-$5) w l t "T1-T3", "temperatures" using 1:($4-$5) w l t "T2-T3",
#plot "temperatures" using 1:($3-$4) w l t "T1-T2", "temperatures" using 1:($3-$5) w l t "T1-T3", "temperatures" using 1:($4-$5) w l t "T2-T3",

#set output "/var/www/TEMP/temperatures_diff.png"
#
#plot "temperatures" using 1:($4-$3) w l lt 1 lc rgb "green" lw 3 t "LM35_1-SHT75",  "temperatures" using 1:($5-$3) w l lt 1 lc rgb "blue" lw 3 t "LM35_2-SHT75"

reset
set output "plots/temp_diff_scatter.png"
plot [0:30] "temperatures" using 3:($3-$4) w p t "T1-T2", "temperatures" using 3:($3-$5) w p t "T1-T3", "temperatures" using 3:($4-$5) w p t "T2-T3"

reset
set output "plots/temp_diff_histo.png"
n=200 #number of intervals
max=2. #max value
min=-2. #min value
width=(max-min)/n #interval width
#function used to map a value to the intervals
hist(x,width)=width*floor(x/width)+width/2.0
set boxwidth width*0.9
set style fill transparent solid 0.5 noborder
#set style fill solid 0.5 # fill style

#count and plot
set table 'hist_temp_diff.txt'
plot [-1:1] "temperatures" u (hist($3-$4,width)):(1.0) smooth freq w boxes fs transparent solid 0.75 lc rgb "green" t "T1-T2", "temperatures" u (hist($3-$5,width)):(1.0) smooth freq w boxes fs transparent solid 0.5 lc rgb "red" t "T1-T3", "temperatures" u (hist($4-$5,width)):(1.0) smooth freq w boxes fs transparent solid 0.5 lc rgb "blue" t "T2-T3"
unset table
