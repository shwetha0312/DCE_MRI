function [obj,obj1,obj2]=obj_comp(x,kU,sMaps,opt)
% sMaps=squeeze(sMaps);

obj1=fftnd(compSx2(x,sMaps,opt.size),opt.dim);
obj1=obj1(opt.U)-kU;
obj1=sum((abs(obj1(:))).^2);
obj2=opt.beta2*compRx4d(x,opt);
obj2=sum(abs(obj2(:)));

obj=obj1+obj2;
end
