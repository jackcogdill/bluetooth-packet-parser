% Reshape 1xN matrix into rows of 8
function octets = octify(A)
	num_octets = length(A) / 8; % Numer of octets
	octets = zeros(num_octets, 8);

	% Group data by octet
	i = 1;
	for k = 1:num_octets
		octets(k, :) = A([i:i+7]);
		i += 8;
	end
end
