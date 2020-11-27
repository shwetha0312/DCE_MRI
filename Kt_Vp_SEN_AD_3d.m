%% load data
close all; 
clc; 
R=100; %under-sampling rate


addpath(genpath('minFunc_2012'));
load DCE50_0402

% load T1_0402
% load res1700
% load phantom_data.mat;

ns=1; % choose one slice of k-space
k=k(:,:,ns,:,:);
opt.size=size(k);  
[kx,ky,kz,nt,ncoil]=size(k);

% Normalizing the dataset
d=sqrt(kx*ky);
opt.d=d;
k=k./d;

Ns=kx*ky*kz;

sMaps=sMaps(:,:,ns,:,:);
sMaps=reshape(sMaps,[kx ky 1 1 ncoil]);

if ~exist('R1','var')  % use simulated uniform M0 and R1 if none exists
M0=5*ones(kx,ky,'single'); %use simulated M0, R1
R1=ones(kx,ky,'single');
end

imgF=sum(conj(repmat(sMaps,[1 1 1 nt 1])).*(ifft2(k).*d),5);

%% set parameters
% opt.mask1=mask1;
opt.wname='db4'; % wavelet parameters
opt.worder={[1 2],[1 2],[1 2]};
opt.R1=R1;
opt.M0=M0;
opt.Sb=repmat(imgF(:,:,:,1),[1 1 1 nt]);  %baseline image
opt.alpha=pi*15/180; %flip angle
opt.TR=0.006;  %TR

delay=8; % delay frames for contrast injection
tpres=5/60; % temporal resolution, unit in seconds!
opt.time=[zeros(1,delay),[1:(nt-delay)]*tpres];
opt.plot=1;  % to plot intermediate images during recon
%e=10^(-3);
e=0;
disp(e)
opt.lambdaA=[e 0.000 e 0.000 e 0.000]; % Kt:TV, Wavelet, Kep: TV, wavelet, Vp: TV, wavelet
opt.Initer=10;  %inter interations
opt.Outiter=10; % outer interations

opt.AIF=SAIF_p(opt.time);
hct = 0.4;  
opt.AIF = opt.AIF(:)./(1-hct); 

%% calculate fully-sampled Ktrans Kep and Vp for showing in output

CONCF=sig2conc2(real(imgF),R1,M0,opt.alpha,opt.TR);
concs=reshape(CONCF,[Ns,nt]);

%% undersamping by RGR

[~, U11] = genRGA(220, 220, kx,ky, round(kx*ky/R*nt), bin2dec('0001'), 0, nt);
U1=reshape(nshift(U11>0,[1 2]),[kx,ky,1,nt]);
U1=repmat(U1,[1 1 1 1 ncoil]);
U1(:,:,:,1,:)=1;
if R==1
    U1=ones(kx,ky,1,nt,ncoil);
end
kU=k.*U1;

Ns=kx*ky*kz;
imgU=sum(conj(repmat(sMaps,[1 1 1 nt 1])).*(ifft2(kU).*d),5);
CONC1 =sig2conc2(real(imgU),R1,M0,opt.alpha,opt.TR); 

%patlak modelling to get initial values of Ktrans and Vp for etofts model
% [Kt_U,Vp_U]=conc2Ktrans(CONC1,opt.time,opt.AIF);

options.MaxIter=10; % options for l-bfgs iteration for solving etofts maps
options.display = 'off';
options.Method ='lbfgs';
options.useMex=0;
options.inter=0;

%%
%Direct reconstruction

%initial values are zeroes
Kep_1=zeros(opt.size(1),opt.size(2)); 
Vp_1=Kep_1;
Kt_1=Kep_1;

% Vp_1=VpU;
% Kt_1=KtU;

tic,
[Kt_r1,Vp_r1,Kep_r1,iter,fres]=Kt_Vp_Kep_SEN(Kt_1,Vp_1,Kep_1,sMaps,U1,kU,opt);
% [Kt_r1,Vp_r1,Kep_r1,iter,fres]=Kt_Vp_SEN(Kt_1,Vp_1,Kep_1,sMaps,U1,kU,opt);
toc,

iter,

% display results
c=jet(256);
figure;
subplot(1,3,1); imagesc(Kt_r1,[0 0.1]); title('Ktrans'); colormap(jet);axis image; axis off;
subplot(1,3,2); imagesc(Vp_r1/2,[0 0.1]); title('Vp');colormap(jet);axis image; axis off
subplot(1,3,3); imagesc(Kep_r1,[0 0.1]); title('Kep');colormap(jet);axis image; axis off;
 

figure;
plot(fres);title('Objective function changes over iteration');
xlabel('Iteration'); ylabel('Objective function value');

%%

%removing negative values
Kt_r1(Kt_r1<0)=0;
Kep_r1(Kep_r1<0)=0;
Vp_r1(Vp_r1<0)=0;
%% 
%ignore

% % Ct = model_extended_tofts_s(real(Kt_r1), real(Kep_r1),real(Vp_r1),opt.AIF,opt.time);
% % 
% % error=power(norm(concs-Ct)/norm(concs),2)*100;
% % disp(error);
% % 
% % thresh=[0.5 0.1 0.05 0.01];
% % mis=zeros(4,1);
% % for i=1:4
% %     mis(i)=compareconc(concs,Ct,thresh(i));
% % end
% % concs=double(concs);
% % 
% % error1wc=sqrt(immse(concs,Ct));
% % 
% % Ct(Ct>180)=0;
% % Ct(Ct<0)=0;
% % 
% % error2c=sqrt(immse(concs,Ct));
% % savefilename = strcat('R',num2str(R),'_',options.Method,'_stogether2.mat');
% % cd('data2')
% % save(savefilename,'concs','CONCF','CONC1','U1','thresh','Kt_r1','Kep_r1','Vp_r1','fres','mis','error1wc','error2c','error');
% % cd ..
% % 

% % colormap(jet)