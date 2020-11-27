function Rhx=compRhx(x,opt,fsize)
% a function handle to operate wavelet in vectors
% calculate Q'*x, x needs to be the length of Qx, that is, after the
% wavelet transform

% 05/03/2013 Yi Guo

N = length(fsize);
wc=cell(1,N);

begin=1;
%   Loop through transform order and the various coefficients
for i = 1:N
    ft = fsize{i};
    fnames = fieldnames(ft);
    nf = size(fnames);
    for j = 1:nf
        fname = fnames{j};
        if ~strcmp(fname,'odd_dims') && ~strcmp(fname,'size') && ~strcmp(fname,'nd')
            ftsize = ft.(fname);
            sl=prod(ftsize);
            wc{i}.(fname)=reshape(x(begin:begin+sl-1),ftsize);
            begin=begin+sl;
        else
            wc{i}.(fname)=ft.(fname);
        end
    end
    
end

Whx = iwtN(wc,'db2',opt.worder);



NL=opt.kx*opt.ky;

TV1=reshape(x(begin:begin+NL-1),opt.kx,opt.ky); % split the vecotr back to TV coefficient
begin=begin+NL;

TV2=reshape(x(begin:begin+NL-1),opt.kx,opt.ky);


TVh1=circshift(TV1,[1 0])-TV1;
TVh2=circshift(TV2,[0 1])-TV2;

Rhx=Whx+TVh1+TVh2;


end