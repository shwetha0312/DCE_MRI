function Sx=compSx3d(x,sMaps,opt)
% function to calculate S*x
% input is the single frame(coil) image
% output is the multi frame(coil) images
% 2013/05/07 Yi Guo

% update 05/17 to do 3d

x_k=reshape(x,opt.kx,opt.ky,opt.kz);
Sx=zeros(opt.kx,opt.ky,opt.kz,opt.coils);

for ic=1:opt.coils
Sx(:,:,:,ic)=sMaps(:,:,:,ic).*x_k;
end

% Sx=Sx(:);
end
