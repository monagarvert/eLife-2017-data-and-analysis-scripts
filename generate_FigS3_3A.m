%% Figure 3 - figure supplement 3A
%
% parameter estimates extracted from ROI 5 (anatomically defined)
% data format: subjects x runs x object trial t-1 x object trial t
%
%%
clear all
close all

% Load data from ROI5
load('ROI5.mat')    % format: subj x obj trial t-1 x obj trial t
roi5 = squeeze(mean(roi5,2));     % average across experimental runs

%% Generate graph
% dist: distance between objects 
dist = generate_graph('off');   % 'on': plot graph structure, 'off': do not plot graph structure

%% Figure: all distances
for d = 1:3
    distance_effect(:,d) = mean(roi5(:,dist==d),2);   
end

figure; bar(1:3,mean(distance_effect),'facecolor',[0.5 0.5 0.5],'edgecolor','none');
hold on 
errorbar(1:3,mean(distance_effect),std(distance_effect)/sqrt(23),'k','linestyle','none')
set(gcf,'color','w')
box off
set(gca,'TickDir','out','XTick',1:3,'fontsize', 15)
xlabel('Distance','fontsize', 15)
ylim([-0.2 0.4])