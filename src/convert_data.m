#! /usr/bin/octave -qf
cd(fileparts(mfilename('fullpath')))

# Includes
source "util.m"

printf("Loading data...");
data = load_var("../data/demodded.mat", "demod_data");
printf("done\n");

printf("Converting data to strings...");
str_data = int2str(data);
printf("done\n");

str_data = str_data';

save "../data/demodded_str.mat" str_data;
