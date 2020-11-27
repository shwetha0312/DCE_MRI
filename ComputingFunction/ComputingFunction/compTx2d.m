function TV=compTx2d(x,opt)
% C-based function to calculate 2d TV transform
% x is the same size with final image
% Yi Guo 05/05/2013

img=reshape(x,opt.size(1),opt.size(2));

TV1=circshift(img,[-1 0])-img;
TV2=circshift(img,[0 -1])-img;

TV=[TV1(:);TV2(:)];

end