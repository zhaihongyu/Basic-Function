% 2015-11-6
% According to the decomposition results, plot the ISO, DC and CLVD
% compents' percentage.
function Plot_MT_Decom(MT_Name,MT_Decomposition)
FontSize=9;
Axis_LineWidth=0.1;
LineWidth=1;
MarkerSize=3;
% Plot the result of MT decomposition
figure
hold on
Title=['MT components of random',MT_Name];
FaceColor={'r','g','b'};
XLabel={'ISO Percent [%]','DC Percent [%]','CLVD Percent [%]'};
set(gcf,'PaperPositionMode','manual','PaperUnits','centimeters','PaperPosition',[0 0 15 5]);
set(gcf,'Position',[100 100 900 400])
for i=1:3
    subplot(1,3,i)
    Bin_Num=8;
    h1=histogram(MT_Decomposition(:,i),Bin_Num);
    set(h1,'FaceColor',FaceColor{i})
    % Set the axis properties
    XTick=h1.BinEdges(1:2:Bin_Num+1);
    XTick_Label=round(XTick*100);
    set(gca,'XLim',h1.BinLimits,'XTick',XTick,'XTickLabel',XTick_Label);
    set(gca,'FontSize',FontSize);
    xlabel(XLabel{i});
end
print('-r300','-dtiff',Title)
end