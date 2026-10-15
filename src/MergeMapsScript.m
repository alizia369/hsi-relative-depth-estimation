
%m1='.\data\Depth Estimation\labData\board2_f-8\Map1_hist.mat';
%m2='.\data\Depth Estimation\labData\board2_f-8\Map2_sumdiff.mat';

% m1/m2 can be set by run_relative_depth.m before this script is called
if ~exist('m1','var') || ~exist('m2','var')
m1='.\data\Depth Estimation\rooftop hyper\penswall_exp500\Map1_hist.mat';
m2='.\data\Depth Estimation\rooftop hyper\penswall_exp500\Map2_sumdiff.mat';
end

sarray1=load(m1);
sarray2=load(m2);

map1_hist=sarray1.localdepthmap;
map2_sum=sarray2.spmapsdiff;

[ map1_hist ] = removeextremeValues( map1_hist );
[ map2_sum ] = removeextremeValues( map2_sum );

maxval_map1=max(map1_hist(:));
minval_map1=min(map1_hist(:));
nor_map1_hist=(map1_hist-minval_map1)./(maxval_map1 - minval_map1);

maxval_map2=max(map2_sum(:));
minval_map2=min(map2_sum(:));
nor_map2_sum=(map2_sum-minval_map2)./(maxval_map2 - minval_map2);

opresult=[];

 for i=0:0.01:1
    %for j=i:0.01:1
        
        %mapdiff=(((i.*map1_hist))./(max(map1_hist(:)))) - (((j.*map2_sum))./(max(map2_sum(:))));
        %mapdiff=(((i.*map1_hist)-min(map1_hist(:)))./(max(map1_hist(:))-min(map1_hist(:)))) - (((j.*map2_sum)-min(map2_sum(:)))./(max(map2_sum(:))-min(map2_sum(:))));
        %mapdiff=(i.*map1_hist) - (j.*map2_sum);
        
        %mapdiff=(i.*nor_map1_hist) - (nor_map2_sum);
        mapdiff=(nor_map1_hist) - (i.*nor_map2_sum);
        
        absmapdiff=abs(mapdiff);
        sumdiff=sum(absmapdiff(:));
        
       % if(i~=j)
        %opresult=[opresult; sumdiff ,i, j];
        opresult=[opresult; sumdiff ,i];
        %end
    %end

 i
 end
 
 trresult=opresult(2:end,:);
 
 [Val,ind]=min(trresult(:,1));
 
 
 %result=trresult(ind,1);
 weight=trresult(ind,2);
 %trresult(ind,3)
 weight

fmap1= sqrt(((nor_map1_hist) .*(weight.*nor_map2_sum))); 
%fmap1= sqrt(((nor_map1_hist).^2 .*(weight.*nor_map2_sum)));
%fmap1= sqrt(((nor_map1_hist).^2.*((1-weight).*nor_map2_sum)));
%fmap2=nor_map1_hist +(weight.*nor_map2_sum);
%fmap3=sqrt(fmap2.^2);

%sv1=var(nor_map1_hist(:))
%sv2=var(nor_map2_sum(:))
%sv3=var(fmap1(:))

figure,imagesc(fmap1);%,colormap(hot);
%figure,imagesc(fmap2);%,colormap(hot);
%figure,imagesc(fmap3);%,colormap(hot);

res1=normaliseandSmoothLDmap(nor_map1_hist);
res2=normaliseandSmoothLDmap(nor_map2_sum);
res3=normaliseandSmoothLDmap(fmap1);
%[ finalnorldmap1 ] = normaliseandSmoothLDmap(fmap1);
%[ finalnorldmap2 ] = normaliseandSmoothLDmap(fmap2);
%[ finalnorldmap3 ] = normaliseandSmoothLDmap(fmap3);

v1=var(res1(:));
v2=var(res2(:));
v3=var(res3(:));
var=[v1 v2 v3];
[val ind]=max(var);
if ind==1
    fres=res1;
elseif ind==2
    fres=res2;
else
    fres=res3;
end
%figure,imagesc(finalnorldmap1);%,colormap(hot);
%figure,imagesc(finalnorldmap2);%,colormap(hot);
%figure,imagesc(finalnorldmap3);%,colormap(hot);
 
figure,imagesc(fres);%,colormap(hot);
