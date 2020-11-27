function Thx=compThx(x,opt)
% function to calculate T'x using C-based function
% input should be the length of Tx, that is ,after TV transform of the
% original image

% Yi Guo 05/05/2013

kx=opt.size(1);
ky=opt.size(2);
NL=kx*ky;

FD{1}.fd=reshape(x(1:NL),kx,ky); % split the vecotr back to TV coefficient
FD{2}.fd=reshape(x(NL+1:end),kx,ky);
Thx=iFD(FD,[1 2]);
% Thx=Thx(:);
end



