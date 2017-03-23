function R = hex(A)
	R = '';

	i = 1;
	while i < length(A)
		quartet = A(1, i:i+3);
		quartet = mat2dec(quartet);
		quartet = dec2hex(quartet);
		R = strcat(R, quartet);
		i += 4;
	end
end
