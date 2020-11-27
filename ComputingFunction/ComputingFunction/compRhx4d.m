function Rhx=compRhx4d(x,opt,fsize)
kx=opt.size(1);
ky=opt.size(2);
kz=opt.size(3);
nt=opt.size(4);

begin=1;


if opt.lambda1~=0
N = length(fsize);
wc=cell(1,N);

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

else
    Whx=0;
end


if opt.lambda2~=0 
    if opt.size(3)>1
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
TVh=TVh1+TVh2+TVh3;
    end
    
    if opt.size(3)==1
NL=kx*ky*kz*nt;
TV1=reshape(x(begin:begin+NL-1),kx,ky,kz,nt); % split the vecotr back to TV coefficient
begin=begin+NL;

TV2=reshape(x(begin:begin+NL-1),kx,ky,kz,nt);
begin=begin+NL;


TVh1=TV1-circshift(TV1,[-1 0 0 0]);
TVh2=TV2-circshift(TV2,[0 -1 0 0]);
    TVh=TVh1+TVh2;
    end
else
    TVh=0;
end
    
if opt.lambda3~=0&&opt.size(4)>5    
H1=reshape(x(begin:end),kx,ky,kz,nt);

if opt.TV
Hhx=H1-circshift(H1,[0 0 0 -1]);
else
Hhx=0.06*H1+0.44*circshift(H1,[0 0 0 -1])-circshift(H1,[0 0 0 -2])+0.44*circshift(H1,[0 0 0 -3])+0.06*circshift(H1,[0 0 0 -4]);
end

else
    Hhx=0;
end

Rhx=Whx+TVh+Hhx;
end



