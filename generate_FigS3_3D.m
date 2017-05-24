%% Figure 3 - figure supplement 3D
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

%% Generate graph
% dist: distance between objects 
dist = generate_graph('off');   % 'on': plot graph structure, 'off': do not plot graph structure

to_mds = squeeze(mean(roi5)); % Population mean

% Make it a valid matrix for MDS
% > needs to be symmetric
% > all values need to be positive
% Note: adding a constant only scales the resulting plot, but does not
% change the relationship between elements.

to_mds              = (to_mds + to_mds')/2;     % symmetrize matrix
to_mds              = to_mds + 1;               % add constant to make matrix entries positive 
to_mds(eye(7) == 1) = 0;                        % set diagonal to 0

% Multi-dimensional scalings
Y                   = mdscale(to_mds,2);        

% 2D
figure;
scatter(Y(:,1),Y(:,2),'k','filled')
text(0.05+Y(:,1),0.05+Y(:,2),num2str((1:7)'))   % label objects
set(gcf,'color','w')
set(findobj(gcf, 'type','axes'), 'Visible','off')

% Connect the objects that were experienced during training
[i,j] = find(dist==1);
l=line([Y(i,1),Y(j,1)]',[Y(i,2),Y(j,2)]');
set(l,'color','k');
axis equal

