#! /usr/bin/octave -qf

# Includes
source "util.m"
source "pdu.m"

# Main function
function main()
	var = "advertising_data_unknown";
	printf("Data for %s:\n", var);

	data = load_var("frames.mat", var);
	data = octify(data);
	len = size(data)(1);

	# Find preamble
	preamble = data(1, :);
	preamble = fliplr(preamble);
	preamble = hex(preamble);

	# Find access address
	acc_addr = data(2:5, :);
	acc_addr = deoctify(acc_addr);
	acc_addr = fliplr(acc_addr);
	acc_addr = hex(acc_addr);

	# De-whiten pdu and crc
	pdu_crc = data(6:len, :);
	pdu_crc = deoctify(pdu_crc);
	channel = load_var("frames.mat", "channel");
	pdu_crc = whiten(pdu_crc, channel);

	pdu_crc_data = octify(pdu_crc);
	pdu_crc_len = size(pdu_crc_data)(1);
	pdu    = pdu_crc_data(1:pdu_crc_len-3,           :);
	crc_rx = pdu_crc_data(pdu_crc_len-2:pdu_crc_len, :);

	# Split pdu into header and payload
	pdu_len = size(pdu)(1);
	pdu_header  = pdu(1:2,       :);
	pdu_payload = pdu(3:pdu_len, :);

	pdu_type    = pdu_header(1, 1:4);
	reserved_1  = pdu_header(1, 5:6);
	tx_add      = pdu_header(1,   7);
	rx_add      = pdu_header(1,   8);
	payload_len = pdu_header(2, 1:6);
	reserved_2  = pdu_header(2, 7:8);

	pdu_type = get_pdu_type(pdu_type);
	payload_len_dec = mat2dec(payload_len);

	# crc is the calculated crc
	crc_in = deoctify(pdu);
	crc = gen_crc(crc_in);
	crc = octify(crc);
	crc = flip_oct(crc);
	crc = deoctify(crc);
	crc = hex(crc);
	printf("crc_hex = 0x%s\n", crc);

	# crc_rx is the crc received
	crc_rx = flip_oct(crc_rx);
	crc_rx = deoctify(crc_rx);
	crc_rx = hex(crc_rx);
	printf("crc_rx_hex = 0x%s\n", crc_rx);

	crc_flag = 0;
	if (strcmp(crc, crc_rx))
		crc_flag = 1;
	endif
	printf("crc_flag = %d\n", crc_flag);

	# Output values
	printf("preamble = 0x%s\n", preamble);
	printf("access_address = 0x%s\n", acc_addr);
	printf("reserved_1 = %s\n", mat2str(reserved_1));
	printf("tx_add = %d\n", tx_add);
	printf("rx_add = %d\n", rx_add);
	printf("reserved_2 = %s\n", mat2str(reserved_2));
	printf("payload_len_dec = %d\n", payload_len_dec);
	printf("pdu_type = %s\n", pdu_type);

	parse_pdu(pdu_type, pdu_payload);
endfunction

# Run
main();
