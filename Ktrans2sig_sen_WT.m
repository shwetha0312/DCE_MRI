function [cost,grad]=Ktrans2sig_sen_WT(Kt,sMaps,U1,kU,opt)
% Least-square equation and L1 wavelet with direvative calculation
% from Ktrans to Kspace
% Yi Guo, 06/12/2014
%input given is a vector of 256*150

% add TV constraint and sensitivity maps
%cwr, reemebr if u get confused


%% Calculate cost function
Rcs=4.39;
alpha=opt.alpha;
TR=opt.TR;

Kt=reshape(Kt,[opt.size(1) opt.size(2)]);
nt=opt.size(4);

CR=model_extended_tofts_s(Kt(:),opt.Kep(:),opt.Vp(:),opt.AIF,opt.time); 
CR1=reshape(CR,[opt.size(1) opt.size(2) opt.size(3) opt.size(4)]);
S = conc2sig(CR1,opt.R1,opt.M0,opt.Sb,alpha,opt.TR);
S=U1.*fft2(repmat(sMaps,[1 1 1 nt 1]).*repmat(S,[1 1 1 1 8]))./opt.d;
cost1=0.5*sum(abs(S(:)-kU(:)).^2);

if opt.lambda1~=0 % calculate lambda1*||TVx||1
TV=compTx2d(Kt,opt);
cost2=opt.lambda1*sum(abs(TV(:)));
else
    cost2=0;
end

if opt.lambda2~=0  % calculate lambda2*||Wx||1
[wc,fsize]=compWx(Kt,opt);
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

Ns=(opt.size(1)*opt.size(2));
dCdKt=zeros(Ns,nt);
Cp=opt.AIF;
dtime=diff(opt.time);
dtime=dtime(20);
tmodel=opt.time(:);
Cp=Cp(:);
for k = 1:nt 
    
    % The time for T
    Tc = tmodel(1:k);
    Tc=repmat(Tc',[Ns,1]);
   
    
    Cp1= Cp(1:k);
    Cp1=repmat(Cp1',[Ns,1]);
        
    Kep2=opt.Kep(:);
    Kep1=repmat(Kep2,[1,k]);

    
    Fkt = Cp1.*exp(-Kep1.*(Tc(end)-Tc));
    dCdKt(:,k)=sum(Fkt,2)*dtime;
end

g=dBdC.*repmat(opt.M0,[1 1 1 nt]).*sin(alpha).*((sum(repmat(conj(sMaps),[1 1 1 nt 1]).*ifft2(S-kU).*opt.d,5)));

%dCdKt=cumsum(dCdKt,2); 
%dCdKt=sum(dCdKt,2);

%dCdKt=reshape(dCdKt,[opt.size(1) opt.size(2) 1 nt]);
dCdKt=reshape(dCdKt,[opt.size(1) opt.size(2) nt]);

g1=zeros(opt.size(1),opt.size(2));
%i want final result as 256  x 150 rn
%%g1=256 x 150
for it=1:nt
%g1=g1+g(:,:,:,it).*dCdKt(:,:,:,it);
g1=g1+g(:,:,:,it).*dCdKt(:,:,it);
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

