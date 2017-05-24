%% Figure 3 - figure supplement 1A
%
% parameter estimates extracted from ROI 1
% data format: subjects x runs x object trial t-1 x object trial t
%
%%
clear all
close all

% Load data from ROI1
load('ROI1.mat')                    % format: subj x run x obj trial t-1 x obj trial t
roi1 = squeeze(mean(roi1,2));       % average across experimental runs

%% Generate graph
% dist: distance between object 
dist = generate_graph('off');   % 'on': plot graph structure, 'off': do not plot graph structure

%% Object-specific activity
% Average over all transitions to extract mean activity 
% Note: objects were never repeated!
obj_activity    = squeeze(sum(roi1,2)/6);   

figure; 
bar(1:7,mean(obj_activity),'facecolor',[0.5 0.5 0.5])
hold on 
errorbar(1:7,mean(obj_activity),std(obj_activity)/sqrt(23),'k','linestyle','none')
set(gca,'TickDir','out','fontsize', 15,'XTick',1:7)
xlabel('Object','fontsize', 15)
ylabel('Parameter estimates')
set(gcf,'color','w')
box off