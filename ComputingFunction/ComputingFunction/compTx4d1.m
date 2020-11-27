function Tx=compTx4d1(x,opt)
TV1=x-circshift(x,[1 0 0 0]);
TV2=x-circshift(x,[0 1 0 0]);
TV3=x-circshift(x,[0 0 1 0]);
% TV4=x-circshift(x,[0 0 0 1]);

Tx=[TV1(:);TV2(:);TV3(:)];

end
