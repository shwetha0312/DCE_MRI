function Thx=compThx4d(x,opt)
% function to calculate Total variance T'x in vectors
% 05/17/2013 Yi Guo

NL=opt.kx*opt.ky*opt.kz*opt.nt;

FD{1}.fd=reshape(x(1:NL),opt.kx,opt.ky,opt.kz,opt.nt); % split vector to TV coefficient
FD{2}.fd=reshape(x(NL+1:2*NL),opt.kx,opt.ky,opt.kz,opt.nt);
FD{3}.fd=reshape(x(2*NL+1:end),opt.kx,opt.ky,opt.kz,opt.nt);

Thx=iFD(FD,[1 2 3]);
% Thx=Thx(:);
end
