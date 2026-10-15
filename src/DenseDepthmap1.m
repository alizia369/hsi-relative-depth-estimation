function [ fullDMap ] = DenseDepthmap1( norlocalDmap,normat )
%DENSEDEPTHMAP1 Summary of this function goes here
%   Detailed explanation goes here
lambda=0.001;

constsMap=norlocalDmap>0.0001;

%%%%%%%%%%%%%%%%%%%%%
% OI(:,:,1)=normat(:,:,1);
% OI(:,:,2)=normat(:,:,17);
% OI(:,:,3)=normat(:,:,33);

sumcube=sum(normat,3);
minval_cube=min(sumcube(:));
maxval_cube=max(sumcube(:));
I=(sumcube-minval_cube)./(maxval_cube - minval_cube);

%%%%%%%%%%%%%%%%%

%[h,w,c]=size(OI);
[h,w,c]=size(I);

sizeI=w*h;

%L=getLaplacian(OI,1);
L=getLaplacian1(I,constsMap);

D=spdiags(constsMap(:),0,sizeI,sizeI);

%%%%Test
% sumcube=sum(normat,3);
% minval_cube=min(sumcube(:));
% maxval_cube=max(sumcube(:));
% norcubeimg=(sumcube-minval_cube)./(maxval_cube - minval_cube);
% 
% tL=spdiags(norcubeimg(:),0,h*w,h*w);
%%%% end Test

% try pcg if you get out of memory error using the \ solver
% x=pcg(L+lambda*D,lambda*D*sparseDMap(:),1e-6,1000); 

x=(L+lambda*D)\(lambda*D*norlocalDmap(:));%original
% x=(tL+norcubeimg(:)+lambda*D)\(lambda*D*norlocalDmap(:));

fullDMap=reshape(x,h,w);

end

