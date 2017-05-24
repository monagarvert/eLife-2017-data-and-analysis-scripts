%% Figure 1 - figure supplement 1A,B
%
% response times and % correct during training
% Format: subjects x blocks
%
%%
clear all
close all

% Load training data (RT and %correct during training)
load('behaviour.mat')

figure; bar(nanmean(rt_train),'facecolor',[0.5 0.5 0.5])
hold on
errorbar(1:12,nanmean(rt_train),nanstd(rt_train)./sqrt(sum(rt_train>1)),'k','linestyle','none')
ylim([400 800])
xlabel('Block')
ylabel('Response time')
box off
set(gcf,'color','w')

figure; bar(nanmean(cr_train),'facecolor',[0.5 0.5 0.5])
hold on
errorbar(1:12,nanmean(cr_train),nanstd(cr_train)./sqrt(sum(cr_train>0)),'k','linestyle','none')
ylim([50 100])
xlabel('Block')
ylabel('Percent correct')
box off
set(gcf,'color','w')