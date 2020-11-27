function Whx=compWhx3d(x,opt)
% a function handle to operate wavelet in vectors
% calculate Q'*x, x needs to be the length of the wavelet output
% 05/03/2013 Yi Guo

% update 05/17 to do 3d

wlx=floor(opt.kx/2)+1;
wly=floor(opt.ky/2)+1;
wlz=floor(opt.kz/2)+1;

wlx1=floor(opt.kx/4)+2;
wly1=floor(opt.ky/4)+2;

WLL=wlx*wly*wlz;
WLL2=wlx1*wly1*wlz;

x1=[];
x2=x(1:WLL); % split the vector to wavelet coeffient
x3=x(WLL+1:2*WLL);
x4=x(2*WLL+1:3*WLL);
x5=x(3*WLL+1:4*WLL);
x6=x(4*WLL+1:5*WLL);
x7=x(5*WLL+1:6*WLL);
x8=x(6*WLL+1:7*WLL);

x21=x(7*WLL+1:7*WLL+WLL2);
x22=x(7*WLL+WLL2+1:7*WLL+2*WLL2);
x23=x(7*WLL+WLL2*2+1:7*WLL+3*WLL2);
x24=x(7*WLL+WLL2*3+1:end);

wc{1}.AAA=x1;
wc{1}.AAD=reshape(x2,wlx,wly,wlz);
wc{1}.ADA=reshape(x3,wlx,wly,wlz);
wc{1}.ADD=reshape(x4,wlx,wly,wlz);
wc{1}.DAA=reshape(x5,wlx,wly,wlz);
wc{1}.DAD=reshape(x6,wlx,wly,wlz);
wc{1}.DDA=reshape(x7,wlx,wly,wlz);
wc{1}.DDD=reshape(x8,wlx,wly,wlz);
wc{2}.AA=reshape(x21,wlx1,wly1,wlz);
wc{2}.AD=reshape(x22,wlx1,wly1,wlz);
wc{2}.DA=reshape(x23,wlx1,wly1,wlz);
wc{2}.DD=reshape(x24,wlx1,wly1,wlz);

wc{1}.odd_dims=[0,0,0];
wc{2}.odd_dims=[mod(wlx,2),mod(wly,2),mod(wlz,2)];

Whx = iwtN(wc,'db2',{[1 2 3],[1 2]});
% Whx=Whx(:);
end