%load the result mat file you want to see
%change R values
%R is the undersampling rate
load R20_lbfgs_stogether
figure(1)
imagesc(Kt_r1,[0 0.1]); title('Ktrans'); colormap(parula);axis image; axis off;
figure(2)
imagesc(Vp_r1/2,[0 0.1]); title('Vp'); colormap(parula);axis image; axis off;
figure(3)
imagesc(Kep_r1,[0 0.1]); title('Kep'); colormap(parula);axis image; axis off;
