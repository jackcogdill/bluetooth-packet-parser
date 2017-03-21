# Reshape 8xN matrix into 1 row
function R = deoctify(A)
	R = reshape(A', 1, []);
endfunction
