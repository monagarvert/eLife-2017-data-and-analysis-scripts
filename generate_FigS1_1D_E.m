%% %% Figure 1 - figure supplement 1D,E
%
% response times and % correct for cover task during the scan
% Format: subjects x blocks
%
%%
clear all
close all

% Load behavioural data (RT and %correct for each object during the scan)
load('behaviour.mat')

m_rt_o = squeeze(mean(rt_object,2)); m_cr_o = squeeze(mean(cr_object,2))*100;

figure;
subplot(2,1,1)
bar(1:7,mean(m_rt_o),'facecolor',[0.5 0.5 0.5],'edgecolor',[0.5 0.5 0.5])
hold on
errorbar(1:7,mean(m_rt_o),std(m_rt_o)/sqrt(23),'k','linestyle','none')
set(gcf,'color','w')
box off
set(gca,'TickDir','out','XTick',1:7)
ylim([500 700])
ylabel('Reaction time')
xlabel('Object position')

subplot(2,1,2)
bar(1:7,mean(m_cr_o),'facecolor',[0.5 0.5 0.5],'edgecolor',[0.5 0.5 0.5])
hold on
errorbar(1:7,mean(m_cr_o),std(m_cr_o)/sqrt(23),'k','linestyle','none')
set(gcf,'color','w')
box off
set(gca,'TickDir','out','XTick',1:7)
ylim([50 100])
ylabel('Percent correct')
xlabel('Object position')