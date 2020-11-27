function img=comp_img0(k,sMaps,opt)
kU = zeros(opt.size,'single');
kU(opt.U) = k;
km = mean(kU,4)./(mean(kU~=0,4) + eps);

% U2=sum(U1,4);
% U2(U2==0)=1;
% km=sum(kU,4)./U2; % average time frame to get calibration data

% km=squeeze(sum(kU,4)./sum(kU~=0,4)); % use this to average
imgM = ifftnd(km,opt.dim);

img=sum(conj(sMaps).*imgM,5);

% img=single(img);

end