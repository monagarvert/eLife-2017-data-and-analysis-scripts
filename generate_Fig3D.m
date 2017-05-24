%% Figure 3D
%
% parameter estimates extracted from ROI 3
% data format: subjects x runs x object trial t-1 x object trial t
%
%%
clear all
close all

% Load data from ROI3
load('ROI3.mat')            % format: subj x obj trial t-1 x obj trial t
roi3 = squeeze(mean(roi3,2));     % average across experimental runs

% Plot symmetrized raw data in a 7x7 matrix
figure;
imagesc(squeeze(mean(roi3)) + squeeze(mean(roi3))')
set(gcf,'color','w')
set(gca,'TickDir','out')
xlim([0.5 7.5])
box off
colorbar

