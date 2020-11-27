function [cost,grad]=allparamsmodd(A,sMaps,U1,kU,opt)
%% Calculate cost function
% Rcs=3.46;


Rcs=4.39;
alpha=opt.alpha;
TR=opt.TR;
Ns=opt.size(1)*opt.size(2);


Kt=A(1:Ns);
Kep=A(Ns+1:2*Ns);
Vp=A(2*Ns+1:3*Ns);


Kt=Kt(:);
Kep=Kep(:);
Vp=Vp(:);

nt=opt.size(4);

CR=model_extended_tofts_s(Kt,Kep,Vp,opt.AIF,opt.time); 
CR1=reshape(CR,[opt.size(1) opt.size(2) opt.size(3) opt.size(4)]);
S=conc2sig(CR1,opt.R1,opt.M0,opt.Sb,alpha,opt.TR);

ncoil=8;
% ncoil=1;

S=U1.*fft2(repmat(sMaps,[1 1 1 nt 1]).*repmat(S,[1 1 1 1 ncoil]))./opt.d;

cost1=0.5*sum(abs(S(:)-kU(:)).^2);


if opt.lambda1~=0 % calculate lambda1*||TVx||1
TV=compTx2d(Kt,opt);
cost2=opt.lambda1*sum(abs(TV(:)));
else
    cost2=0;
end

if opt.lambda3~=0 % calculate lambda1*||TVx||1
TV1=compTx2d(Kep,opt);
cost3=opt.lambda1*sum(abs(TV1(:)));
else
    cost3=0;
end

if opt.lambda5~=0 % calculate lambda1*||TVx||1
TV2=compTx2d(Vp,opt);
cost4=opt.lambda1*sum(abs(TV2(:)));
else
    cost4=0;
end
% cost2=0;
% cost3=0;

cost=cost1+cost2+cost3+cost4;


%% calculate gradient of cost function for all params


Rt=CR1*Rcs+repmat(opt.R1,[1 1 1 nt]);

E1=exp(-Rt*TR);
dBdC=(TR*E1.*(1-cos(alpha).*E1)-(1-E1).*cos(alpha).*TR.*E1)./((1-cos(alpha).*E1).^2);
dBdC=dBdC.*Rcs;
g=dBdC.*repmat(opt.M0,[1 1 1 nt]).*sin(alpha).*((sum(repmat(conj(sMaps),[1 1 1 nt 1]).*ifft2(S-kU).*opt.d,5)));


Ns=opt.size(1)*opt.size(2);
dCdKt=zeros(Ns,nt);
dCdKep=zeros(Ns,nt);
Cp=opt.AIF;
dtime=diff(opt.time);
dtime=dtime(20);
tmodel=opt.time(:);
Cp=Cp(:);

for k = 1:nt 
    
    % The time for T
    Tc =tmodel(1:k);
    Tc=repmat(Tc',[Ns,1]);
    
    Cp1= Cp(1:k);
    Cp1=repmat(Cp1',[Ns,1]);
    
    Kep1=repmat(Kep,[1,k]);
        
    Fkt = Cp1.*exp(-Kep1.*(Tc(end)-Tc));
    Fkep= -Cp1.*(Tc(end)-Tc).*exp(-Kep1.*(Tc(end)-Tc));

    
    dCdKep(:,k)=sum(Fkep,2).*dtime.*Kt(:);
    dCdKt(:,k)=sum(Fkt,2)*dtime;
end

 
dCdKt=reshape(dCdKt,[opt.size(1) opt.size(2) 1  nt]);
dCdKep=reshape(dCdKep,[opt.size(1) opt.size(2) 1 nt]);

g1=zeros(opt.size(1),opt.size(2));
h1=zeros(opt.size(1),opt.size(2));
i1=h1;

for it=1:nt
g1=g1+g(:,:,:,it).*dCdKt(:,:,:,it);
h1=h1+g(:,:,:,it).*dCdKep(:,:,:,it);
i1=i1+g(:,:,:,it).*opt.AIF(it);
end

if opt.lambda1~=0
u=1e-8;
W=sqrt(conj(TV).*TV+u);
W=1./W;
g2=opt.lambda1.*compThx2d(W.*TV,opt);
else
    g2=0;
end

if opt.lambda3~=0
u=1e-8;
W=sqrt(conj(TV1).*TV1+u);
W=1./W;
h2=opt.lambda1.*compThx2d(W.*TV1,opt);
else
    h2=0;
end

if opt.lambda5~=0
u=1e-8;
W=sqrt(conj(TV2).*TV2+u);
W=1./W;
i2=opt.lambda1.*compThx2d(W.*TV2,opt);
else
    i2=0;
end

% g2=0;
g3=0;
% h2=0;
h3=0;
% i2=0;
i3=0;

grad1=g1+g2+g3;
grad2=h1+h2+h3;
grad3=i1+i2+i3;
grad=[grad1(:);grad2(:);grad3(:)];
% grad=[grad1(:);grad3(:);grad2(:)];
end