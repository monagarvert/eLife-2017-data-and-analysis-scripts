%% Figure 3 - figure supplement 1D
%
% parameter estimates extracted from ROI 2
% data format: subjects x runs x object trial t-1 x object trial t
%
%%
clear all
close all

% Load data from ROI2
load('ROI2.mat')    % format: subj x obj trial t-1 x obj trial t
roi2 = squeeze(mean(roi2,2));     % average across experimental runs

%% Generate graph
% dist: distance between objects 
dist = generate_graph('off');   % 'on': plot graph structure, 'off': do not plot graph structure

%% Remove mean object-specific activity
% Average over all transitions to extract mean activity 
% Note: objects were never repeated!
obj_activity    = squeeze(sum(roi2,2)/6);   

% Subtract mean activity
roi2            = roi2 - permute(repmat(obj_activity,[1,1,7]),[1 3 2]);

%% Figure: associated vs. non-associated
assoc       = mean(roi2(:,dist==1),2);
non_assoc   = mean(roi2(:,eye(7)~=1 & dist~=1),2);

figure; bar([mean(assoc), mean(non_assoc)],'facecolor',[0.5 0.5 0.5],'edgecolor','none');
hold on 
errorbar(1:2,[mean(assoc), mean(non_assoc)],...
    [std(assoc), std(non_assoc)]/sqrt(23),'k','linestyle','none')
set(gcf,'color','w')
box off
set(gca,'TickDir','out','XTick',1:3,'YTick',-0.3:0.05:0.2,'fontsize', 15)
xlabel('Distance','fontsize', 15)
ylim([-0.15 0.1])