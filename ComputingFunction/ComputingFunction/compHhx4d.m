function Hhx=compHhx4d(x,opt)
img=reshape(x,opt.kx,opt.ky,opt.kz,opt.nt);



[~,~,ph4]=meshgrid(0:opt.kz-1,0:opt.ky-1,0:opt.nt-1);
ph4=repmat(ph4,[1 1 1 opt.kx]);
ph4=permute(ph4,[4 1 2 3]);
shift4=exp(1j*2*pi*ph4/opt.nt);

h=[0.06,0.44,-1,0.44,0.06];
H=zeros(opt.kx,opt.ky,opt.kz,opt.nt);
H(1,1,1,1:5)=h;
Hhx=ifftn(fftn(img).*fftn(H));
Hhx=circshift(Hhx,[0 0 0 -1]);

% Hhx=ifftn(fftn(img).*shift4.*fftn(H));

end