% This script generates several filter banks of different types and tests
% their stability in terms of frame bounds

% Fix a signal length
Ls = 88200; % 2 seconds at 44.1 kHz

%% Generate three different filter banks
% CQTFILTERS: Generate a constant-Q filter bank

% CQT parameters
fs = 44100; % Fix some sampling rate
fmin = 88; % Set minimum frequency 
fmax = fs/2; % Set maximum frequency to Nyquist rate
bins = 24; % Use 24 bins per octave (quartertone spacing)

[g_cqt,a_cqt,fc_cqt,L_cqt] = cqtfilters(fs,fmin,fmax,bins,Ls);
% By default, LTFAT filter generators compute a filter bank for real-valued
% signals. Specifically, the filter center frequencies are only placed at 
% positive frequencies. For LTFAT to behave as expected, this information
% has to be forwarded at further processing steps, by using the appropriate
% functions or the flag 'real'. See below for examples.
% 
% If you desire a filter bank covering the negative frequencies as well, e.g., 
% for processing complex-valued signals, you can append the 'complex' flag
% to the input arguments of the generator:
%
%       [g_cqt_cplx,a_cqt_cplx,fc_cqt_cplx,L_cqt_cplx] = cqtfilters(fs,fmin,fmax,bins,Ls,'complex');

% AUDFILTERS: Generate a filter bank of bandpass filters equidistantly 
% spaced on an auditory frequency scale (ERB by default)

[g_aud,a_aud,fc_aud,L_aud] = audfilters(fs,Ls);

% WAVELETFILTERS: Generate a wavelet filter bank (a special type of constant-Q 
% filter bank). This generator is very flexible, but can also be called analogous
% to 'cqtfilters' by using the 'bins' flag. 

[g_wav,a_wav,fc_wav,L_wav] = waveletfilters(Ls,'bins', fs, fmin, fmax, bins);

%% Compute the frame bounds for all filter banks

[A_cqt,B_cqt] = filterbankrealbounds(g_cqt,a_cqt,L_cqt);

fprintf('Lower frame bound (constant-Q): A_cqt = %.2f\n',A_cqt);
fprintf('Upper frame bound (constant-Q): B_cqt = %.2f\n',B_cqt);

[A_aud,B_aud] = filterbankrealbounds(g_aud,a_aud,L_aud);

fprintf('Lower frame bound (ERB filters): A_aud = %.2f\n',A_aud);
fprintf('Upper frame bound (ERB filters): B_aud = %.2f\n',B_aud);

% The frame bound calculation for the wavelet filter bank relies on a
% slower, but more general algorithm
% If you try running: 
%       [A_wav,B_wav] = filterbankrealbounds(g_wav,a_wav,L_wav);
% You get an error message that points you towards what you should do.
F_wav = frame('filterbankreal',g_wav,a_wav,numel(g_wav));

disp('The next step may take 60+ seconds, do not be afraid.');
[A_wav,B_wav] = framebounds(F_wav,L_wav,'iter','tol',1e-4);

fprintf('Lower frame bound (Wavelet filters): A_wav = %.2f\n',A_wav);
fprintf('Upper frame bound (Wavelet filters): B_wav = %.2f\n',B_wav);

%% Examine the auditory filter bank more closely

% Plot filter bank response (Here we use the 'real' flag to clarify that
% the filter bank is for real-valued signals only. 
figure(1);
fbResp_aud = filterbankresponse(g_aud,a_aud,L_aud,'plot','real');
title('Filter bank response whole FB')

fprintf('Minimum of the filter bank response (ERB filters): %.2f\n',min(fbResp_aud));
fprintf('Maximum of the filter bank response (ERB filters): %.2f\n',max(fbResp_aud));
% Note that in this case, the oscillations of the filter bank response
% fully explain the frame bounds. This is only the case if the filter bank
% is 'painless', i.e., it uses strictly bandlimited filters and the
% downsampling factors are small enough.

% We can improve the frame bounds by making the filter bank response
% flatter, e.g., by computing the corresponding tight filter bank. By using 
% filterbankrealtight, we acknowledge that g_aud only covers the positive 
% frequencies:
g_audtight = filterbankrealtight(g_aud,a_aud,L_aud);

[A_aud2,B_aud2] = filterbankrealbounds(g_audtight,a_aud,L_aud);

fprintf('Lower frame bound (ERB filters 2): A_aud2 = %.2f\n',A_aud2);
fprintf('Upper frame bound (ERB filters 2): B_aud2 = %.2f\n',B_aud2);

figure(2);
fbResp_aud2 = filterbankresponse(g_audtight,a_aud,L_aud,'plot','real');
title('Filter bank response whole FB')

% We can compare the frequency response between the original filter bank
% and the tight filter bank:
figure(3);
subplot(211);
filterbankfreqz(g_aud,a_aud,L_aud,'plot','linabs','posfreq');
title('Frequency responses (ERB filter bank)');
subplot(212);
filterbankfreqz(g_audtight,a_aud,L_aud,'plot','linabs','posfreq');
title('Frequency responses (Tight ERB filter bank)');

%% Reconstruction of signals from coefficients

% We compute the dual filter bank. By using filterbankrealdual, we acknowledge 
% that g_aud only covers the positive frequencies:
g_auddual = filterbankrealdual(g_aud,a_aud,L_aud);

% Inversion from the filter bank coefficients can now be achieved by 
%   a) Analysis with g_aud, Synthesis with g_auddual
%   b) Analysis with g_auddual, Synthesis with g_aud
%   c) Analysis and Synthesis with g_audtight

[s,fs] = gspi; % Load a short test signal
s = s(1:Ls); % Truncate to desired length

% Path a)
coef = filterbank(s,g_aud,a_aud); % Compute coefficients 
s_rec_a = ifilterbank(coef,g_auddual,a_aud,Ls,'real'); % Reconstruct, 
        %noting that g_aud is a filter bank for real signals.

% Path b)
coefdual = filterbank(s,g_auddual,a_aud); % Compute coefficients 
s_rec_b = ifilterbank(coefdual,g_aud,a_aud,Ls,'real'); % Reconstruct

% Path c) 
coeftight = filterbank(s,g_audtight,a_aud); % Compute coefficients 
s_rec_c = ifilterbank(coeftight,g_audtight,a_aud,Ls,'real'); % Reconstruct

%Compare results by computing difference to the input signal (All should be
%numerically 0.
rec_err_a = (norm(s-s_rec_a)/norm(s)).^2;
fprintf('Relative residual energy of s-s_rec_a: %.2e\n',rec_err_a);

rec_err_b = (norm(s-s_rec_b)/norm(s)).^2;
fprintf('Relative residual energy of s-s_rec_b: %.2e\n',rec_err_b);

rec_err_c = (norm(s-s_rec_c)/norm(s)).^2;
fprintf('Relative residual energy of s-s_rec_c: %.2e\n',rec_err_c);