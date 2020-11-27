function Wx=compWx3d(x,opt)
% a function handle to operate wavelet in vectors
% calculate Q*x, x the same length of the final recon images
% 05/03/2013 Yi Guo


x_p=reshape(x,opt.kx,opt.ky,opt.kz);

wc=fwtN(x_p,'db2',{[1 2 3],[1 2]});

Wx=[wc{1}.AAA(:);wc{1}.AAD(:);wc{1}.ADA(:);wc{1}.ADD(:);...
     wc{1}.DAA(:);wc{1}.DAD(:);wc{1}.DDA(:);wc{1}.DDD(:);...
     wc{2}.AA(:);wc{2}.AD(:);wc{2}.DA(:);wc{2}.DD(:)];

end