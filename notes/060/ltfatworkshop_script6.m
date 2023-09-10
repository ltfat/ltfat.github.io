[g_frac,a_frac,fc_frac, L_frac]=cqtfilters(fs,fmin,fmax,bins,Ls, 'fractional');

% change to different filter banks as desired
g = g_frac;
a = a_frac;
fc = fc_frac;

[tgrad,fgrad,cs,c]=filterbankphasegrad(f,g,a);
% Do the reassignment
sr=filterbankreassign(cs,tgrad,fgrad,a,cent_freqs(fs,fc));
figure; 
subplot(2,1,1);
plotfilterbank(cs,a,fc,fs,60);
title('Original filter bank coefficients');
subplot(2,1,2);
plotfilterbank(sr,a,fc,fs,60);
title('Reassigned filter bank coefficients');