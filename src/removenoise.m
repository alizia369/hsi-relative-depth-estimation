function [ nrnormat ] = removenoise( normat )
%REMOVENOISE Summary of this function goes here
%   Detailed explanation goes here


%remove basic noise



nrnormat=imfilter(normat, fspecial('gaussian', 3, 3), 'symmetric', 'conv');  %%




end

