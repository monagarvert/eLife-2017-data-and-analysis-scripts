%% Figure 2C
%
% parameter estimates extracted from ROI 1
% data format: subjects x runs x object trial t-1 x object trial t
%
% (c) M.M. Garvert 2016
%%
clear all
close all

% Load data from ROI1
load('ROI1.mat')    % format: subj x obj trial t-1 x obj trial t
roi1 = squeeze(mean(roi1,2));     % average across experimental runs

%% Generate graph
% dist: distance between object 
dist = generate_graph('off');   % 'on': plot graph structure, 'off': do not plot graph structure

%% Figure: distance 2 vs. distance 3
for d = 1:3
    distance_effect(:,d) = mean(roi1(:,dist==d),2);   
end

% Plot distance 2 and 3
figure; bar(2:3,mean(distance_effect(:,2:3)),'facecolor',[0.5 0.5 0.5],'edgecolor','none');
hold on 
errorbar(2:3,mean(distance_effect(:,2:3)),std(distance_effect(:,2:3))/sqrt(23),'k','linestyle','none')
set(gcf,'color','w')
box off
set(gca,'TickDir','out','XTick',1:3,'fontsize', 15)
xlabel('Distance','fontsize', 15)
ylabel('Effect size','fontsize',15)
ylim([-0.4 0.6])
