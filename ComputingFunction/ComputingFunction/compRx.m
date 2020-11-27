function [Rx,fsize,WLL]=compRx(x,opt)
% a function handle to operate wavelet in vectors
% calculate Q*x, x the same length of the final recon images
% 05/03/2013 Yi Guo

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


TV1=circshift(x,[-1 0])-x;
TV2=circshift(x,[0 -1])-x;

Rx=[Wx(:);TV1(:);TV2(:)];


end