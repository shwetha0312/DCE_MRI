function [Rx,fsize,LL]=compRx4d_T(x,opt)
% Rx function with only 4d TV
fsize=0;

% Calculate Total variation using shift difference
TV1=x-circshift(x,[1 0 0 0]);
TV2=x-circshift(x,[0 1 0 0]);
TV3=x-circshift(x,[0 0 1 0]);
TV4=x-circshift(x,[0 0 0 1]);

Rx=[TV1(:);TV2(:);TV3(:);TV4(:)];

LL(1)=0;
LL(2)=length(Rx);
LL(3)=0;

end