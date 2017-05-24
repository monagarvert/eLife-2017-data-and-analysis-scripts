%% Figure 3 - figure supplement 1F
%
% parameter estimates extracted from ROI 3
% data format: subjects x runs x object trial t-1 x object trial t
%
%%
clear all
close all

% Load data from ROI3
load('ROI3.mat')    % format: subj x obj trial t-1 x obj trial t
roi3 = squeeze(mean(roi3,2));     % average across experimental runs

%% Generate graph
% dist: distance between objects 
dist = generate_graph('off');   % 'on': plot graph structure, 'off': do not plot graph structure

%% Remove mean object-specific activity
% Average over all transitions to extract mean activity 
% Note: objects were never repeated!
obj_activity    = squeeze(sum(roi3,2)/6);   

% Subtract mean activity
roi3            = roi3 - permute(repmat(obj_activity,[1,1,7]),[1 3 2]);

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