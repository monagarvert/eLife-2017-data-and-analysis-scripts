%% Figure 3 - figure supplement 3C
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

load('exp_settings.mat');       % loads variable transition_count: number of times a transition was experienced during training

%% Generate graph
% dist: distance between objects 
[dist,graph] = generate_graph('off');   % 'on': plot graph structure, 'off': do not plot graph structure


for subj = 1:23
    
    % translate the number of times a transition was experienced
    % (transition_count) into a distance measure, according to d=1-c/(1+c_max)
    % with d: length of shortest path between two connected objects, c: number of times 
    % this particular transition was experienced during training, c_max: 
    % number of times the most visited transition was experienced 
    cp1         = sparse(squeeze(1-(transition_count(subj,:,:)./(1+max(transition_count(subj,:))))));
    
    % Set all transitions that were never experienced during training to 0
    sparseDist(graph~=1) = 0;
    
    % compute length of the path between objects that were two or three 
    % links away as the single-source shortest path between these objects 
    shortPath(subj,:,:) = graphallshortestpaths(cp1); 
    
end

% Only objects 1:7 were presented on day 2
path_dist       = shortPath(:,1:7,1:7);

% compute non-directional symmetric distance measure
for subj = 1:23
    path_dist_nonDir(subj,:,:) = (squeeze(path_dist(subj,:,:)) + squeeze(path_dist(subj,:,:))')/2;
end


%% Linear regression: directional & non-directional distance
for subj = 1:23
    [beta(subj,:)] = regress(roi5(subj,eye(7)~=1)',[ones(42,1),path_dist(subj,eye(7)~=1)',path_dist_nonDir(subj,eye(7)~=1)']);
end

figure;
bar(mean(beta(:,2:end)),'facecolor',[0.5 0.5 0.5],'edgecolor','none')
hold on
errorbar(1:2,mean(beta(:,2:end)),std(beta(:,2:end))/sqrt(23),'k','linestyle','none')
set(gcf,'color','w')
box off
set(gca,'TickDir','out','XTickLabel',{'Shortest path','Symmetric shortest path'})
ylabel('Linear regression weighting (a.u.)')

