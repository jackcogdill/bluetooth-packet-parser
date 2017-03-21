function R = hex(A)
	len = size(A)(2);
	R = "";

	i = 1;
	while i < len
		quartet = A(1, i:i+3);
		quartet = mat2dec(quartet);
		quartet = dec2hex(quartet);
		R = strcat(R, quartet);
		i += 4;
	endwhile
endfunction
