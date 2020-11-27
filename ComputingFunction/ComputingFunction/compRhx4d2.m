function Rhx=compRhx4d2(x,opt,fsize)


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


NL=opt.kx*opt.ky*opt.kz*opt.nt;

TV1=reshape(x(begin:begin+NL-1),opt.kx,opt.ky,opt.kz,opt.nt); % split the vecotr back to TV coefficient
begin=begin+NL;

TV2=reshape(x(begin:begin+NL-1),opt.kx,opt.ky,opt.kz,opt.nt);
begin=begin+NL;

TV3=reshape(x(begin:begin+NL-1),opt.kx,opt.ky,opt.kz,opt.nt);
begin=begin+NL;

% TV4=reshape(x(begin:begin+NL-1),opt.kx,opt.ky,opt.kz,opt.nt);

TVh1=TV1-circshift(TV1,[-1 0 0 0]);
TVh2=TV2-circshift(TV2,[0 -1 0 0]);
TVh3=TV3-circshift(TV3,[0 0 -1 0]);
% TVh4=TV4-circshift(TV4,[0 0 0 -1]);

Rhx=Whx+TVh1+TVh2+TVh3;
% +TVh4;
end



