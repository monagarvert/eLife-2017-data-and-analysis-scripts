%% Figure 3 - figure supplement 3B
%
% parameter estimates extracted from ROI 5 (anatomically defined)
% data format: subjects x runs x object trial t-1 x object trial t
%
%%
clear all
close all

% Load data from ROI5
load('ROI5.mat')                  % format: subj x obj trial t-1 x obj trial t
roi5 = squeeze(mean(roi5,2));     % average across experimental runs

load('time.mat');

%% Generate graph
% dist: distance between objects 
dist = generate_graph('off');   % 'on': plot graph structure, 'off': do not plot graph structure

%% Linear regression: distance & time
for subj = 1:23
    [beta(subj,:)] = regress(roi5(subj,eye(7)~=1)',[ones(42,1),dist(eye(7)~=1),time(subj,eye(7)~=1)']);
end

figure;
bar(mean(beta(:,2:end)),'facecolor',[0.5 0.5 0.5],'edgecolor','none')
hold on
errorbar(1:size(beta,2)-1,mean(beta(:,2:end)),std(beta(:,2:end))/sqrt(23),'k','linestyle','none')
set(gcf,'color','w')
box off
set(gca,'TickDir','out','XTickLabel',{'Link distance','Time'},'fontsize', 15,'YTick',0:0.1:0.4)
ylabel('Linear regression weighting (a.u.)')
ylim([0 0.16])
set(gca,'YTick',0:0.04:0.16)