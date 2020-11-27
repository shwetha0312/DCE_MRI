function SFb=compSFb(kU,sMaps,opt)
% function to calculate S'*DFT'*U'*kU
% change U1 to be single coil
% 2013/05/07 Yi Guo

b1=conj(sMaps).*ifftnd(kU,opt.dim);

SFb=sum(b1,3);
end