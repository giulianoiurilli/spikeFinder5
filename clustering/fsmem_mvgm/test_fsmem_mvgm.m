
clear, clc, close all hidden

%% First example of FSMEM : Fit a MVGM with default parameters  
% Calling FSMEM with the data Z only, without the knowledge of the number of compounds
%%

% Generate MVGM  %%

d                                       = 2;
N                                       = 2000;
K_true                                  = 5;
clust_spread                            = 0.4;

[M_true , S_true , P_true]              = gene_mvgm(d , K_true , clust_spread);
Z                                       = sample_mvgm(N , M_true , S_true , P_true);
logl_true                               = loglike_mvgm(Z , M_true , S_true , P_true);
mdl_true                                = logl_true - 0.5*log(N)*K_true*((d+1) + d*((d+1))/2);

% Display Orignal data %%

offsetmin                               = [1.1 ; 0.9];
offsetmax                               = [0.9 ; 1.1];

pdf_true                                = pdf_mvgm(Z , M_true , S_true , P_true);
minZ                                    = min(Z , [] , 2);
maxZ                                    = max(Z , [] , 2);
minZ                                    = minZ.*offsetmin((sign(minZ) > 0)+1);
maxZ                                    = maxZ.*offsetmax((sign(maxZ) > 0)+1);

vectx                                   = minZ(1):0.1:maxZ(1);
vecty                                   = minZ(2):0.1:maxZ(2);
[X , Y]                                 = meshgrid(vectx , vecty);
grid                                    = [X(:) , Y(:)]';
pdf_support                             = pdf_mvgm(grid , M_true , S_true , P_true);

figure(1)
set(gcf , 'renderer' , 'opengl');
g = surfc(X , Y , reshape(pdf_support , length(vecty) , length(vectx)));
alpha(g , 0.7);
hold on
h = stem3(Z(1 , :) , Z(2 , :) , pdf_true);
hold off
shading interp
lighting phong
light
legend(h , '\bf{Z}')
title(sprintf('Original data Z, K_{true} = %d, MDL(Z) = %8.3f' , K_true , mdl_true) , 'fontsize' , 12 , 'fontweight' , 'bold');
rotate3d on
drawnow

% FSMEM with unknown number of clusters  %

tic,[Mest , Sest , Pest , logl]          = fsmem_mvgm(Z);,toc;
K_est                                    = size(Mest , 3);

 
% Display Results %

[x_true , y_true]                        = ndellipse(M_true , S_true);
[x_est , y_est]                          = ndellipse(Mest , Sest);

figure(2)
h                                        = plot(Z(1 , :) , Z(2 , :) , '+' , x_true , y_true , 'k' , x_est , y_est , 'r' , 'linewidth' , 2);
legend([h(1), h(2) , h(2+K_true)] , 'Z' , sprintf('True, K=%d' , K_true),sprintf('FSMEM, K=%d' , K_est))
title(sprintf('MDL(FSMEM) = %8.3f' , logl(1 , end)) , 'fontsize' , 12 , 'fontweight' , 'bold');


disp(sprintf('\nK_true = %d , K_est = %d\n' , K_true , K_est))
disp(sprintf('pause\n'))


%% Second example of FSMEM : Fit a MVGM with default parameters & compare with the classical EM
%  Calling FSMEM with the data Z only, without the knowledge of the number of compounds
%%

% Generate MVGM  %

d                                       = 2;
N                                       = 1500;
K_true                                  = 5;
clust_spread                            = 0.5;

[M_true , S_true , P_true]              = gene_mvgm(d , K_true , clust_spread);
Z                                       = sample_mvgm(N , M_true , S_true , P_true);
logl_true                               = loglike_mvgm(Z , M_true , S_true , P_true);
mdl_true                                = logl_true - 0.5*log(N)*K_true*((d+1) + d*((d+1))/2);


% Display Orignal data %

offsetmin                               = [1.1 ; 0.9];
offsetmax                               = [0.9 ; 1.1];

pdf_true                                = pdf_mvgm(Z , M_true , S_true , P_true);
minZ                                    = min(Z , [] , 2);
maxZ                                    = max(Z , [] , 2);
minZ                                    = minZ.*offsetmin((sign(minZ) > 0)+1);
maxZ                                    = maxZ.*offsetmax((sign(maxZ) > 0)+1);

vectx                                   = minZ(1):0.1:maxZ(1);
vecty                                   = minZ(2):0.1:maxZ(2);
[X , Y]                                 = meshgrid(vectx , vecty);
grid                                    = [X(:) , Y(:)]';
pdf_support                             = pdf_mvgm(grid , M_true , S_true , P_true);

