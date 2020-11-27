function Thx=compThx4d1(x,opt)

NL=opt.kx*opt.ky*opt.kz*opt.nt;
begin=1;

TV1=reshape(x(begin:begin+NL-1),opt.kx,opt.ky,opt.kz,opt.nt); % split the vecotr back to TV coefficient
begin=begin+NL;

TV2=reshape(x(begin:begin+NL-1),opt.kx,opt.ky,opt.kz,opt.nt);
begin=begin+NL;

TV3=reshape(x(begin:begin+NL-1),opt.kx,opt.ky,opt.kz,opt.nt);
begin=begin+NL;

% TV4=reshape(x(begin:begin+NL-1),opt.kx,opt.ky,opt.kz,opt.nt);

TVh1=TV1-circshift(TV1,[-1 0 0 0]);
TVh2=TV2-circshift(TV2,[0 -1 0 0]);
TVh3=TV3-circshift(TV3,[0 0 -1 0]);
% TVh4=TV4-circshift(TV4,[0 0 0 -1]);

Thx=TVh1+TVh2+TVh3;
end