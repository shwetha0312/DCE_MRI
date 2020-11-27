function RFx=compRFx4d(x,opt)

x_p=reshape(x,opt.kx,opt.ky,opt.kz,opt.nt);
RFx=x_p-opt.ref;
RFx=RFx(:);
end
