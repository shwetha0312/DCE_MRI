function [cost,grad]=Vp2sig_sen_WT(Vp,sMaps,U1,kU,opt)
% Least-square equation and L1 wavelet and TV with direvative calculation
% from Vp to Kspace

% Yi Guo, 06/12/2014

%% Calculate cost function
Rcs=4.39;
alpha=opt.alpha;
TR=opt.TR;

Vp=reshape(Vp,[opt.size(1) opt.size(2)]);
nt=opt.size(4);

CR=model_extended_tofts_s(opt.Kt,opt.Kep,Vp,opt.AIF,opt.time);
CR1=reshape(CR,[opt.size(1) opt.size(2) 1 opt.size(4)]);
S = conc2sig(CR1,opt.R1,opt.M0,opt.Sb,alpha,opt.TR);
S=U1.*fft2(repmat(sMaps,[1 1 1 nt 1]).*repmat(S,[1 1 1 1 8]))./opt.d;
cost1=0.5*sum(abs(S(:)-kU(:)).^2);

if opt.lambda1~=0 % calculate lambda1*||TVx||1
TV=compTx2d(Vp,opt);
cost2=opt.lambda1*sum(abs(TV(:)));
else
    cost2=0;
end

if opt.lambda2~=0  % calculate lambda2*||Wx||1
[wc,fsize]=compWx(Vp,opt);
cost3=opt.lambda2*sum(abs(wc(:)));
else
    cost3=0;
end
cost=cost1+cost2+cost3;

%% calculate gradient of cost function
Rt=CR1*Rcs+repmat(opt.R1,[1 1 1 nt]);

E1=exp(-Rt*TR);
dBdC=(TR*E1.*(1-cos(alpha).*E1)-(1-E1).*cos(alpha).*TR.*E1)./((1-cos(alpha).*E1).^2);
dBdC=dBdC.*Rcs;

g=dBdC.*repmat(opt.M0,[1 1 1 nt]).*sin(alpha).*((sum(repmat(conj(sMaps),[1 1 1 nt 1]).*ifft2(S-kU).*opt.d,5)));

g1=zeros(opt.size(1),opt.size(2));

for it=1:nt
g1=g1+g(:,:,:,it).*opt.AIF(it);
end

if opt.lambda1~=0
%     TV=compTx2d(Vp,opt);
u=1e-8;
W=sqrt(conj(TV).*TV+u);
W=1./W;
g2=opt.lambda1.*compThx2d(W.*TV,opt);
else
    g2=0;
end

if opt.lambda2~=0
%[wc,fsize]=compWx(Vp,opt);
u=1e-8;
W1=sqrt(conj(wc).*wc+u);
W1=1./W1;
g3=opt.lambda2.*compWhx(W1.*wc,opt,fsize);
else
    g3=0;
end
grad=g1+g2+g3;

grad=(grad(:));

end

