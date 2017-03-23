function type_str = get_pdu_type(type)
	type = fliplr(type);
	type = mat2dec(type);
	switch (type)
		case 0
			type_str = 'ADV_IND';
		case 1
			type_str = 'ADV_DIRECT_IND';
		case 2
			type_str = 'ADV_NONCONN_IND';
		case 3
			type_str = 'SCAN_REQ';
		case 4
			type_str = 'SCAN_RSP';
		case 5
			type_str = 'CONNECT_REQ';
		case 6
			type_str = 'ADV_SCAN_IND';
		otherwise
			type_str = 'ERROR';
	end
end
