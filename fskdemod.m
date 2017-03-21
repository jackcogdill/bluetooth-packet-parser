function z = fskdemod(y,M,freq_sep,nSamp,varargin)
%FSKDEMOD Frequency shift keying demodulation
%   Z = FSKDEMOD(Y,M,FREQ_SEP,NSAMP) noncoherently demodulates the complex
%   envelope Y of a signal using the frequency shift keying method.  M is the
%   alphabet size and must be an integer power of 2.  FREQ_SEP is the frequency
%   separation, and must be positive.  NSAMP is the required samples per symbol
%   and must be an integer greater than 1.  For two dimensional signals, the
%   function treats each column of data as one channel.
%
%   Z = FSKDEMOD(Y,M,FREQ_SEP,NSAMP,Fs) specifies the sampling frequency (Hz).
%   The default sampling frequency is 1.
%
%   Z = FSKDEMOD(Y,M,FREQ_SEP,NSAMP,Fs,SYMBOL_ORDER) specifies how the 
%   function assigns binary words to corresponding integers. If SYMBOL_ORDER 
%   is set to 'bin' (default), then the function uses a natural binary-coded 
%   ordering. If SYMBOL_ORDER is set to 'gray', then the function uses a 
%   Gray-coded ordering.
%
%   See also FSKMOD, PSKDEMOD, QAMDEMOD, PAMDEMOD, OQPSKDEMOD.

%   Copyright 1996-2012 The MathWorks, Inc.


% Error checks -----------------------------------------------------------------
if (nargin < 4)
    error(message('comm:fskdemod:numarg1'));
end

if (nargin > 6)
    error(message('comm:fskdemod:numarg2'));
end

% Check that M is a positive integer
if (~isreal(M) || ~isscalar(M) || M<2 || (ceil(M)~=M) || ~isnumeric(M))
    error(message('comm:fskdemod:Mreal'));
end

% Check that M is of the form 2^K
if(~isnumeric(M) || ceil(log2(M)) ~= log2(M))
    error(message('comm:fskdemod:Mpow2'));
end

% Check that the FREQ_SEP is greater than 0
if( ~isnumeric(freq_sep) || ~isscalar(freq_sep) || freq_sep<=0 )
    error(message('comm:fskdemod:freqSep'));
end

% Check that NSAMP is an integer greater than 1
if((~isnumeric(nSamp) || (ceil(nSamp) ~= nSamp)) || (nSamp <= 1))
    error(message('comm:fskdemod:nSampPos'));
end

% Check Fs
if (nargin >= 5)
Fs = varargin{1};
    if (isempty(Fs))
        Fs = 1;
    elseif (~isreal(Fs) || ~isscalar(Fs) || ~isnumeric(Fs) || Fs<=0 )
        error(message('comm:fskdemod:FsReal'));
    end
else
    Fs = 1;
end

% Check that the maximum transmitted frequency does not exceed Fs/2
maxFreq = ((M-1)/2) * freq_sep;
if (maxFreq > Fs/2)
    error(message('comm:fskdemod:maxFreq'));
end

% Check SYMBOL_ORDER
if(nargin==4 || nargin==5 )    
   Symbol_Ordering = 'bin'; %default
else
    Symbol_Ordering = varargin{2};
    if (~ischar(Symbol_Ordering)) || (~strcmpi(Symbol_Ordering,'GRAY')) && (~strcmpi(Symbol_Ordering,'BIN'))
        error(message('comm:fskdemod:SymbolOrder'));    
    end
end

% End of error checks ----------------------------------------------------------


% Assure that Y, if one dimensional, has the correct orientation
wid = size(y,1);
if(wid ==1)
    y = y(:);
end
[nRows, nChan] = size(y);

% Preallocate memory
z = zeros(nRows/nSamp, nChan);

% Define the frequencies used for the demodulator.  
freqs = (-(M-1)/2 : (M-1)/2) * freq_sep;

% Use the frequencies to generate M complex tones which will be multiplied with
% each received FSK symbol.  The tones run down the columns of the "tones"
% matrix.
t = (0 : 1/Fs : nSamp/Fs - 1/Fs)';
phase = 2*pi*t*freqs;
tones = exp(-1i*phase);

% For each FSK channel, multiply the complex received signal with the M complex
% tones.  Then perform an integrate and dump over each symbol period, find the
% magnitude, and choose the transmitted symbol corresponding to the maximum
% magnitude.
for iChan = 1 : nChan       % loop for each FSK channel
    
    for iSym = 1 : nRows/nSamp
        
        % Load the samples for the current symbol
        yTemp = y( (iSym-1)*nSamp+1 : iSym*nSamp, iChan);
        
        % Replicate the received FSK signal to multiply with the M tones
        yTemp = yTemp(:, ones(M,1));

        % Multiply against the M tones
        yTemp = yTemp .* tones;

        % Perform the integrate and dump, then get the magnitude.  Use a
        % subfunction for the integrate and dump, to omit the error checking.
        yMag = abs(intanddump(yTemp, nSamp));

        % Choose the maximum and assign an integer value to it.  Subtract 1 from the
        % output of MAX because the integer outputs are zero-based, not one-based.
        [~, maxIdx] = max(yMag, [], 2);

        z(iSym,iChan) = maxIdx - 1;
        
    end
end

% Restore the output signal to the original orientation
if(wid == 1)
    z = z';
end

% Gray decode if necessary
if (strcmpi(Symbol_Ordering,'GRAY'))
    [~,gray_map] = gray2bin(z,'fsk',M);   % Gray decode
    % --- Assure that X, if one dimensional, has the correct orientation --- %
    if(size(z,1) == 1)
        temp = zeros(size(z));
        temp(:) = gray_map(z+1);
        z(:) = temp(:);
    else
        z = gray_map(z+1);
    end
end

% EOF -- fskdemod.m


% ------------------------------------------------------------------------------
function y = intanddump(x, Nsamp)
%INTANDDUMP Integrate and dump.
%   Y = INTANDDUMP(X, NSAMP) integrates the signal X for 1 symbol period, then
%   outputs one value into Y. NSAMP is the number of samples per symbol.
%   For two-dimensional signals, the function treats each column as 1
%   channel.
%

% --- Assure that X, if one dimensional, has the correct orientation --- %
wid = size(x,1);
if(wid ==1)
    x = x(:);
end

[xRow, xCol] = size(x);
x = mean(reshape(x, Nsamp, xRow*xCol/Nsamp), 1);
y = reshape(x, xRow/Nsamp, xCol);      

% --- restore the output signal to the original orientation --- %
if(wid == 1)
    y = y.';
end

% EOF --- intanddump.m
