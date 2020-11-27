function Rhx=compRhx4dtediousback(x,opt)
nt=opt.nt;
wlx=floor(opt.kx/2)+1;
wly=floor(opt.ky/2)+1;
wlz=floor(opt.kz/2)+1;

wlx1=floor(opt.kx/4)+2;
wly1=floor(opt.ky/4)+2;

WLL=wlx*wly*wlz*nt;
WLL2=wlx1*wly1*wlz*nt;

x1=[];
x2=x(1:WLL); % split the vector to wavelet coeffient
x3=x(WLL+1:2*WLL);
x4=x(2*WLL+1:3*WLL);
x5=x(3*WLL+1:4*WLL);
x6=x(4*WLL+1:5*WLL);
x7=x(5*WLL+1:6*WLL);
x8=x(6*WLL+1:7*WLL);

x21=x(7*WLL+1:7*WLL+WLL2);
x22=x(7*WLL+WLL2+1:7*WLL+WLL2*2);
x23=x(7*WLL+WLL2*2+1:7*WLL+WLL2*3);
x24=x(7*WLL+WLL2*3+1:7*WLL+WLL2*4);

wc{1}.AAA=x1;
wc{1}.AAD=reshape(x2,wlx,wly,wlz,nt);
wc{1}.ADA=reshape(x3,wlx,wly,wlz,nt);
wc{1}.ADD=reshape(x4,wlx,wly,wlz,nt);
wc{1}.DAA=reshape(x5,wlx,wly,wlz,nt);
wc{1}.DAD=reshape(x6,wlx,wly,wlz,nt);
wc{1}.DDA=reshape(x7,wlx,wly,wlz,nt);
wc{1}.DDD=reshape(x8,wlx,wly,wlz,nt);
wc{2}.AA=reshape(x21,wlx1,wly1,wlz,nt);
wc{2}.AD=reshape(x22,wlx1,wly1,wlz,nt);
wc{2}.DA=reshape(x23,wlx1,wly1,wlz,nt);
wc{2}.DD=reshape(x24,wlx1,wly1,wlz,nt);

wc{1}.odd_dims=[mod(opt.kx,2),mod(opt.ky,2),mod(opt.kz,2),mod(opt.nt,2)];
wc{2}.odd_dims=[mod(wlx,2),mod(wly,2),mod(wlz,2),mod(opt.nt,2)];

NL=opt.kx*opt.ky*opt.kz*opt.nt;
WL=7*WLL+WLL2*4;

TV1=reshape(x(WL+1:WL+NL),opt.kx,opt.ky,opt.kz,opt.nt); % split the vecotr back to TV coefficient
TV2=reshape(x(WL+NL+1:WL+2*NL),opt.kx,opt.ky,opt.kz,opt.nt);
TV3=reshape(x(WL+2*NL+1:WL+3*NL),opt.kx,opt.ky,opt.kz,opt.nt);
% TV4=reshape(x(WL+3*NL+1:WL+4*NL),opt.kx,opt.ky,opt.kz,opt.nt);


TVh1=circshift(TV1,[1 0 0 0])-TV1;
TVh2=circshift(TV2,[0 1 0 0])-TV2;
TVh3=circshift(TV3,[0 0 1 0])-TV3;
% TVh4=circshift(TV4,[0 0 0 1])-TV4;

% TVh4(:,:,:,1)=0;

Whx = iwtN(wc,'db2',{[1 2 3],[1 2]});

H1=reshape(x(WL+3*NL+1:end),opt.kx,opt.ky,opt.kz,opt.nt);

% HH=zeros(opt.kx,opt.ky,opt.kz,opt.nt+6);
% xz=HH;
% HH(1,1,1,1:5)=[0.06 0.44 -1 0.44 0.06];
% xz(:,:,:,4:opt.nt+3)=H1;
% Hx=ifftn(fftn(HH).*fftn(xz));
% Hx=circshift(Hx,[0 0 0 -4]);
% Hhx=Hx(:,:,:,4:opt.nt+3);

HH=zeros(opt.kx,opt.ky,opt.kz,opt.nt);
HH(1,1,1,1:5)=[0.06 0.44 -1 0.44 0.06];
Hhx=ifftn(fftn(HH).*fftn(H1));
Hhx=circshift(Hhx,[0 0 0 -4]);

Rhx=Whx+TVh1+TVh2+TVh3+Hhx;
end



