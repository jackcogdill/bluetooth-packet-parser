# Flip every row of a 8xN matrix
function R = flip_oct(A)
	len = size(A)(1);
	for i = 1:len
		A(i, :) = fliplr(A(i, :));
	endfor
	R = A;
endfunction
