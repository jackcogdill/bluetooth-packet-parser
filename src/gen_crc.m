function out = gen_crc(in)
	x55 = [0, 1, 0, 1, 0, 1, 0, 1];
	reg = horzcat(x55, x55, x55);
	reg = fliplr(reg);
	len = size(in)(2);

	for i = 1:len
		x = xor(reg(24), in(i));
		reg = shift(reg, 1);

		reg(11) = xor(reg(11), x);
		reg(10) = xor(reg(10), x);
		reg(7)  = xor(reg(7),  x);
		reg(5)  = xor(reg(5),  x);
		reg(4)  = xor(reg(4),  x);
		reg(2)  = xor(reg(2),  x);
		reg(1)  = x;
	endfor

	out = fliplr(reg);
endfunction
