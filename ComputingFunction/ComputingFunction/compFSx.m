function FSx=compFSx(x,sMaps,U1,opt)
% function to calculate U*F*S*x
% 2013/05/07 Yi Guo

x_k=reshape(x,opt.kx,opt.ky);
kU=zeros(opt.kx,opt.ky,opt.coils);

for ic=1:opt.coils
kU(:,:,ic)=U1.*fft2(sMaps(:,:,ic).*x_k);
end

FSx=kU(:);
end
