function [Rx,fsize,LL]=compRx4d_T2(x,opt)
% Rx function with only 4d TV
fsize=0;

% Calculate Total variation using shift difference
TV1=x-circshift(x,[1 0 0 0]);
TV2=x-circshift(x,[0 1 0 0]);


Rx=[TV1(:);TV2(:)];

LL(1)=0;
LL(2)=length(Rx);
LL(3)=0;

end