    % GFSK Parameters (Volume 6, Part A, Section 3.1 of Core_V4.0.pdf)
    samp_rate = 2e6;
    symb_rate = 1e6;
    samps_per_symb = samp_rate/symb_rate;
    time_bw_prod = 0.5;                     % Can vary between 0.45 and 0.55 depending on device.
    symb_span = 5;
    freq_sep = 360e3;
    gauss_taps = gauss_pulse_create(time_bw_prod,symb_span,samps_per_symb);
    
    % Defined Advertising Channel Parameters
    adv_preamble = [0,1,0,1,0,1,0,1];       % (Volume 6, Part B, Section 2.1.1 of Core_V4.0.pdf)
    adv_accessaddress = [0,1,1,0,1,0,1,1,0,1,1,1,1,1,0,1,1,0,0,1,0,0,0,1,0,1,1,1,0,0,0,1];      % (Volume 6, Part B, Section 2.1.1 of Core_V4.0.pdf)
    
    preamble_proto = conv(fskmod(([adv_preamble,adv_accessaddress]),2,freq_sep,samps_per_symb,samp_rate),gauss_taps);