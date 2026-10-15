%RUN_RELATIVE_DEPTH  End-to-end driver for Zia, Zhou & Gao, DICTA 2015.
%
%   Runs both sparse relative-depth cues from the paper on one hyperspectral
%   cube and merges them:
%     Map 1  variance of band-wise local histograms at edge pixels
%            (defocus that changes across bands due to chromatic aberration)
%     Map 2  sum of differences between neighbouring spectral vectors
%   The two maps are saved next to the data and combined by MergeMapsScript.
%
%   This driver only strings together calls that already existed in
%   src/MainScript.m (where Map 1 was commented out) and src/MergeMapsScript.m.
%   Edit the two paths below, then run from the repository root.

setup_paths;

% ---------------------------------------------------------------- inputs
datafolder = '.\data\Depth Estimation\rooftop hyper\penswall_exp500\';  % folder with the ENVI cube
filename   = [datafolder 'penswall_exp500.dat'];
sind = 20;   % first band used in the paper
eind = 53;   % last band used in the paper

% ------------------------------------------------------- load and prepare
imageflag = true;                                   % also write per-band images
[allnormat, allbandName] = saveCube(filename, imageflag);
normat   = allnormat(:, :, sind:eind);
bandName = allbandName(sind:eind);
normat   = removenoise(normat);
[edgesum, edgecube] = getedgecube(normat);

% ------------------------------------- Map 1: variance of local histograms
[allcounts, r, c] = getcubehistogram(normat, edgesum, datafolder);
localdepthcube    = localhistAnalysis(allcounts, r, c, edgesum);
localdepthmap     = sqrt(sum(localdepthcube.^2, 3));   % Euclidean norm over bands
figure, imagesc(localdepthmap), title('Map 1: histogram variance');

% ----------------------------- Map 2: sum of spectral-vector differences
spmapsdiff = SumofDifference(normat, edgesum);
figure, imagesc(spmapsdiff), title('Map 2: spectral differences');

% ------------------------------------------------------ save and merge
m1 = [datafolder 'Map1_hist.mat'];
m2 = [datafolder 'Map2_sumdiff.mat'];
save(m1, 'localdepthmap');
save(m2, 'spmapsdiff');
MergeMapsScript;   % shows the merged sparse depth map (variable fres)
