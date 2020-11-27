function Shx=compShx3d(kU,sMaps,opt)
% function to calculate Sh*x
% input is the multicoil kspace
% 2013/05/07 Yi Guo

% modified to do 3d 05/15

kU=reshape(kU,opt.kx,opt.ky,opt.kz,opt.coils);
x=conj(sMaps).*kU;

Shx=sum(x,4);
% Shx=x(:);
end