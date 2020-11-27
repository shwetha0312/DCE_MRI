N=256;
opt.kx=N;
opt.ky=N;

img=phantom(N);
w=compWx(img,opt);
imgr=compWhx(w,opt);
showim(reshape(compWhWx(img,opt),N,N))

% showim()

% showim(reshape(w,258,258));