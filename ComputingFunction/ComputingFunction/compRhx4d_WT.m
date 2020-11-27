function Rhx=compRhx4d_WT(x,opt,fsize)
% Overall inverse sparse 4d transform wavelet + 3d TV for 2d data set
% add automatic wavelet size organizer

% Yi Guo 
% 07/31/2013

kx=opt.size(1);
ky=opt.size(2);
kz=opt.size(3);
nt=opt.size(4);

N = length(fsize);
wc=cell(1,N);

begin=1;
%   Loop through transform order and the various coefficients
for i = 1:N
    ft = fsize{i};
    fnames = fieldnames(ft);
    nf = size(fnames);
    for j = 1:nf
        fname = fnames{j};
        if ~strcmp(fname,'odd_dims') && ~strcmp(fname,'size') && ~strcmp(fname,'nd')
            ftsize = ft.(fname);
            sl=prod(ftsize);
            wc{i}.(fname)=reshape(x(begin:begin+sl-1),ftsize);
            begin=begin+sl;
        else
            wc{i}.(fname)=ft.(fname);
        end
    end
    
end

Whx = iwtN(wc,'db2',opt.worder);

NL=kx*ky*kz*nt;

TV1=reshape(x(begin:begin+NL-1),kx,ky,kz,nt); % split the vecotr back to TV coefficient
begin=begin+NL;

TV2=reshape(x(begin:begin+NL-1),kx,ky,kz,nt);
begin=begin+NL;

TV3=reshape(x(begin:begin+NL-1),kx,ky,kz,nt);
begin=begin+NL;


TVh1=TV1-circshift(TV1,[-1 0 0 0]);
TVh2=TV2-circshift(TV2,[0 -1 0 0]);
TVh3=TV3-circshift(TV3,[0 0 -1 0]);

Rhx=Whx+TVh1+TVh2+TVh3;
% +TVh3;
end



