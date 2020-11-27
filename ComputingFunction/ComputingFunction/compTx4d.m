function Tx=compTx4d(x,opt)
% img=reshape(x,opt.kx,opt.ky,opt.kz,opt.nt);

FD=fFD(x,[1 2 3]);
Tx1=FD{1}.fd;
Tx2=FD{2}.fd;
Tx3=FD{3}.fd;
Tx=[Tx1(:);Tx2(:);Tx3(:)];
end