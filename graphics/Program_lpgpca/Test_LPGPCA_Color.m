%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% All rights reserved.
% This work should only be used for nonprofit purposes.
%
% Please cite the paper when you use th code:
%
% Lei Zhang, Weisheng Dong, David Zhang, Guangming Shi 
% Two-stage Image Denoising by Principal Component Analysis with Local
% Pixel Grouping, Pattern Recognition, vol. 43, issue 4, pp. 1531-1549,
% Apr. 2010
%
% AUTHORS:
%     Weisheng Dong, Lei Zhang, email:
%     wsdong@mail.xidian.edu.cn / lzhang@comp.polyu.edu.hk
%
%  Latest modify at Mar. 17, 2011
%
%  Two profiles for this code: 'fast' and  'normal'
%  'fast'---fastest speed but slight performance decreases;
%  'normal'---higher performance but computation time increases
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;

profile    =  'normal';   
seed       =  0;
randn( 'state', seed );

oI         =  double( imread('Images\Parrot.tif') );
v          =  20;
noise      =   randn(size( oI ));
noise      =   noise/sqrt(mean2(noise.^2));
nI         =   oI + v*noise;
K          =   0;    % The width of the excluded boundaries, set to 20 to get the results in our paper
imwrite(nI./255, 'Noisy_Parrot.ppm');

[ d_im psnr1 ssim1 psnr2 ssim2 ]   =  LPGPCA_color_denoising( nI, oI, v, profile, K );
imwrite( d_im/255,'results\Parrot_lpgpca.tif','tif' );
psnr1
ssim1
psnr2
ssim2
