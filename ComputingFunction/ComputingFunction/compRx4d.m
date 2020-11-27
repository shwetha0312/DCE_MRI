function [Rx,fsize,LL]=compRx4d(x,opt)
% Overall sparse transform 4d wavelet + 3d TV + Temporal filter
% add automatic wavelet size organizer
% add dimension and constraints detector

% Yi Guo 
% 07/31/2013

% x=reshape(x,opt.kx,opt.ky,opt.kz,opt.nt);

if opt.lambda1~=0

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

else
LL(1)=0;
Wx=[];
fsize=0;
end

if opt.lambda2~=0
    if opt.size(3)>1

% Calculate Total variation using shift difference
TV1=x-circshift(x,[1 0 0 0]);
TV2=x-circshift(x,[0 1 0 0]);
TV3=x-circshift(x,[0 0 1 0]);
TV=[TV1(:);TV2(:);TV3(:)];
LL(2)=numel(x)*3;
    end
    
    if opt.size(3)==1
TV1=x-circshift(x,[1 0 0 0]);
TV2=x-circshift(x,[0 1 0 0]);
TV=[TV1(:);TV2(:)];
LL(2)=numel(x)*2;
    end
else
    LL(2)=0;
    TV=[];
end

if opt.lambda3~=0 && opt.size(4)>5

if opt.TV
Hx=x-circshift(x,[0 0 0 1]);
else 
Hx=0.06*x+0.44*circshift(x,[0 0 0 1])-circshift(x,[0 0 0 2])+0.44*circshift(x,[0 0 0 3])+0.06*circshift(x,[0 0 0 4]);
end

LL(3)=numel(Hx);
else
    LL(3)=0;
    Hx=[];
end

Rx=[Wx;TV;Hx(:)];

end