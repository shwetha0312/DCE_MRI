function TVh=compThx2d(TV,opt)
% C-based function to calculate 2d TV transform
% x is the same size with final image
% Yi Guo 05/05/2013

NL=opt.size(1)*opt.size(2);

TV1=reshape(TV(1:NL),opt.size(1),opt.size(2)); % split the vecotr back to TV coefficient
TV2=reshape(TV(NL+1:end),opt.size(1),opt.size(2));

TVh1=circshift(TV1,[1 0])-TV1;
TVh2=circshift(TV2,[0 1])-TV2;

% TVh1=circshift(TV1,[-1 0])-TV1;
% TVh2=circshift(TV2,[0 -1])-TV2;

%TVh = [TVh1 TVh2];
TVh=TVh1+TVh2;
% TVh=TVh(:);

end