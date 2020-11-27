function Shx=compShx(Is,sMaps,opt)
% function to calculate Sh*x
% input is the multicoil kspace
% 2013/05/07 Yi Guo

Shx=conj(sMaps).*Is;
Shx=sum(Shx,3);
% Shx=x(:);
end