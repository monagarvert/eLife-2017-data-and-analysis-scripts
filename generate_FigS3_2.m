%% Figure 3 - figure supplement 2
%
% Computes null distribution for mapping into 2D space
%
%
%%
clear all
close all

% Load data from ROI3
load('ROI3.mat')                    % format: subj x runs x obj trial t-1 x obj trial t
roi3 = squeeze(mean(roi3,2));     % average across experimental runs

%% Generate graph
% dist: distance between objects 
[dist,graph] = generate_graph('off');   % 'on': plot graph structure, 'off': do not plot graph structure
raw_data = squeeze(mean(roi3)); % Population mean

% Make it a valid matrix for MDS to find location of nodes
% > needs to be symmetric
% > all values need to be positive
% Note: adding a constant only scales the resulting plot, but does not
% change the relationship between elements.

to_mds              = (raw_data + raw_data')/2; % symmetrize matrix
to_mds              = to_mds + 1;               % add constant to make matrix entries positive 
to_mds(eye(7) == 1) = 0;                        % set diagonal to 0

% Multi-dimensional scaling to find the best mapping of the distance matrix
% into 2D space
Y              = mdscale(to_mds,2);  

% Compute MDS-mapped distances 
distances_true = squareform(pdist(Y));  

% Link distances on the reduced graph structure
links_true = zeros(7,7);
links_true(1,2) = 1; links_true(1,3) = 1; links_true(2,3) = 1;
links_true(3,4) = 1; links_true(3,5) = 1; links_true(4,6) = 1; links_true(5,7) = 1;
links_true = links_true + links_true';
links_true = graphallshortestpaths(sparse(links_true));

% Correlation between link distances for the link distances extracted from 
% the actual graph structure and 
% distances resulting from multi-dimensional scaling on the neural data
r_true = corr(links_true(eye(7)~=1),distances_true(eye(7)~=1));    

v = 1:21; 
links = nchoosek(v,7);

gm      = squareform(1:21);
gm      = triu(gm);
    
% Permute links and test whether the graph is still complete. Only include
% complete graphs
ix = [];
count = 0;
link_m = [];
for h = 1:length(links)
    if mod(h,100)==0, disp(h), end
    
    % Adjacency matrix describing the graph structure
    lm = ismember(gm, links(h,:)); 
    lm = lm + lm';
    
    % Test whether the graph is complete and add this combination to link_m
    % if it is
    if all(graphallshortestpaths(sparse(lm))~=Inf)
        count = count+1;
        link_m(count,:,:) = lm;
        ix = [ix h];
    end
end

c = zeros(length(ix),7);
r = zeros(length(ix),1);

size(ix) % Number of complete graphs
for il = 1:length(ix);
    if mod(il,100)==0, disp(il), end
    
    [n1,n2] = find(triu(squeeze(link_m(il,:,:)))==1);

    counter = 0;
    
    % Tests if lines cross
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
                    if ~(xi == Y(n1(i),1) && yi == Y(n1(i),2)) && ~(xi == Y(n2(i),1) && yi == Y(n2(i),2))
                        c(il,counter) = 1;
                    end
                end
            end
        end
    end
    
    
    dist = graphallshortestpaths(sparse(squeeze(link_m(il,:,:))));
    
    % Correlate resulting distance matrix with 
    r(il) = corr(dist(eye(7)~=1),distances_true(eye(7)~=1));  
end

c_plot = sum(c,2)/2;

% Plot results
figure;
subplot(1,2,1)
bar(-0.65:0.1:1,histc(r,-0.65:0.1:1))
xlim([-1 1])
set(gca,'TickDir','out')
xlabel('Correlation between MDS-mapped distances and link distances')
ylabel('Frequency')
sum(r>r_true)/length(r);
% Careful: position of x-ticks shifted by 0.5

subplot(1,2,2)
hold on
for i = 0:10
    bar(i,sum(c_plot==i))
end
xlabel('Number of links crossing paths')
ylabel('Frequency')

sum(c_plot==0)/length(c_plot)

sum(r>r_true & c_plot==0)/length(r)
