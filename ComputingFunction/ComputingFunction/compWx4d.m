function [Wx,fsize,WLL]=compWx4d(x,opt)
% a function handle to operate wavelet in vectors
% calculate Q*x, x the same length of the final recon images
% 05/03/2013 Yi Guo
% 08/07 to handle any level wavelet

% x_p=reshape(x,opt.kx,opt.ky,opt.kz,opt.nt);

wc=fwtN(x,'db2',opt.worder); % get wavelet coefficient

Wx=[]; % stack all coefficient to this Wx vector
N = length(wc);
fsize=cell(1,N);

%   Loop through transform order and the various coefficients
for i = 1:N
    WCt = wc{i};
    fnames = fieldnames(WCt);
    nf = size(fnames);
    for j = 1:nf
        fname = fnames{j};
        if ~strcmp(fname,'odd_dims') && ~strcmp(fname,'size') && ~strcmp(fname,'nd')
            coefs = WCt.(fname);
            if ~isempty(coefs)
                Wx=cat(1,Wx,coefs(:));
            end
            fsize{i}.(fname)=size(coefs); % store wavelet name and size in fsize
            
        else
            fsize{i}.(fname)=WCt.(fname);
        end
    end
end

WLL=length(Wx);

end