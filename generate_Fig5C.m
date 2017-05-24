%% Figure 5C
%
% Response time effects
% 
% (c) M.M. Garvert 2017
%%
clear all
close all

%% Generate graph
% dist: distance between objects 
[dist,graph] = generate_graph('off');   % 'on': plot graph structure, 'off': do not plot graph structure

matrix_exp          = expm(double(graph==1));   % Matrix exponential
communicability     = -matrix_exp(1:7,1:7);     % communicability between pairs of objects presented on day 2

% Load response times. These data are log-transformed and demeaned to
% remove object-specific differences in RT.
load('RT.mat');                                % format: subj x runs x obj trial t-1 x obj trial t
RT = squeeze(nanmean(RT,2));                    % average across experimental runs

%% Communicability
matrix_exp          = expm(double(graph==1));   % Matrix exponential
communicability     = -matrix_exp(1:7,1:7);     % communicability between pairs of objects presented on day 2

%% Compute Euclidian distances between nodes
nodes = [0 0;
        1 0;
        0 1;
        -1 2;
        0 2;
        -2 3;
        0 3];
    
mat=[1 0; .5 -sqrt(3/4); ];
nodes=nodes*mat;

eucl_dist = squareform(pdist(nodes));

% Visualization of Euclidian distances
figure; scatter(nodes(:,1),nodes(:,2))
[i,j] = find(dist==1);
l=line([nodes(i,1),nodes(j,1)]',[nodes(i,2),nodes(j,2)]');
axis equal
axis off
set(l,'color','k');
set(gcf,'color','w');
text(0.05+nodes(:,1),0.05+nodes(:,2),num2str((1:7)'))   % label objects


%% Linear regression: Communicability, Euclidian distance & link distance 
for subj = 1:26
    [beta(subj,:)] = regress(RT(subj,eye(7)~=1)',[ones(42,1),communicability(eye(7)~=1),dist(eye(7)~=1),eucl_dist(eye(7)~=1)]);
end

figure;
bar(mean(beta(:,2:end)),'facecolor',[0.5 0.5 0.5],'edgecolor','none')
hold on
errorbar(1:size(beta,2)-1,mean(beta(:,2:end)),std(beta(:,2:end))/sqrt(26),'k','linestyle','none')
set(gcf,'color','w')
box off
set(gca,'TickDir','out','XTickLabel',{'Communicability', 'Link distance','Euclidian distance'},'fontsize', 15)
ylabel('Linear regression weighting (a.u.)')

% Statistics
[h,p,~,stats] = ttest(beta)

