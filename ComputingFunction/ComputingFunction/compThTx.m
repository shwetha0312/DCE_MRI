function ThTx=compThTx(x,opt)
img=reshape(x,opt.kx,opt.ky);
ThTx=iFD(fFD(img,[1 2]),[1 2]);
ThTx=ThTx(:);
end