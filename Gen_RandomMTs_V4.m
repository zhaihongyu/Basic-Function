% Using different ratio of the 4 kinds of basic MT to generate random MT
% In this version, we divided the MT into CLVD- class and CLVD+ class. 
% Then generate the random MTs class by class
% 2015-10-23
function [New_RandomMts_6xN]=Gen_RandomMTs_V4()
% 4 basic seismic moment tensors 2015-4-27 %
M_ISO_Pos=2/3*[1 0 0;0 1 0;0 0 1];
M_ISO_Neg=-2/3*[1 0 0;0 1 0;0 0 1];
M_DC=[1 0 0;0 0 0;0 0 -1];
M_CLVD_Neg=2/3*[1 0 0;0 1 0;0 0 -2];
M_CLVD_Pos=2/3*[2 0 0;0 -1 0;0 0 -1];
% Random coefficient
Ratio_Int=0.05;
DC_Ratio=0:Ratio_Int:1;

%% Generate explosive random moment tensor
Count_Num=0;
for i=1:size(DC_Ratio,2)
    % 'Residual_Ratio1'=the residual ratio except DC moment tensor
    Residual_Ratio1=-(1-DC_Ratio(i)):Ratio_Int:1-DC_Ratio(i);
    for j=1:size(Residual_Ratio1,2);
        ISO_Ratio=Residual_Ratio1(j);
        % 'CLVD_Ratio'=the residual ratio of CLVD moment tensor
        CLVD_Ratio=0:Ratio_Int:1-abs(ISO_Ratio)-DC_Ratio(i);
        % Generate random MTs using ISO DC and -CLVD MT
        %
        for k=1:size(CLVD_Ratio,2)  
            Count_Num=Count_Num+1; 
            
            RandomMts(:,:,Count_Num)=M_ISO_Pos*ISO_Ratio+M_DC*DC_Ratio(i)+...
                M_CLVD_Neg*CLVD_Ratio(k);
            
            %Transform the MT matrix into MT vector
            RandomMts_6xN(:,Count_Num)=...
                [RandomMts(1,1:3,Count_Num)';...
                RandomMts(2,2:3,Count_Num)';...
                RandomMts(3,3,Count_Num)'];
        end
        %}
        % Generate random MTs using ISO DC and +CLVD MT
        %
        for k=1:size(CLVD_Ratio,2)        
            Count_Num=Count_Num+1; 
            
            RandomMts(:,:,Count_Num)=M_ISO_Pos*ISO_Ratio+M_DC*DC_Ratio(i)+...
                M_CLVD_Pos*CLVD_Ratio(k);
            
            %Transform the MT matrix into MT vector
            RandomMts_6xN(:,Count_Num)=...
                [RandomMts(1,1:3,Count_Num)';...
                RandomMts(2,2:3,Count_Num)';...
                RandomMts(3,3,Count_Num)']; 
        end
        %}
    end
end
% Adding random noise to the random moment tensor 2015-6-17 %
%
Per_Coe=0.05;
RandomMTs_Num=size(RandomMts_6xN,2);
RandMT_ValueOri=rand(6,RandomMTs_Num)*Per_Coe;
RandomMts_6xN=RandomMts_6xN+RandMT_ValueOri;
%}
% Delete the same moment tensor
Zero_MT=zeros(6,1);
for i=1:Count_Num
    for j=i+1:Count_Num
        Error=sum(abs(RandomMts_6xN(:,i)-RandomMts_6xN(:,j)));
        if Error<=2.5E-1
            RandomMts_6xN(:,j)=Zero_MT;
        end
        
    end
end
RandomMts_6xN_Sum=sum(abs(RandomMts_6xN));
[Idx]=find(RandomMts_6xN_Sum>0);
New_RandomMts_6xN=RandomMts_6xN(:,Idx);

% 
f2=figure();
set(f2,'position',[0 0 900 700])
hold on;
% Transform the T-k parameters to x-y coordinates
[RandomTk]=MT_To_Tk(New_RandomMts_6xN);
[RandomTk_XY]=Tk_To_XY(RandomTk);

%         Plot the Source-Type diagram
axis off;
Plot_SourceTD();
FontSize=20;
Markersize=7;
LineWidth=2;
%
p1=plot(RandomTk_XY(1,:),RandomTk_XY(2,:),'*','LineWidth',LineWidth);
set(p1,'Markersize',Markersize,'Markeredgecolor','r');

Title='Initial Random Micro-source Mechanism';
title(Title,'FontSize',FontSize);
set(f2,'PaperPositionMode','manual','PaperUnits','centimeters','PaperPosition',[0 0 8 6]);
print(f2,'-r300','-dtiff',Title);
end
