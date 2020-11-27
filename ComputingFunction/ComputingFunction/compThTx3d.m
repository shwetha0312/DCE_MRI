function ThTx=compThTx3d(x,opt)
% function to calculate 3d T'Tx
% input is the 3d image
% Yi Guo 05/17/2013

img=reshape(x,opt.kx,opt.ky,opt.kz);
ThTx=iFD(fFD(img,[1 2 3]),[1 2 3]);
ThTx=ThTx(:);
end