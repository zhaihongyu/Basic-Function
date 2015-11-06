% Using different ratio of the 4 kinds of basic MT to generate random MT
% In this version, we divided the MT into ISO- class and ISO+ class. 
% Then generate the random MTs class by class
% 2015-10-19
function [Final_RandomMts_6xN]=Gen_RandomMTs_V3()
% 4 basic seismic moment tensors 2015-4-27 %
M_ISO_Pos=2/3*[1 0 0;0 1 0;0 0 1];
M_ISO_Neg=-2/3*[1 0 0;0 1 0;0 0 1];
M_DC=[1 0 0;0 0 0;0 0 -1];
M_CLVD_Neg=2/3*[1 0 0;0 1 0;0 0 -2];
M_CLVD_Pos=2/3*[2 0 0;0 -1 0;0 0 -1];
% Random coefficient
Ratio_Int=0.04;
Ratio=0:Ratio_Int:1;

%% Generate explosive random moment tensor
Count_Num=0;
for i=1:size(Ratio,2)
    ISO_Ratio=Ratio(i);
    % 'Residual_Ratio1'=the residual ratio except ISO moment tensor
    Residual_Ratio1=0:Ratio_Int:1-ISO_Ratio;
    for j=1:size(Residual_Ratio1,2);
        DC_Ratio=Residual_Ratio1(j);
        % 'Residual_Ratio2'=the residual ratio except ISO&DC moment tensor
        Residual_Ratio2=0:Ratio_Int:1-ISO_Ratio-DC_Ratio;
        for k=1:size(Residual_Ratio2,2)
            CLVD_Neg_Ratio=Residual_Ratio2(k);
            CLVD_Pos_Ratio=1-ISO_Ratio-DC_Ratio-CLVD_Neg_Ratio;
            Count_Num=Count_Num+1;
            
            RandomMts_Pos(:,:,Count_Num)=M_ISO_Pos*ISO_Ratio+M_DC*DC_Ratio+...
                M_CLVD_Neg*CLVD_Neg_Ratio+M_CLVD_Pos*CLVD_Pos_Ratio;
            %Transform the MT matrix into MT vector
            RandomMts_6xN_Pos(:,Count_Num)=...
                [RandomMts_Pos(1,1:3,Count_Num)';RandomMts_Pos(2,2:3,Count_Num)';RandomMts_Pos(3,3,Count_Num)'];
        end
        
    end
end
% Adding random noise to the random moment tensor 2015-6-17 %
Per_Coe=0.05;
RandomMTs_Num=size(RandomMts_6xN_Pos,2);
RandMT_ValueOri=rand(6,RandomMTs_Num)*Per_Coe;
RandomMts_6xN_Pos=RandomMts_6xN_Pos+RandMT_ValueOri;
% Delete the same moment tensor
Zero_MT=zeros(6,1);
for i=1:Count_Num
    for j=i+1:Count_Num
        Error=sum(abs(RandomMts_6xN_Pos(:,i)-RandomMts_6xN_Pos(:,j)));
        if Error<=1E-1
            RandomMts_6xN_Pos(:,j)=Zero_MT;
        end
        
    end
end
RandomMts_6xN_Sum=sum(abs(RandomMts_6xN_Pos));
[Idx]=find(RandomMts_6xN_Sum>0);
New_RandomMts_6xN_Pos=RandomMts_6xN_Pos(:,Idx);

%% Generate compressive random moment tensor
Count_Num=0;
for i=1:size(Ratio,2)
    ISO_Ratio=Ratio(i);
    % 'Residual_Ratio1'=the residual ratio except ISO moment tensor
    Residual_Ratio1=0:Ratio_Int:1-ISO_Ratio;
    for j=1:size(Residual_Ratio1,2);
        DC_Ratio=Residual_Ratio1(j);
        % 'Residual_Ratio2'=the residual ratio except ISO&DC moment tensor
        Residual_Ratio2=0:Ratio_Int:1-ISO_Ratio-DC_Ratio;
        for k=1:size(Residual_Ratio2,2)
            CLVD_Neg_Ratio=Residual_Ratio2(k);
            CLVD_Pos_Ratio=1-ISO_Ratio-DC_Ratio-CLVD_Neg_Ratio;
            Count_Num=Count_Num+1;
            
            RandomMts_Neg(:,:,Count_Num)=M_ISO_Neg*ISO_Ratio+M_DC*DC_Ratio+...
                M_CLVD_Neg*CLVD_Neg_Ratio+M_CLVD_Pos*CLVD_Pos_Ratio;
            %Transform the MT matrix into MT vector
            RandomMts_6xN_Neg(:,Count_Num)=...
                [RandomMts_Neg(1,1:3,Count_Num)';RandomMts_Neg(2,2:3,Count_Num)';RandomMts_Neg(3,3,Count_Num)'];
        end
        
    end
end
% Adding random noise to the random moment tensor 2015-6-17 %
Per_Coe=0.05;
RandomMTs_Num=size(RandomMts_6xN_Neg,2);
RandMT_ValueOri=rand(6,RandomMTs_Num)*Per_Coe;
RandomMts_6xN_Neg=RandomMts_6xN_Neg+RandMT_ValueOri;
% Delete the same moment tensor
Zero_MT=zeros(6,1);
for i=1:Count_Num
    for j=i+1:Count_Num
        Error=sum(abs(RandomMts_6xN_Neg(:,i)-RandomMts_6xN_Neg(:,j)));
        if Error<=1E-1
            RandomMts_6xN_Neg(:,j)=Zero_MT;
        end
        
    end
end
RandomMts_6xN_Sum=sum(abs(RandomMts_6xN_Neg));
[Idx]=find(RandomMts_6xN_Sum>0);
New_RandomMts_6xN_Neg=RandomMts_6xN_Neg(:,Idx);

%% Plot the random MT
New_RandomMts_6xN=[New_RandomMts_6xN_Pos,New_RandomMts_6xN_Neg];

% Delete the same moment tensor
Zero_MT=zeros(6,1);
for i=1:size(New_RandomMts_6xN,2)
    for j=i+1:size(New_RandomMts_6xN,2)
        Error=sum(abs(New_RandomMts_6xN(:,i)-New_RandomMts_6xN(:,j)));
        if Error<=2.5E-1
            New_RandomMts_6xN(:,j)=Zero_MT;
        end
        
    end
end
RandomMts_6xN_Sum=sum(abs(New_RandomMts_6xN));
[Idx]=find(RandomMts_6xN_Sum>0);
Final_RandomMts_6xN=New_RandomMts_6xN(:,Idx);

f2=figure();
set(f2,'position',[0 0 900 700])
hold on;
% Transform the T-k parameters to x-y coordinates
[RandomTk]=MT_To_Tk(Final_RandomMts_6xN);
[RandomTk_XY]=Tk_To_XY(RandomTk);

%         Plot the Source-Type diagram
axis off;
Plot_SourceTD();
FontSize=20;
Markersize=7;
LineWidth=2;
%
p1=plot(RandomTk_XY(1,:),RandomTk_XY(2,:),'o','LineWidth',LineWidth);
set(p1,'Markersize',Markersize,'Markeredgecolor','r');

Title='Initial Random Micro-source Mechanism';
title(Title,'FontSize',FontSize);
set(f2,'PaperPositionMode','manual','PaperUnits','centimeters','PaperPosition',[0 0 8 6]);
print(f2,'-r300','-dtiff',Title);
end
