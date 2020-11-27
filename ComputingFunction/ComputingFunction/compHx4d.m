function HFx=compHx4d(x,opt)
img=reshape(x,opt.kx,opt.ky,opt.kz,opt.nt);
h=[0.06,0.44,-1,0.44,0.06];
H=zeros(opt.kx,opt.ky,opt.kz,opt.nt);
H(1,1,1,1:5)=h;
HFx=ifftn(fftn(img).*fftn(H));
HFx=HFx(:);
end