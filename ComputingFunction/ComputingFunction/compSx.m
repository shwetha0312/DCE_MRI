function Sx=compSx(x,sMaps,opt)
% function to calculate S*x
% input is the single frame(coil) image
% output is the multi frame(coil) images
% 2013/05/07 Yi Guo

Sx=sMaps.*repmat(x,[1 1 opt.coils]);

% Sx=Sx(:);
end
