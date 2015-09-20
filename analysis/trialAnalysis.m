function trialAnalysis(elet, neu, od, pre, post, rWindow)
% Variables that MUST be changed by user:
%   K           Number of trials 
%   T           Lenght of observational interval (in sec)
%   direc       Name of the directory where the spike trains are stored and 
%               where all the results of EM estimation will be stored by the subroutines
%   name_data   Name of the data file which contains the times of spikes     
%   R           Number of unit pulse functions (hence number of hidden processes (theta_1, .., theta_R).
%               This code assumes that the pulse functions have equal size.
%   lags        The history bins of spike-history component (a matrix of two columns)
% time_start, time_end: for each trial the state-space model will be fit
%               to the period (time_start,time_end]. Time_start must be
%               >=total spike-history and time_end must be <=T.
% period_start  Start of the period (in sec) for which the user wants to estimate 
%               the expected number of spikes (for each trial). Must be
%               bigger than the total spike history. 
% period_end    The end of the period (in sec) for which the user wants to estimate 
%               the expected number of spikes (for each trial). Must be
%               bigger than the total spike history. Can be less than T.
% period_start, period_end: The beginning and end of the period for which user wants to estimate the expected
%               number of spikes for each trial (in sec). Period_start must be > the total spike history; 
%               period_end must be <=T.
% period1_start, period1_end; period2_start, period2_end = two periods for
%               which user wants to compare the firing rates.

% Variables that CAN be changed by user (but do not have to):
%   stop_theta  convergence criteria for the initial theta (denoted as theta_0 in the paper). 
%               EM algorithm runs forward and backward several times until convergence is
%               accomplished or maximum of iterations is reached (see 'pom_theta_imax')
%   pom_theta_imax = Maximal number of iterations to estimate the initial theta
%   stop_abs    Abstolute stopping criteria for EM. The EM iterations stop
%               if absolute change in consecutive iterates for all parameters is less than stop_abs
%   stop_rel    Relative stopping criteria for EM. THe EM iterations stop
%               if relative change in consecutive iterates for all parameters is less then the stop_rel value.
%   n_iter1, n_iter2 Maximal number of EM iterations used (if the convergence criteria are not met). 
%               If the convergence criteria are not met then a warning will be printed on screen. 
%               Then the user needs to increase max number of iterations or make the stopping criteria less stringent.
% alphaa        The significance level for the stat inference.
%   Mc1         Number of Monte Carlo simulations to calculate standard errors 
%   Mc2         Number of Monte Carlo simulations to do stat inference for expected number of spikes.
   
% Variables that user should NOT be reset by user:
%   The time resolution delta is set to 1msec. It can not be changed.

%close all

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SS GLM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

% -------------------------------------------------------------------------
% Parameters of the model and specification of datafile
load('units.mat');
K=10;                   % Number of trials
T=pre+post;                    % Total time in one trial (in seconds)
direc=pwd; % Directory where the data are and where the results of EM estimation are stored
new_dir1 = sprintf('shank_%d', elet);
mkdir(new_dir1)
new_dir2 = sprintf('unit_%d', neu);
direc = fullfile(direc, new_dir1, new_dir2);
mkdir(direc)

new_dir3 = sprintf('odor_%d', od);
direc = fullfile(direc, new_dir3);
mkdir(direc)
direc = [direc, '\'];

name_data='data.txt';   % Name of data file -must be in directory 'direc'
R=10;                   % Number of step functions (equidistant)
lags=[1 5 
    6 10
    11 15
    16 20
    21 25
    26 30];
	% in msec            
	% lags = the history bins;e.g. if lags=[1 5;6 7], then there are two spike-history  
	%   parameters: gamma1 and gamma2. Gamma1 explains how number of spikes at
	%   1, 2,3,4 5 msec prior time t affects the spiking intensity at time t.
	%   Gamma2 explains how number of spikes at 6 and 7 msec prior t affects
        % the spiking intensity at time t.

alphaa=5;   % Level of significance for conf intervals of paramters, in percent
time_start=0.1; % (in sec); MUST be >= total spike history (i.e. >=lags(J,2))
time_end=T; % (in sec) the firing intensity will be estimated for period: time_start to time_end. 
  
% -------------------------------------------------------------------------
% Convergence criteria
n_iter=20; % maximal number of EM iterations (recommended n_iter=20)
stop_abs = 10^(-3); % absolute stopping criterion used in EM algorithm 
stop_rel = 10^(-3); % relative stopping criterion used in EM algorithm
stop_theta=10^-3; % convergence criteria for the initial values of hidden processes
pom_theta_imax=20; % maximal number of iterations for inital values of hidden processes

% -------------------------------------------------------------------------
% Simulation sizes
Mc1=30;
Mc2=300;

% -------------------------------------------------------------------------
% The periods for which user wants to estimate the firing rates
period_start=pre; % in sec; must be bigger than the total spike history
period_end=pre+rWindow; % in sec; must be <= T
period1_start=pre; % in sec; must be bigger than the total spike history
period1_end=pre+rWindow;   % in sec; must be <= T
period2_start=0.2; % in sec; must be bigger than the total spike history
period2_end=pre-0.2;   % in sec; must be <= T

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%% Now other subroutines will be called to do estimation %%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ------------------------------------------------------------------------
% Reading the data. 
pom=size(lags);
J=pom(1,1); % number of history bins

leggi(direc,shank,elet, neu, od,K,lags,T,time_start,time_end);

% ----------------------------------------------------------------------------------- 
% Obtain the initial guesses for the parameters of the SS GLM model. When
% the spike trains were read the time was changed: now time=0 corresponds
% to real time time_start, time=T corresponds to real time T+time_start.
% This is all done internally, hence user is not affected about it (i.e.
% when specifying the period_start and period_end variables, user has to
% use the real times.
T=time_end-time_start; 
[sig2_e_start,theta0_start]=var_init(direc,name_data,K,T,R,J,lags); % Rx1 init guess of variances of hidden theta's; Rx1 Initial guess for theta_0
gamma_init=static_glm(direc,name_data,K,lags,T,R,J,time_start,alphaa); % Initial guesses for temporal parameters 

% -------------------------------------------------------------------------
% Estimate the SS GLM model
ssglm_em(direc,name_data,K,T,R,n_iter,...
    lags,stop_theta,pom_theta_imax,gamma_init,...
    sig2_e_start,theta0_start,stop_abs,stop_rel,time_start) 
% -------------------------------------------------------------------------
% Goodness of fit for SS GLM: KS and ACF plots
test_ssglm(direc,name_data,K,T,lags) 

% -------------------------------------------------------------------------
% Calculate standard errors of the parameter estimates
inf_matrix(direc,K,T,lags,Mc1)

% -------------------------------------------------------------------------
% Plots the estimated quantities of SS GLM: history effect with conf
% intervals; stimulus effect for all trials in one 3D figure.
plots_ssglm(direc,K,T,R,J,lags,time_start,alphaa)
    
% -------------------------------------------------------------------------
% Plots of stimulus effect with confidence intervals.
stimulus_conf_intervals(K,direc,T,R,time_start,Mc2,lags,alphaa)

% -------------------------------------------------------------------------
% Inference for firing rate: comparisons of firing rate across trials


% -------------------------------------------------------------------------
% Comparisons of firing rates between two period (for all trials)
% It is done be estimating the rate in period 1 and subtracting the
% estimated rate of period2.
nspikes_2periods(K,direc,T,R,lags,time_start,period1_start,period1_end,...
    period2_start,period2_end,Mc2,alphaa)

% -------------------------------------------------------------------------
% Save all figures

save_all_figures_to_directory(direc)
close all

end