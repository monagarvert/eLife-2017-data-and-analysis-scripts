%% %% Figure 1 - figure supplement 1F
%
% response times and % correct during training
% Format: subjects x object trial t-1 x object trial t
% 
%%
clear all
close all

% Load training data (RT and %correct)
load('behaviour.mat')

%% Generate graph
% dist: distance between objects 
dist = generate_graph('off');   % 'on': plot graph structure, 'off': do not plot graph structure

for d = 1:3
    distance_effect(:,d) = nanmean(rt_trans(:,dist==d),2);   % Change this to dist_a_42 etc if 
end

figure; bar(1:3,mean(distance_effect),'facecolor',[0.5 0.5 0.5],'edgecolor','none');
hold on 
errorbar(1:3,mean(distance_effect),std(distance_effect)/sqrt(23),'k','linestyle','none')
set(gcf,'color','w')
box off
set(gca,'TickDir','out','XTick',1:3,'fontsize', 15,'YTick',600:20:680)
xlabel('Distance','fontsize', 15)
ylim([600 680])