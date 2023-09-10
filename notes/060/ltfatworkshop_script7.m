
[f,fs] = gspi;
[g,a,fc,L,info]=cqtfilters(fs,100,fs/2 - 100,48,numel(f),'fractional', 'redmul', 8, 'Qvar',4,'subprec');
corig = filterbank(f,g,a);

c=filterbankconstphase(cellfun(@abs,corig,'UniformOutput',0),a,info.fc,info.tfr,'tol',1e-10);
cproj = filterbank(ifilterbankiter(c,g,a,'pcg','tol',1e-6),g,a);
Cdb = 20*log10( norm(abs(cell2mat(corig)) - abs(cell2mat(cproj)) )/norm( abs(cell2mat(corig))) );
       