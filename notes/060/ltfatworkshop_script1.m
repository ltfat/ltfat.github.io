% This script generates a filter bank of short-time Fourier-type (or
% Gabor-type). 

%% Set up the input signal and system
% Gabor system parameters

Lg = 384; % Filter length
g = firwin('hann',Lg); % Generate Hann filter of length Lg
a = 128; % Hop size: 128 samples
M = Lg; % Number of channels: 384 (Could also be larger or smaller than Lg

% Load audio signal 

[s,fs] = wavload('greasy.wav'); % Short speech signal, fs = Sampling frequency
Ls = numel(s); % Original signal length

% Instantiate (full/complex) STFT filter bank 

[gfb,afb,fc,L] = gabfilters(Ls,g,a,M,'complex'); % gfb = Filters
                                       % afb = (Uniform) ownsampling factor
                                       % fc = Filter center frequencies
                                       % L = Compatible system length (>=Ls)
                                       
% Note: In LTFAT, a filter bank is specified by a cell array of filters ('g') 
% of size NumFilters x 1 and the associated downsampling factors ('a'). The 
% latter can be a scalar (uniform downsampling), a vector with NumFilters 
% elements (uniform/nonuniform) or a matrix of size NumFilters x 2
% (fractional downsampling with rates a(:,1)./a(:,2)).                                    

%% Demonstrate the different visualisation methods for filter banks
% Compute filter bank / time-frequency coefficients for signal s 
                                       
coef = ufilterbank(s,gfb,afb,L); % Apply analysis filter bank 
% The additional 'L' ensures that the filter bank is used with the
% instantiated, compatible signal length.

% Plot coefficients and other filter bank information

% Note: 'fc' is given in LTFAT standard relative frequency, i.e., Nyquist = 1.
fc = fc*(fs/2); % Rescale center frequencies from LTFAT standard relative frequency to Hz

figure(1);
plotfilterbank(coef,afb,fc,fs,'dynrange', 30);
title('Time-frequency coefficients')
% Providing fc and fs enables axis labeling in seconds and Hz, respectively.
% The key-value pair 'dynrange',30 truncates the colormap at 30 dB below
% the maximal value.
      
figure(2);
plot(fc,'*'); % Plot center frequencies (after rescaling to Hz)
title('Filter center frequencies')

% Plot frequency responses of filters (only consider every 4th filter
% for clarity). 
figure(3);
fResps = filterbankfreqz(gfb(1:4:end),afb,L,'plot','linabs');
title('Frequency response single filters')
% 'plot' = Plot responses instead of just computing them 
% 'linabs' = Show (linearly scaled) magnitude/absolute value of the
% frequency responses.

% Plot filter bank response (sum of squares of all frequency responses
% (If the filter bank response is flat, this is a first indicator for 
% well-conditionedness)
figure(4);
fbResp = filterbankresponse(gfb,afb,L,'plot');
title('Frequency response whole filter bank')
% 'plot' = Plot response instead of just calculating it

%% Synthesize a signal from the filter bank coefficients and compare it to 
%  the input signal

% Apply filter bank synthesis to synthesize a signal s_rec from the
% coefficients. For the given filter bank, this reproduces the signal up to
% a scaling factor. 
s_rec = ifilterbank(coef,gfb,afb,Ls);
s_rec = real(s_rec); % Get rid of complex-valued numerical noise
s_rec = s_rec./fbResp(1); % The scaling factor equals the (constant) value 
                          % of the frequency response.
               
% Plot original and reconstructed signal 
figure(5);
x = (1:Ls);
plot(x,s,x,s_rec,'--')
legend('Original signal', 'Reconstruction')

% Plot their difference
figure(6);
plot(s-s_rec)
title('Difference between the signal and its reconstruction')
