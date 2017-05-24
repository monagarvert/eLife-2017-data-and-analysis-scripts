%% Figure 3 - figure supplement 1B
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

%% Remove mean object-specific activity
% Average over all transitions to extract mean activity 
% Note: objects were never repeated!
obj_activity    = squeeze(sum(roi1,2)/6);   

% Subtract mean activity
roi1            = roi1 - permute(repmat(obj_activity,[1,1,7]),[1 3 2]);

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