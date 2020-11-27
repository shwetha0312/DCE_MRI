function WhWx=compWhWx(x,opt)
img=reshape(x,opt.kx,opt.ky);
WhWx=iwtN(fwtN(img,'db2',[1 2]),'db2',[1 2]);
WhWx=WhWx(:);
end

