function [Rx,fsize,WLL]=compRx4d2(x,opt)
% Overall sparse transform 4d wavelet + TV
% add automatic wavelet size organizer

% Yi Guo 
% 07/31/2013


x_p=reshape(x,opt.kx,opt.ky,opt.kz,opt.nt);

wc=fwtN(x_p,'db2',opt.worder); % get wavelet coefficient

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


% Calculate Total variation using shift difference
TV1=x_p-circshift(x_p,[1 0 0 0]);
TV2=x_p-circshift(x_p,[0 1 0 0]);
TV3=x_p-circshift(x_p,[0 0 1 0]);
TV4=x_p-circshift(x_p,[0 0 0 1]);


Rx=[Wx;TV1(:);TV2(:);TV3(:)];
%     TV4(:)];
end