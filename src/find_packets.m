#! /usr/bin/octave -qf
cd(fileparts(mfilename('fullpath')))

% Includes
source 'util.m'
source 'parse.m'

data = load_var('../data/demodded_str.mat', 'str_data');

preamble = '01010101';
acc_addr = '01101011011111011001000101110001';
both = strcat(preamble, acc_addr);

indices = strfind(data, both);
successful = 0;
for j = 1:length(indices)
	i = indices(j);
	max = ((1+4+39+3)*8);
	packet = data(i:i+max-1);
	if parse(packet)
		successful++;
	end
	printf('\n');
end

printf('%d packets parsed, %d valid\n', length(indices), successful);
