%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:      Creates the filter taps for the gaussian pulse shaping 
%               filter.
%
% Inputs:       * bt             - time bandwidth product of gaussian pulse
%                                  shape
%               * symb_span      - pulse overlap (integer number of 
%                                  symbols)
%               * samps_per_symb - number of samples per symbol
%
% Output:       * filt_taps      - the filter taps for the created gaussian 
%                                  pulse shape
%
% Notes:        * Error checking not yet implemented.
%
% Author:       William C. Headley
%
% Last Updated: 8/18/2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function filt_taps = gauss_pulse_create(bt, symb_span, samps_per_symb)
    range = samps_per_symb*symb_span/2;
    alpha = sqrt(log(2))/sqrt(2) * (1/bt);

    indices = -range:range;

    filt_taps = sqrt(pi)/alpha * exp(-(pi/alpha * indices/samps_per_symb).^2);
    filt_taps = filt_taps/sum(filt_taps);
end