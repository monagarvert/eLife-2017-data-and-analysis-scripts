%% Figure 2E
%
% parameter estimates extracted from ROI 3
% data format: subjects x runs x object trial t-1 x object trial t
%
% (c) M.M. Garvert 2017
%%
clear all
close all

% Load data from ROI3
load('ROI3.mat')    % format: subj x obj trial t-1 x obj trial t
roi3 = squeeze(mean(roi3,2));     % average across experimental runs

%% Generate graph
% dist: distance between objects 
dist = generate_graph('off');   % 'on': plot graph structure, 'off': do not plot graph structure

%% Figure: all distances
for d = 1:3
    distance_effect(:,d) = mean(roi3(:,dist==d),2);   
end

figure; bar(1:3,mean(distance_effect),'facecolor',[0.5 0.5 0.5],'edgecolor','none');
hold on 
errorbar(1:3,mean(distance_effect),std(distance_effect)/sqrt(23),'k','linestyle','none')
set(gcf,'color','w')
box off
set(gca,'TickDir','out','XTick',1:3,'fontsize', 15)
xlabel('Distance','fontsize', 15)

% Statistics
[p, table] = anova_rm(distance_effect, 'on');
[h,p,~,stats] = ttest(distance_effect(:,1),distance_effect(:,2))
[h,p,~,stats] = ttest(distance_effect(:,1),distance_effect(:,3))
[h,p,~,stats] = ttest(distance_effect(:,2),distance_effect(:,3))