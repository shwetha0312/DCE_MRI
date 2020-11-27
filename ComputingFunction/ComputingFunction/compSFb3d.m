function SFb=compSFb3d(k1U,sMaps,opt)
% function to calculate S'*DFT'*U'*kU
% U1 needs to be multi-coil
% 2013/05/07 Yi Guo

% modified 05/17 to 3d

% k1U=reshape(k1U,opt.kx,opt.ky,opt.kz,opt.coils);

b1=conj(sMaps).*ifftnd(k1U,opt.dim);

SFb=sum(b1,4);
% SFb=SFb(:);
end