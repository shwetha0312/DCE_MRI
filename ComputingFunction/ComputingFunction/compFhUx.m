function FhUx=compFhUx(kU,U1,opt)
% function to calculate F'U'*x
% input is the multicoil kspace
% change U1 to be single coil
% 2013/05/07 Yi Guo

kU=reshape(kU,opt.kx,opt.ky,opt.coils);
x=zeros(opt.kx,opt.ky,opt.coils);

for ic=1:opt.coils
x(:,:,ic)=ifft2(U1.*kU(:,:,ic));
end

FhUx=x;
% FhUx=sum(x,3);
% FhUx=FhUx(:);
end
