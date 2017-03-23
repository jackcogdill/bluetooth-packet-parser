#! /usr/bin/octave -qf
cd(fileparts(mfilename('fullpath')))
addpath("util")

data = read_complex_binary("../data/channel37_3.dat");

# GFSK Parameters (Volume 6, Part A, Section 3.1 of Core_V4.0.pdf)
samp_rate = 2e6;
symb_rate = 1e6;
samps_per_symb = samp_rate/symb_rate;
time_bw_prod = 0.5; # Can vary between 0.45 and 0.55 depending on device.
freq_sep = 360e3;

demod_data = fskdemod(data, 2, freq_sep, samps_per_symb, samp_rate);

save "../data/demodded.mat" demod_data;
