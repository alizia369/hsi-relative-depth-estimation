%datafolder='.\data\Depth Estimation\multiobject\rawdata\';
%filename='.\data\Depth Estimation\multiobject\rawdata\multiobject.dat';
%loadfile='.\data\Depth Estimation\multiobject\rawdata\multiobject.mat';
%savepath='.\data\Depth Estimation\multiobject\rawdata\depth_ShaojieZhuo';


%datafolder='.\data\Depth Estimation\outdoor\car2\';
%filename='.\data\Depth Estimation\outdoor\car2\car2(focus on ali).dat';

%datafolder='.\data\Depth Estimation\outdoor\scene3\';
%filename='.\data\Depth Estimation\outdoor\scene3\scene3.dat';

%bandExtraction( datafolder );

%datafolder='.\data\Depth Estimation\labData\objectslab_f-5.6-2_focus600\';
%filename='.\data\Depth Estimation\labData\objectslab_f-5.6-2_focus600\objectslab_f-5.6-2_focus600.dat';

%datafolder='.\data\Depth Estimation\labData\objectslab_f-8_2\';
%filename='.\data\Depth Estimation\labData\objectslab_f-8_2\objectslab_f-8_2.dat';

 %datafolder='.\data\Depth Estimation\rooftop hyper\extension_tripod_exp500\';
 %filename='.\data\Depth Estimation\rooftop hyper\extension_tripod_exp500\extension_tripod_exp500.dat';
 
%datafolder='.\data\Depth Estimation\rooftop hyper\bookmoose_exp750\';
%filename='.\data\Depth Estimation\rooftop hyper\bookmoose_exp750\bookmoose_exp750.dat';

%datafolder='.\data\Depth Estimation\rooftop hyper\bookmoose_exp500\';
%filename='.\data\Depth Estimation\rooftop hyper\bookmoose_exp500\bookmoose_exp500.dat';

%datafolder='.\data\Depth Estimation\rooftop hyper\multiobjects_exp350\';
%filename='.\data\Depth Estimation\rooftop hyper\multiobjects_exp350\multiobjects_exp350.dat';

datafolder='.\data\Depth Estimation\rooftop hyper\penswall_exp500\';
filename='.\data\Depth Estimation\rooftop hyper\penswall_exp500\penswall_exp500.dat';

%datafolder='.\data\Depth Estimation\rooftop hyper\penswall_exp350\';
%filename='.\data\Depth Estimation\rooftop hyper\penswall_exp350\penswall_exp350.dat';

%datafolder='.\data\Depth Estimation\labData\board2_f-8\';
%filename='.\data\Depth Estimation\labData\board2_f-8\board2_f-8.dat';

%%%not good%%%
%datafolder='.\data\Depth Estimation\rooftop hyper\multiobjects3_exp500\';
%filename='.\data\Depth Estimation\rooftop hyper\multiobjects3_exp500\multiobjects3_exp500.dat';






%%%%%%%%%%%%%% code Start %%%%%%%%%%%%%%%


imageflag=true;%save original images
[ allnormat, allbandName ]=saveCube(filename,imageflag); %save and normalise cube


sind=20;
eind=53;
normat=allnormat(:,:,sind:eind);
bandName=allbandName(sind:eind);


[normat ] = removenoise( normat );
[edgesum,edgecube]=getedgecube(normat);

%figure,imagesc(edgesum);


%[ allcounts,r,c ] = getcubehistogram( normat,edgesum,datafolder);%r c prepresents point in row column order


%%%%%%%%%%%% Local Analysis --- Variance of Histogram Method %%%%%%%%%

%localdepthcube=localhistAnalysis(allcounts,r,c,edgesum);


%%%%%%%% save and view
% imgsc=true;
% showcubedata(localdepthcube,bandName,imgsc);
% 
% imgs=true;
% saveDepthCube( localdepthcube,bandName,datafolder,imgs );
%%%%%

%localdepthmap=sum(localdepthcube,3);% sum

%%%%%% Eculidian Distance
% sqrld=localdepthcube.^2;
% sumld=sum(sqrld,3);
% localdepthmap=sqrt(sumld);
% 
%  figure,imagesc(localdepthmap),colormap(hot);





%%%%%%%%%%%Normalization

%[ norlocalDmap ] = normaliseandSmoothLDmap( localdepthmap);

%figure,imagesc(norlocalDmap),colormap(hot);



%%%%%%%%%Sum of squared Difference
[ spmapsdiff ] = SumofDifference( normat,edgesum );
figure,imagesc(spmapsdiff);

%%%%Save both depthmaps %%%%%

%save([datafolder 'Map1_hist.mat'],'localdepthmap');
%save([datafolder 'Map2_sumdiff.mat'],'spmapsdiff');


%%%%%%%Dense Map%%%%%%%%%%%
%  [ depthmap ] = DenseDepthmap1( norlocalDmap,normat );%slow
%   figure,imshow(depthmap);
%   figure,imagesc(depthmap);

