function TVh=compThx3d1(TV,opt)
% function to calculate Total variance T'x in vectors
% 05/17/2013 Yi Guo

NL=opt.kx*opt.ky*opt.kz;

TV1=reshape(TV(1:NL),opt.kx,opt.ky,opt.kz); % split the vecotr back to TV coefficient
TV2=reshape(TV(NL+1:2*NL),opt.kx,opt.ky,opt.kz);
TV3=reshape(TV(2*NL+1:3*NL),opt.kx,opt.ky,opt.kz);


TVh1=circshift(TV1,[1 0 0])-TV1;
TVh2=circshift(TV2,[0 1 0])-TV2;
TVh3=circshift(TV3,[0 0 1])-TV3;

TVh=TVh1+TVh2+TVh3;
% TVh=TVh(:);

end