figure(3)
set(gcf , 'renderer' , 'opengl');
g = surfc(X , Y , reshape(pdf_support , length(vecty) , length(vectx)));
alpha(g , 0.7);
hold on
h = stem3(Z(1 , :) , Z(2 , :) , pdf_true);
hold off
shading interp
lighting phong
light
legend(h , '\bf{Z}')
title(sprintf('Original data Z, K_{true} = %d, MDL(Z) = %8.3f' , K_true , mdl_true) , 'fontsize' , 12 , 'fontweight' , 'bold');
rotate3d on
drawnow

% FSMEM with unknown number of clusters %

tic,[Mest , Sest , Pest , logl ]         = fsmem_mvgm(Z);,toc;
K_est                                    = size(Mest , 3);


% Full EM with known and fixed number of clusters %
% Calling FSMEM with flag fail_exit = 0 in the options structure run a single Full EM

options.Kini                             = K_true;
options.fail_exit                        = 0.0;

tic,[Mestem , Sestem , Pestem , loglem]  = fsmem_mvgm(Z , options);,toc

% Display Results %

[x_true , y_true]                        = ndellipse(M_true , S_true);
[x_est , y_est]                          = ndellipse(Mest , Sest);
[x_estem , y_estem]                      = ndellipse(Mestem , Sestem);

figure(4)
h                                        = plot(Z(1 , :) , Z(2 , :) , '+' , x_true , y_true , 'k' , x_est , y_est , 'r' , 'linewidth' , 2);
legend([h(1), h(2) , h(2+K_true)] , 'Z' , sprintf('True, K=%d' , K_true),sprintf('FSMEM, K=%d' , K_est))
title(sprintf('MDL(FSMEM) = %8.3f' , logl(1 , end)) , 'fontsize' , 12 , 'fontweight' , 'bold');

figure(5)
h                                        = plot(Z(1 , :) , Z(2 , :) , '+' , x_true , y_true , 'k' , x_estem , y_estem , 'r' , 'linewidth' , 2);
legend([h(1), h(2) , h(2+K_true)] , 'Z' , sprintf('True, K=%d' , K_true), 'EM')
title(sprintf('MDL(EM) = %8.3f' , loglem(1 , end)) , 'fontsize' , 12 , 'fontweight' , 'bold');

figure(6)
h                                        = plot(Z(1 , :) , Z(2 , :) , '+' , x_true , y_true , 'k' , x_est , y_est , 'r' , x_estem , y_estem , 'g', 'linewidth' , 2);
legend([h(1), h(2) , h(2+K_true) , h(2+K_true + K_est)] , 'Z' , sprintf('True, K=%d' , K_true),sprintf('FSMEM, K=%d' , K_est) , 'EM')
title(sprintf('MDL(FSMEM) = %8.3f, MDL(EM) = %8.3f' , logl(1 , end) , loglem(1 , end)) , 'fontsize' , 12 , 'fontweight' , 'bold');


%% Third example of FSMEM : Fit a Elliptical MVGM with a given initial MVGM
% Calling FSMEM with the data Z only, without knowing number of compounds 
%%


% Generate MVGM  %


d                                       = 2;
N                                       = 2000;
K_true                                  = 8;

P_true                                  = permute((1/K_true)*ones(1 , K_true) , [1 3 2]);
M_true                                  = permute([1.5 , 1 , 0 , -1 , -1.5 , -1 , 0 , 1 ; 0 1 , 1.5 , 1 , 0 , -1 , -1.5 , -1] , [1 3 2]);
S_true                                  = cat(3 , diag([0.01 , 0.1]) , diag([0.1 , 0.1]) , diag([0.1 , 0.01]) , diag([0.1 , 0.1]) , diag([0.01 , 0.1]) , diag([0.1 , 0.1]) , diag([0.1 , 0.01]) , diag([0.1 , 0.1]));
Z                                       = sample_mvgm(N , M_true , S_true , P_true);
logl_true                               = loglike_mvgm(Z , M_true , S_true , P_true);
mdl_true                                = logl_true - 0.5*log(N)*K_true*((d+1) + d*((d+1))/2);

% Display Orignal data %

offsetmin                               = [1.1 ; 0.9];
offsetmax                               = [0.9 ; 1.1];

pdf_true                                = pdf_mvgm(Z , M_true , S_true , P_true);
minZ                                    = min(Z , [] , 2);
maxZ                                    = max(Z , [] , 2);
minZ                                    = minZ.*offsetmin((sign(minZ) > 0)+1);
maxZ                                    = maxZ.*offsetmax((sign(maxZ) > 0)+1);

vectx                                   = minZ(1):0.1:maxZ(1);
vecty                                   = minZ(2):0.1:maxZ(2);
[X , Y]                                 = meshgrid(vectx , vecty);
grid                                    = [X(:) , Y(:)]';
pdf_support                             = pdf_mvgm(grid , M_true , S_true , P_true);

