%% Figure 4C
%
% Relationship between matrix exponential and neural effect size
% 
% (c) M.M. Garvert 2017
%%
clear all
close all

% Load data from ROI4
load('ROI4.mat')                  % format: subj x runs x obj trial t-1 x obj trial t
roi4 = squeeze(mean(roi4,2));     % average across experimental runs

%% Generate graph
% dist: distance between objects 
[dist,graph] = generate_graph('off');   % 'on': plot graph structure, 'off': do not plot graph structure

matrix_exp          = expm(double(graph==1));   % Matrix exponential
communicability     = -matrix_exp(1:7,1:7);     % communicability between pairs of objects presented on day 2

figure; 
plot(squeeze(communicability(eye(7)~=1)),mean(roi4(:,eye(7)~=1)),'ko','MarkerSize',7)
lsline
hold on
gscatter(squeeze(communicability(eye(7)~=1)),mean(roi4(:,eye(7)~=1)),dist(eye(7)~=1), [],[], 20)
set(gcf,'color','w')
set(gca,'TickDir','out')
box off
xlabel('Communicability')
ylabel('Effect size (a.u.)')