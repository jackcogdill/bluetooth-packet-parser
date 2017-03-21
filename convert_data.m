#! /usr/bin/octave -qf

# Includes
source "util.m"

printf("Loading data...");
data = load_var("demodded.mat", "demod_data");
printf("done\n");

printf("Converting data to strings...");
str_data = int2str(data);
printf("done\n");

printf("Concatenating into a single string...");
str_data = str_data';
printf("done\n");

save "demodded_str.mat" str_data;
