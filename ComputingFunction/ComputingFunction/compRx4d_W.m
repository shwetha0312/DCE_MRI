function [Rx,fsize,LL]=compRx4d_W(x,opt)
% Overall sparse transform 4d wavelet + 3d TV + Temporal filter
% add automatic wavelet size organizer

% Yi Guo 
% 07/31/2013

% opt.worder={[1 2 3],[1 2]};

% x=reshape(x,opt.kx,opt.ky,opt.kz,opt.nt);

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

LL(1)=length(Wx);
LL(2)=0;
LL(3)=0;

Rx=Wx;
end