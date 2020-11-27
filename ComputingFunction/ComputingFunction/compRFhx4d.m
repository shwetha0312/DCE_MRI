function RFhx=compRFhx4d(x,opt)

x_p=reshape(x,opt.kx,opt.ky,opt.kz,opt.nt);
RFhx=x_p+opt.ref;
% RFhx=RFhx(:);
end
