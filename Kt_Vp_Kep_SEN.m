function [Kt,Vp,Kep,iter,fres]=Kt_Vp_Kep_SEN(Kt,Vp,Kep,sMaps,U1,kU,opt)

options.MaxIter=opt.Initer;
options.display = 'off';
options.Method ='lbfgs';
% use l-BFGS method in minFunc
%options.optTol=1e-3;
%options.progTol=5e-4;
options.useMex=0;
options.inter=0;
options.numDiff=0;
% options.DerivativeCheck='on';
Ns=opt.size(1)*opt.size(2);
kx=opt.size(1);
ky=opt.size(2);
exitflag=0;
iter=1;
fres=[];
count=50; %controls number of iterations 
A=[Kt(:); Kep(:); Vp(:)];
c=jet(256);
% mask1=opt.mask1;

while(exitflag==0)

    count=count-1;
    opt.lambda1=opt.lambdaA(1);
    opt.lambda2=opt.lambdaA(2);
    opt.lambda3=opt.lambdaA(3);
    opt.lambda4=opt.lambdaA(4);
    opt.lambda5=opt.lambdaA(5);
    opt.lambda6=opt.lambdaA(6);
    
    [A,f1,exitflag,~]=minFunc(@allparamsmodd,A(:),options,sMaps,U1,kU,opt);
    
    fres=[fres;f1]; %#ok<AGROW>
    
    Kt=A(1:Ns);
    Kep=A(Ns+1:2*Ns);
    Vp=A(2*Ns+1:3*Ns);

    Kt=reshape(real(Kt),[opt.size(1) opt.size(2)]);
    Vp=reshape(real(Vp),[opt.size(1) opt.size(2)]);
    Kep=reshape(real(Kep),[opt.size(1) opt.size(2)]);
    
%      Kt1=zeros(kx,ky);
%      Kep1=Kt; 
%      Vp1=Kt;
%         Kt1(mask1)=Kt(mask1);
%         Kep1(mask1)=Kep(mask1);
%         Vp1(mask1)=Vp(mask1);

    if opt.plot
    imagesc(real(cat(2,Kt,Kep/2,Vp/2)),[0 0.1]);axis image; axis off; zoom on;

%     imagesc(real(cat(2,Kt1,Kep1,Vp1/2)),[0 0.1]);axis image; axis off; zoom on;
    title(['Ktrans, Kep , Vp/2, Out iter=',num2str(iter)]);colormap(c); 
    drawnow;
    end

    
  

    iter=iter+1;
%     if iter>3
%       if(fres(end)-fres(end-1)~=0)
%         exitflag=0;
%       end
%     else
%         exitflag=0;
%     end
%     

if count>0
    exitflag=0;
end

end


end