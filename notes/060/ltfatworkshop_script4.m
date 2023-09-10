% get a signal
[f,fs]=greasy;
Ls = length(f);
% set the filter bank parameters
fmin = 100;
fmax = fs;
bins = 32;
[g32,a32,fc32, L32]=cqtfilters(fs,fmin,fmax,bins,Ls,'uniform');

% Calculate the actual filter bank and plot it.
c=filterbank(f,g32,a32);
figure;
plotfilterbank(c,a32,fc32,fs,90,'audtick');


% For the 'uniform' setting, all downsampling factors a are the same. 
% To get an invertible filter bank, for this setting, this
% means, however, that the downsampling in all channels is restricted to
% the minimum 'a' in the filter bank. This yields a quite redundant
% representation.

red_uniform = 2*sum(1./a32)-1/a32(1) - 1/a32(end); % redundancy

% Redundancy calculation:
% - we sum over all 'a', but need to take this sum times two, because we
% are working with real signals
% - to get the redundancy of the "raw" filter bank, we need to subtract the
% downsampling factors of the low- and highpass channels


% The default setting in LTFAT is 'regsampling'. Here, the downsampling
% factors 'a' differ from channel to channel. This reduces the redundancy
% of the filter bank.
bins = 32;
[g_reg,a_reg,fc_reg, L_reg]=cqtfilters(fs,fmin,fmax,bins,Ls);

red_regsampling = 2*sum(1./a_reg)-1/a_reg(1) - 1/a_reg(end);

c=filterbank(f,g_reg,a_reg);
figure;
plotfilterbank(c,a_reg,fc_reg,fs,90,'audtick');


% The redundancy can be further reduced when allowing for 'fractional'
% (non-integer) downsampling.

[g_frac,a_frac,fc_frac, L_frac]=cqtfilters(fs,fmin,fmax,bins,Ls, 'fractional');

red_frac = 2*sum(a_frac(:,2)./a_frac(:,1))-a_frac(1,2)/a_frac(1,1) - a_frac(end,2)/a_frac(end,1);

c=filterbank(f,g_reg,a_reg);
figure;
plotfilterbank(c,a_reg,fc_reg,fs,90,'audtick');

% 'fractionaluniform' finally, allows for non-integer downsampling factors
% that are the same for all channels. Because  the downsampling in all channels 
% is now again restricted to the minimum "a", the resulting filter bank is
% more redundant than for the fractional case.

[g_frac_u,a_frac_u,fc_frac_u, L_frac_u]=cqtfilters(fs,fmin,fmax,bins,Ls, 'fractionaluniform');
red_frac_u = 2*sum(a_frac_u(:,2)./a_frac_u(:,1))-a_frac_u(1,2)/a_frac_u(1,1) - ...
    a_frac_u(end,2)/a_frac_u(end,1);

c=filterbank(f,g_frac_u,a_frac_u);
figure;
plotfilterbank(c,a_frac_u,fc_frac_u,fs,90,'audtick');


% Compare the redundancies

fprintf('Redundancy (uniform):                %.2f\n\n',red_uniform);
fprintf('Redundancy (regsampling):                %.2f\n\n',red_regsampling);
fprintf('Redundancy (fractional):                %.2f\n\n',red_frac);
fprintf('Redundancy (fractionaluniform):                %.2f\n\n',red_frac_u);