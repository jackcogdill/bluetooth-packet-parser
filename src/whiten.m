function out = whiten(in, chan)
	narginchk (1,2);

	if (nargin < 2)
		chan = 37;
	end

	chan = dec2bin(chan);
	bits = length(chan);

	reg = zeros(1, 7);
	reg(1) = 1;
	j = 1;
	for i = (7-bits)+1:7
		reg(1, i) = chan(j) - '0'; % Char to int
		j++;
	end

	out = zeros(1, length(in));
	tmp = zeros(1, 7);
	for i = 1:length(in)
		tmp(1) = reg(7);
		tmp(2) = reg(1);
		tmp(3) = reg(2);
		tmp(4) = reg(3);
		tmp(5) = xor(reg(7), reg(4));
		tmp(6) = reg(5);
		tmp(7) = reg(6);

		out(i) = xor(in(i), reg(7));
		reg = tmp;
	end
end
