% 2015-11-4
% According to the original and inversed MT, plot the decomposition results
% and the inversion error.

function Plot_Decomposed_MT(Original_MT_Decom,Inversed_MT_Decom)
% Figure parameters

FontSize=9;
LineWidth=0.1;
MarkerSize=3;
% Get the input parameter property
Source_Num=4;
MT_Name={'ISO','DC','CLVD^-','CLVD^+'};
Legend1={'Ori-ISO','Inv-ISO'};
Legend2={'Ori-CLVD','Inv-CLVD'};
Legend3={'Ori-DC','Inv-DC'};
Legend4={'ISO','CLVD','DC'};

[Total_MT_Num,Com,Model_Num]=size(Original_MT_Decom);
Model_Idx=1:Model_Num;
Random_MT_Num=Total_MT_Num/Source_Num;
Azimuth_Int=2*pi/Model_Num;
Azimuth=(0:Azimuth_Int:2*pi-Azimuth_Int)*180/pi;

% Acoording to the 'Random_MT_Num', plot the different types of figure
switch Random_MT_Num
    case 1
        % Single input source 
        for i=1:Source_Num
            Original_MT=reshape(Original_MT_Decom(i,:,:),3,Model_Num);
            Inversed_MT=reshape(Inversed_MT_Decom(i,:,:),3,Model_Num);
            Inversion_Error_MT=Inversed_MT-Original_MT;
            %% Plot the original and inversed results
            figure
            set(gcf,'PaperPositionMode','manual','PaperUnits','centimeters','PaperPosition',[0 0 9 15])
            % Plot the ISO components
            subplot(3,1,1)
            hold on
            grid on
            plot(Azimuth,Original_MT(1,:)*100,'--sr','LineWidth',LineWidth,'MarkerSize',MarkerSize);
            plot(Azimuth,Inversed_MT(1,:)*100,'-*r','LineWidth',LineWidth,'MarkerSize',MarkerSize);
            %
%             YLim_P1=[floor(min(Inversed_MT(1,:))*10),ceil(max(Inversed_MT(1,:))*10)]/10;
%             YTick_P1=YLim_P1(1):0.1:YLim_P1(2);
%             YTickLabel_P1=YLim_P1(1)*100:10:YLim_P1(2)*100;
%             set(gca,'YLim',YLim_P1,'YTick',YTick_P1,'YTicklabel',YTickLabel_P1,'FontSize',FontSize)
            set(gca,'XLim',[0,350],'FontSize',FontSize)
            ylabel('ISO [%]','FontSize',FontSize);
            xlabel('Oberve well Azimuth [^o]','FontSize',FontSize);
            legend(Legend1,'Location','best','FontSize',FontSize-3);
            Title_P1=['Inversion Result - ',MT_Name{i}];
            title(Title_P1);
            
            % Plot the CLVD components
            subplot(3,1,2)
            hold on
            grid on
            plot(Azimuth,Original_MT(2,:)*100,'--sg','LineWidth',LineWidth,'MarkerSize',MarkerSize);
            plot(Azimuth,Inversed_MT(2,:)*100,'-*g','LineWidth',LineWidth,'MarkerSize',MarkerSize);
            %
%             YLim_P2=[floor(min(Inversed_MT(2,:))*10),ceil(max(Inversed_MT(2,:))*10)]/10;
%             YTick_P2=YLim_P2(1):0.1:YLim_P2(2);
%             YTickLabel_P2=YLim_P2(1)*100:10:YLim_P2(2)*100;
%             set(gca,'YLim',YLim_P2,'YTick',YTick_P2,'YTicklabel',YTickLabel_P2,'FontSize',FontSize)
            set(gca,'XLim',[0,350],'FontSize',FontSize)
            ylabel('CLVD [%]','FontSize',FontSize);
            xlabel('Oberve well Azimuth [^o]','FontSize',FontSize);
            legend(Legend2,'Location','best','FontSize',FontSize-3);
            Title_P2=['Inversion Result - ',MT_Name{i}];
            title(Title_P2);
            
            % Plot the DC components
            subplot(3,1,3)
            hold on
            grid on
            plot(Azimuth,Original_MT(3,:)*100,'--sb','LineWidth',LineWidth,'MarkerSize',MarkerSize);
            plot(Azimuth,Inversed_MT(3,:)*100,'-*b','LineWidth',LineWidth,'MarkerSize',MarkerSize);
            %
%             YLim_P3=[floor(min(Inversed_MT(3,:))*10),ceil(max(Inversed_MT(3,:))*10)]/10;
%             YTick_P3=YLim_P3(1):0.1:YLim_P3(2);
%             YTickLabel_P3=YLim_P3(1)*100:10:YLim_P3(2)*100;
%             set(gca,'YLim',YLim_P3,'YTick',YTick_P3,'YTicklabel',YTickLabel_P3,'FontSize',FontSize)
            set(gca,'XLim',[0,350],'FontSize',FontSize)
            ylabel('DC [%]','FontSize',FontSize);
            xlabel('Oberve well Azimuth [^o]','FontSize',FontSize);
            legend(Legend3,'Location','best','FontSize',FontSize-3)
            Title_P3=['Inversion Result - ',MT_Name{i}];
            title(Title_P3);
            
            % Save the picture
            Title=['Inversion Results - ',MT_Name{i}];
            print('-r300','-dtiff',Title)
            
            set(gcf,'Position',[100 100 800 1400]);
            %% Plot the inversion error
            figure
            set(gcf,'PaperPositionMode','manual','PaperUnits','centimeters','PaperPosition',[0 0 8 6])
            hold on
            grid on
            plot(Azimuth,Inversion_Error_MT(1,:)*100,'-or','LineWidth',LineWidth,'MarkerSize',MarkerSize);
            plot(Azimuth,Inversion_Error_MT(2,:)*100,'-og','LineWidth',LineWidth,'MarkerSize',MarkerSize);
            plot(Azimuth,Inversion_Error_MT(3,:)*100,'-ob','LineWidth',LineWidth,'MarkerSize',MarkerSize);
            %
%             YLim_P2=[floor(min(min(Inversion_Error_MT))*10),ceil(max(max(Inversion_Error_MT))*10)]/10;
%             YTick_P2=YLim_P2(1):0.1:YLim_P2(2);
%             YTickLabel_P2=YLim_P2(1)*100:10:YLim_P2(2)*100;
%             set(gca,'YLim',YLim_P2,'YTick',YTick_P2,'YTicklabel',YTickLabel_P2,'FontSize',FontSize)
            set(gca,'XLim',[0,350],'FontSize',FontSize)
            ylabel('DC and non-DC [%]');
            xlabel('Oberve well Azimuth [^o]');
            legend(Legend4,'Location','best','FontSize',FontSize-3)
            Title_P1=['Inversion Error - ',MT_Name{i}];
            title(Title_P1);
            % Save the picture
            Title_f2=['Inversion Error - ',MT_Name{i}];
            print('-r300','-dtiff',Title_f2)
            
            set(gcf,'Position',[100 100 800 600]);
            
            %% Plot the inversion error (Polar figure) 2015-11-5            
            InvError_MT_Polar=abs([Inversion_Error_MT,Inversion_Error_MT(:,1)]);
            Polar_Azimuth=[Azimuth,360]/180*pi;
            % According to the azimuth and radius plot the polar figure
            % Case 1: Plot all the inversion error in one figure
            % Case 2: Plot this kind of inversion error in 3 subplots
            Plot_Polar_Figure(Polar_Azimuth,InvError_MT_Polar,MT_Name{i},1)
        end
        
    otherwise
        % Multiple input sources
        
end


end