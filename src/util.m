% Load variable from file
function data = load_var(file, var)
	temp = load(file, var);
	data = temp.(var);
end

% Reshape 1xN matrix into rows of 8
function octets = octify(A)
	len = size(A)(2);
	num_octets = len / 8; % Numer of octets
	octets = zeros(num_octets, 8);

	% Group data by octet
	i = 1;
	for k = 1:num_octets
		octets(k, :) = A([i:i+7]);
		i += 8;
	end
end

% Reshape 8xN matrix into 1 row
function R = deoctify(A)
	R = reshape(A', 1, []);
end

% Flip every row of a 8xN matrix
function R = flip_oct(A)
	len = size(A)(1);
	for i = 1:len
		A(i, :) = fliplr(A(i, :));
	end
	R = A;
end

% Convert binary matrix to decimal
function n = mat2dec(A)
	n = int2str(A);
	n = bin2dec(n);
end

function R = hex(A)
	len = size(A)(2);
	R = '';

	i = 1;
	while i < len
		quartet = A(1, i:i+3);
		quartet = mat2dec(quartet);
		quartet = dec2hex(quartet);
		R = strcat(R, quartet);
		i += 4;
	end
end