figure(7)
set(gcf , 'renderer' , 'opengl');
g = surfc(X , Y , reshape(pdf_support , length(vecty) , length(vectx)));
alpha(g , 0.7);
hold on
h = stem3(Z(1 , :) , Z(2 , :) , pdf_true);
hold off
shading interp
lighting phong
light
legend(h , '\bf{Z}')
title(sprintf('Original data Z, K_{true} = %d, MDL(Z) = %8.3f' , K_true , mdl_true) , 'fontsize' , 12 , 'fontweight' , 'bold');
rotate3d on

% FSMEM with unknown number of clusters and fixed initial parameters%
% [Mest , Sest , Pest , logl]    = fsmem_mvgm(Z , [] , M_ini , S_ini , P_ini)
% where K_ini clusters <> K_true are supposed for the initial parameter (M_ini , S_ini , P_ini)
% Covariances by default are supposed to be full


K_ini                                    = 3;
[M_ini , S_ini , P_ini]                  = init_mvgm(Z , K_ini);

tic,[Mest , Sest , Pest , logl]          = fsmem_mvgm(Z , [] , M_ini , S_ini , P_ini);,toc;
K_est                                    = size(Mest , 3);

% Display Results %

[x_true , y_true]                        = ndellipse(M_true , S_true);
[x_est , y_est]                          = ndellipse(Mest , Sest);

figure(8)
h                                        = plot(Z(1 , :) , Z(2 , :) , '+' , x_true , y_true , 'k' , x_est , y_est , 'r' , 'linewidth' , 2);
legend([h(1), h(2) , h(2+K_true)] , 'Z' , sprintf('True, K=%d' , K_true),sprintf('FSMEM, K=%d' , K_est))
title(sprintf('MDL(FSMEM) = %8.3f' , logl(1 , end)) , 'fontsize' , 12 , 'fontweight' , 'bold');

% FSMEM with unknown number of clusters and initial parameters %
% Here covariances are supposed to be elliptical <=> options.covtype   = 1 %
% [Mest , Sest , Pest , logl]   = fsmem_mvgm(Z , options , M_ini , S_ini , P_ini) %

clear options
options.covtype                          = 1;
tic,[Mest1 , Sest1 , Pest1 , logl1]      = fsmem_mvgm(Z , options , M_ini , S_ini , P_ini);,toc;
K_est1                                   = size(Mest1 , 3);


% Display Results %

[x_true , y_true]                        = ndellipse(M_true , S_true);
[x_est1 , y_est1]                        = ndellipse(Mest1 , Sest1);

figure(9)
h                                        = plot(Z(1 , :) , Z(2 , :) , '+' , x_true , y_true , 'k' , x_est1 , y_est1 , 'r' , 'linewidth' , 2);
legend([h(1), h(2) , h(2+K_true)] , 'Z' , sprintf('True, K=%d' , K_true),sprintf('FSMEM, K=%d' , K_est1))
title(sprintf('MDL(FSMEM) = %8.3f' , logl1(1 , end)) , 'fontsize' , 12 , 'fontweight' , 'bold');



%% Fourth example of FSMEM : Fit spiral data  %%
% Calling FSMEM with special hyperparameters in options structure (a bit long even with the mex-file)
%%

% Generate Spiral data  %


N                                       = 3000;

options.Kini                            = 20;
options.Kmax                            = 40;
options.maxite_fullem                   = 500;
options.maxite_partialem                = 500;
options.epsi_fullem                     = 1e-7;
options.epsi_partialem                  = 1e-7;
options.maxcands_split                  = 12;
options.maxcands_merge                  = 12;
options.covtype                         = 0;


Z                                       = spiral2d(N);

% Display Orignal data %%


figure(10)
plot(Z(1 , :) , Z(2 , :) , '+', 'linewidth' , 2)
title('Original data Z' , 'fontsize' , 12 , 'fontweight' , 'bold');
drawnow


% FSMEM with unknown number of clusters %
% [Mest , Sest , Pest , logl ]  = fsmem_mvgm(Z , options);

tic,[Mest , Sest , Pest , logl]        = fsmem_mvgm(Z , options);,toc
K_est                                  = size(Pest , 3);

% Display Results %

figure(11)

[xest , yest]                          = ndellipse(Mest , Sest);
[xaxes , yaxes]                        = ndellipse(Mest , Sest , [] , [] , 3);
xaxes(end , :)                         = [];
yaxes(end , :)                         = [];
h                                      = plot(Z(1 , :) , Z(2 , :) , '+' , xest , yest , 'r' , xaxes , yaxes , 'k', 'linewidth' , 2);
legend([h(1), h(2) , h(2+K_est)] , 'Z' , sprintf('Estimated, K=%d' , K_est) , 'PC');
title(sprintf('MDL(FSMEM) = %8.3f' , logl(1 , end)) , 'fontsize' , 12 , 'fontweight' , 'bold');
