%% Figure 3 - Figure supplement 2
%
% Permutation tests for map in Figure 3E
% data format: subjects x runs x object trial t-1 x object trial t
%
% (c) M.M. Garvert 2017
%%
clear all
close all

% Load data from ROI3
load('ROI3.mat')                    % format: subj x runs x obj trial t-1 x obj trial t
roi3 = squeeze(mean(roi3,2));     % average across experimental runs

%% Generate graph
% dist: distance between objects 
[dist,graph] = generate_graph('off');   % 'on': plot graph structure, 'off': do not plot graph structure

to_mds = squeeze(mean(roi3)); % Population mean

% Make it a valid matrix for MDS
% > needs to be symmetric
% > all values need to be positive
% Note: adding a constant only scales the resulting plot, but does not
% change the relationship between elements.

to_mds              = (to_mds + to_mds')/2;     % symmetrize matrix
to_mds              = to_mds + 1;               % add constant to make matrix entries positive 
to_mds(eye(7) == 1) = 0;                        % set diagonal to 0

% Multi-dimensional scaling
Y_true              = mdscale(to_mds,2);        

% Find connected nodes
[n1,n2] = find(triu(double(graph==1))==1);

Y_ix = perms(1:7);

% Compute distances for all possible permutations of nodes (5040 in total)
c = zeros(5040,42);

for h = 1:5040
    if mod(h,100)==0
        disp(h)
    end
    
    % Distribute nodes randomly
    Y = Y_true(Y_ix(h,:),:);
    c(h,1) = 0;
    counter = 0;
    
    % Do lines between the nodes cross?
    for i = 1:7
        for j = 1:7
            if i ~=j
                counter = counter+1;
                
%                 line1
                x1  = [Y(n1(i),1) Y(n2(i),1)];
                y1  = [Y(n1(i),2) Y(n2(i),2)];

%                 line2
                x2  = [Y(n1(j),1) Y(n2(j),1)];
                y2  = [Y(n1(j),2) Y(n2(j),2)];

                [xi,yi] = polyxpoly(x1,y1,x2,y2);

                if ~isempty([xi,yi])
                    if ~([xi,yi] == [Y(n1(i),1) Y(n2(i),1)] | [xi,yi] == [Y(n1(i),2) Y(n2(i),2)])
                        c(h,counter) = 1;
                    end
                end
                
                
            end
        end
    end
    distances = squareform(pdist(Y));
    
    % Correlation between link distances and Euclidian distances between
    % permuted nodes
    r(h) = corr(dist(eye(7)~=1),distances(eye(7)~=1));                
end

% Count line crossings
c_plot = sum(c,2)/2;

figure;
subplot(1,2,1)
hist(r,20)
subplot(1,2,2)
hold on
for i = 0:10
    bar(i,sum(c_plot==i))
end

% True distances found in the data data
distances = squareform(pdist(Y_true));
r_true = corr(dist(eye(7)~=1),distances(eye(7)~=1));
    
figure; scatter(c_plot,r);
hold on
scatter(0,r_true,'r')
xlabel('Crossings')
xlabel('Correlation with link distance')
xlim([-1 8])
ylim([ -1 1])


% Plot all non-crossing graphs
for h = 1:5040
    
    if sum(c(h,:)) == 0
        Y = Y_true(Y_ix(h,:),:);
   
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
        pause
        close all
    end
end
