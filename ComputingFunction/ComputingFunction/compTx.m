function Tx=compTx(x,opt)
% C-based function to calculate 2d TV transform
% x is the same size with final image
% Yi Guo 05/05/2013

img=reshape(x,opt.size(1),opt.size(2));
FD=fFD(img,[1 2]);
Tx1=FD{1}.fd;
Tx2=FD{2}.fd;
Tx=[Tx1(:);Tx2(:)];
end