[f,fs]=greasy;
Ls=length(f);
bins = 8;
[g,a,~]=cqtfilters(fs,fmin,fmax,bins,Ls,'fractional');

% To invert the filter bank, one needs to calculate the dual window, and
% apply it either when constructing the analysis filter bank (i.e. during
% the call to 'filterbank') or when constructing the synthesis filter bank
% (i.e. during the call to 'ifilterbank').

% filter bank
gd = filterbankrealdual(g,a,Ls);
c=filterbank(f,gd,a);

% This can also be done via the following shortcut:
% c=filterbank(f,{'realdual',g},a);
% assert(isequal(c, c1))

% Again, because we are working with real signals, to compensate for the loss
% of negative-valued frequencies, we need to take the output times 2, and also ensure that it is
% real-valued.
r=2*real(ifilterbank(c,g,a));
r1 = ifilterbank(c,g,a, 'real');

assert(isequal(r,r1))
% Calculate the reconstruction error as the norm of the difference between
% the input signal "f" and the output signal of the filter bank system "r".
norm(f-r)

% Plot the response
figure;
subplot(2,1,1);
R=filterbankresponse(g,a,Ls,fs,'real','plot');
subplot(2,1,2);
semiaudplot(linspace(0,fs/2,Ls/2+1),R(1:Ls/2+1));
ylabel('Magnitude');

% Plot frequency responses of individual filters
gd=filterbankrealdual(g,a,Ls);
figure;
subplot(2,1,1);
filterbankfreqz(gd,a,Ls,fs,'plot','linabs','posfreq');
subplot(2,1,2);
filterbankfreqz(g,a,Ls,fs,'plot','linabs','posfreq');

%% Worsen the frame bounds-------------------------------------------------
[g_fracw,a_fracw,fc_fracw, L_fracw]=cqtfilters(fs,fmin,fmax,bins,Ls, 'fractional', 'Qvar', 0.75);

[A, B] = filterbankrealbounds(g_fracw, a_fracw, L_fracw);

gd1=filterbankrealdual(g_fracw,a_fracw,L_fracw);
figure;
subplot(2,1,1);
filterbankfreqz(g_fracw,a_fracw,L_fracw,fs,'plot','linabs','posfreq');
title('The original filter bank, B/A = 9.7', 'fontsize', 12)
subplot(2,1,2);
filterbankfreqz(gd1,a_fracw,L_fracw,fs,'plot','linabs','posfreq');
title('The dual filter bank, B/A = 9.7', 'fontsize', 12)
