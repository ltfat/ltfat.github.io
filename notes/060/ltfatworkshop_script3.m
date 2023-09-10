% get a signal
[f,fs]=greasy;
Ls = length(f);

% set the filter bank parameters
fmin = 100;
fmax = fs;
bins = 8;

[g8,a8,fc8, L8]=cqtfilters(fs,fmin,fmax,bins,Ls,'uniform');
%g...filters
%a...downsampling factors
%fc...center frequencies of the filters
bins = 16;
[g16,a16,fc16, L16]=cqtfilters(fs,fmin,fmax,bins,Ls,'uniform');
bins = 32;
[g32,a32,fc32, L32]=cqtfilters(fs,fmin,fmax,bins,Ls,'uniform');

figure;
plot(fc8, 'linewidth', 2)
hold on
grid on
plot(fc16, 'linewidth', 2)
plot(fc32, 'linewidth', 2)
for ii = 1:bins:numel(fc32)
    % indicate the octave ranges
    line([0 numel(fc32)],[fc32(ii) fc32(ii)],'linewidth', 2,'LineStyle',':','Color','k')
end
xlabel('Number of bins')
ylabel('Frequency [Hz]')
xlim([0, numel(fc32)])