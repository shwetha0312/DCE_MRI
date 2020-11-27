function Rhx=compRhx4d_T(x,opt,fsize)
% function to calculate Rhx
% this one with 4d TV
% 08/15/2013

if nargin==2
    fsize=0;
end
    
begin=1;

kx=opt.size(1);
ky=opt.size(2);
kz=opt.size(3);
nt=opt.size(4);

NL=kx*ky*kz*nt;

TV1=reshape(x(begin:begin+NL-1),kx,ky,kz,nt); % split the vecotr back to TV coefficient
begin=begin+NL;

TV2=reshape(x(begin:begin+NL-1),kx,ky,kz,nt);
begin=begin+NL;

TV3=reshape(x(begin:begin+NL-1),kx,ky,kz,nt);
begin=begin+NL;

TV4=reshape(x(begin:begin+NL-1),kx,ky,kz,nt);


TVh1=TV1-circshift(TV1,[-1 0 0 0]);
TVh2=TV2-circshift(TV2,[0 -1 0 0]);
TVh3=TV3-circshift(TV3,[0 0 -1 0]);
TVh4=TV4-circshift(TV4,[0 0 0 -1]);

Rhx=TVh1+TVh2+TVh3+TVh4;
end



