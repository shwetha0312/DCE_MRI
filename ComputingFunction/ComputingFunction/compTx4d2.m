function Tx=compTx4d2(x,opt)
img=reshape(x,opt.kx,opt.ky,opt.kz,opt.nt);

FD=fFD(img,[1 2 3 4]);
Tx1=FD{1}.fd;
Tx2=FD{2}.fd;
Tx3=FD{3}.fd;
Tx4=FD{4}.fd;
Tx=[Tx1(:);Tx2(:);Tx3(:);Tx4(:)];
end