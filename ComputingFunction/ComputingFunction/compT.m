function Tx=compT(x,h,flag)
% convolution through fft
% flag if the conjugate operator
N1=256;

if nargin==1
    h=[1;-1];
    flag=0;
end

x_k=reshape(x,N1,N1);
kx_k=fft2(x_k);
x_k1=ifft2(kx_k.*fft2(h,N1,N1));
if flag==1
    x_k1=circshift(x_k1,-1);
end

if flag==2
    x_k1=circshift(x_k1,[0 -1]);
end
Tx=x_k1(:);
end