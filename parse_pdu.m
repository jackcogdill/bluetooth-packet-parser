function parse_pdu(type, payload)
	switch (type)
		case "ADV_IND"
			pay_len = size(payload)(1);
			adva    = payload(1:6,       :);
			advdata = payload(7:pay_len, :);

			adva    = deoctify(adva);
			adva    = fliplr(adva);
			adva    = hex(adva);

			advdata = flip_oct(advdata);
			advdata = deoctify(advdata);
			advdata = hex(advdata);

			# Output
			printf("adva_hex = 0x%s\n", adva);
			printf("advdata_hex = 0x%s\n", advdata);
		case "ADV_DIRECT_IND"
			pay_len = size(payload)(1);
			adva    = payload(1:6,       :);
			inita   = payload(7:pay_len, :);

			adva    = deoctify(adva);
			adva    = fliplr(adva);
			adva    = hex(adva);

			inita   = deoctify(inita);
			inita   = fliplr(inita);
			inita   = hex(inita);

			# Output
			printf("adva_hex = 0x%s\n", adva);
			printf("inita_hex = 0x%s\n", inita);
		case "ADV_NONCONN_IND"
			pay_len = size(payload)(1);
			adva    = payload(1:6,       :);
			advdata = payload(7:pay_len, :);

			adva    = deoctify(adva);
			adva    = fliplr(adva);
			adva    = hex(adva);

			advdata = flip_oct(advdata);
			advdata = deoctify(advdata);
			advdata = hex(advdata);

			# Output
			printf("adva_hex = 0x%s\n", adva);
			printf("advdata_hex = 0x%s\n", advdata);
		case "SCAN_REQ"
			pay_len = size(payload)(1);
			scana   = payload(1:6,       :);
			adva    = payload(7:pay_len, :);

			scana   = deoctify(scana);
			scana   = fliplr(scana);
			scana   = hex(scana);

			adva    = deoctify(adva);
			adva    = fliplr(adva);
			adva    = hex(adva);

			# Output
			printf("scana_hex = 0x%s\n", scana);
			printf("adva_hex = 0x%s\n", adva);
		case "SCAN_RSP"
			pay_len = size(payload)(1);
			adva    = payload(1:6,       :);
			scan_rsp_data = payload(7:pay_len, :);

			adva    = deoctify(adva);
			adva    = fliplr(adva);
			adva    = hex(adva);

			scan_rsp_data = flip_oct(scan_rsp_data);
			scan_rsp_data = deoctify(scan_rsp_data);
			scan_rsp_data = hex(scan_rsp_data);

			# Output
			printf("adva_hex = 0x%s\n", adva);
			printf("scan_rsp_data_hex = 0x%s\n", scan_rsp_data);
		case "CONNECT_REQ"
			pay_len = size(payload)(1);
			inita     = payload(1:6,        :);
			adva      = payload(7:12,       :);
			lldata    = payload(13:pay_len, :);

			inita     = deoctify(inita);
			inita     = fliplr(inita);
			inita     = hex(inita);

			adva      = deoctify(adva);
			adva      = fliplr(adva);
			adva      = hex(adva);

			lldata = flip_oct(lldata);
			lldata = deoctify(lldata);
			lldata = hex(lldata);

			# Output
			printf("inita_hex = 0x%s\n", inita);
			printf("adva_hex = 0x%s\n", adva);
			printf("lldata_hex = 0x%s\n", lldata);
		case "ADV_SCAN_IND"
			pay_len = size(payload)(1);
			adva    = payload(1:6,       :);
			advdata = payload(7:pay_len, :);

			adva    = deoctify(adva);
			adva    = fliplr(adva);
			adva    = hex(adva);

			advdata = flip_oct(advdata);
			advdata = deoctify(advdata);
			advdata = hex(advdata);

			# Output
			printf("adva_hex = 0x%s\n", adva);
			printf("advdata_hex = 0x%s\n", advdata);
		otherwise
			printf("Error: unknown pdu type\n");
	endswitch
endfunction
