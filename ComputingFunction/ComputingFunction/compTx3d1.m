function Tx=compTx3d1(x,opt)
img=reshape(x,opt.kx,opt.ky,opt.kz);

TV1=circshift(img,[-1 0 0])-img;
TV2=circshift(img,[0 -1 0])-img;
TV3=circshift(img,[0 0 -1])-img;

Tx=[TV1(:);TV2(:);TV3(:)];
end