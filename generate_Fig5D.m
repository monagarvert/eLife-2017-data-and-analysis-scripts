%% Figure 5D
%
% Relationship between communicability and response times
% 
% (c) M.M. Garvert 2017
%%
clear all
close all

%% Generate graph
% dist: distance between objects 
[dist,graph] = generate_graph('off');   % 'on': plot graph structure, 'off': do not plot graph structure

matrix_exp          = expm(double(graph==1));   % Matrix exponential
communicability     = -matrix_exp(1:7,1:7);     % communicability between pairs of objects presented on day 2

% Load response times. These data are log-transformed and demeaned to
% remove object-specific differences in RT.
load('RT.mat');               % format: subj x runs x obj trial t-1 x obj trial t
RT = squeeze(nanmean(RT,2));                    % average across experimental runs

%% Communicability
matrix_exp          = expm(double(graph==1));   % Matrix exponential
communicability     = -matrix_exp(1:7,1:7);     % communicability between pairs of objects presented on day 2

% Sort RT according to communicability
comm_RT = sortrows([communicability(eye(7)~=1),  RT(:,eye(7)~=1)']);

% Number of bins
nbins   = 6;
binsize = size(comm_RT,1)/nbins;

% Bin data
for i = 1:nbins
    ix = (i-1)*binsize + 1 : i*binsize;
    comm_bin(i) = mean(comm_RT(ix,1));
    mean_RT(i) = mean(mean(comm_RT(ix,2:end)));
    std_RT(i) = std(mean(comm_RT(ix,2:end)))/sqrt(26);
end

figure; 
errorbar(comm_bin,mean_RT,std_RT,'k','linestyle','none')
hold on 
plot(comm_bin,mean_RT,'ko'),lsline
set(gcf,'color','w')
xlabel('Communicability')
ylabel('Log response times')
box off