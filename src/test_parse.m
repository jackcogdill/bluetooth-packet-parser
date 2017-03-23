#! /usr/bin/octave -qf
cd(fileparts(mfilename('fullpath')));

% Includes
addpath('util');

% Test parsing a bluetooth packet
var = 'advertising_data_unknown';
printf('Data for %s:\n', var);
data = load_var('../data/frames.mat', var);
parse(data);
