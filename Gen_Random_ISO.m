% 2015-11-6
% Generate random ISO moment tensor
% In this version, we using the random ratio to replace the circulation
function [New_Random_ISOs_6xN]=Gen_Random_ISO()
%% 4 basic moment tensor
Random_RowNum=50;
Random_ColNum=10;
M_ISO_Pos=2/3*[1 0 0;0 1 0;0 0 1];
M_ISO_Neg=-2/3*[1 0 0;0 1 0;0 0 1];
M_DC=[1 0 0;0 0 0;0 0 -1];
M_CLVD_Neg=2/3*[1 0 0;0 1 0;0 0 -2];
M_CLVD_Pos=2/3*[2 0 0;0 -1 0;0 0 -1];
% Identify the ratio of every kind of MT
% ISO_Ratio=ones(Random_RowNum,1)*0.7;
ISO_Ratio=ones(Random_RowNum,1)-abs(rand(Random_RowNum,1)*0.15);
% 
DC_Ratio=zeros(Random_RowNum,Random_ColNum);
for i=1:Random_RowNum
    DC_Ratio(i,:)=abs(rand(1,Random_ColNum)*(1-ISO_Ratio(i)));
end
% 
CLVD_Pos_Ratio=zeros(Random_RowNum,Random_ColNum/2);
CLVD_Neg_Ratio=zeros(Random_RowNum,Random_ColNum/2);
for i=1:Random_RowNum
    CLVD_Pos_Ratio(i,:)=ones(1,Random_ColNum/2)*(1-ISO_Ratio(i))-DC_Ratio(i,1:Random_ColNum/2);
    CLVD_Neg_Ratio(i,:)=ones(1,Random_ColNum/2)*(1-ISO_Ratio(i))-DC_Ratio(i,Random_ColNum/2+1:Random_ColNum);
end

%% Calculate the random ISO moment tensor
Random_Num=Random_RowNum*Random_ColNum;
Random_ISOs=cell(Random_RowNum,Random_ColNum);
Random_ISOs_6xN=zeros(6,Random_Num);

for i=1:Random_RowNum
    for j=1:Random_ColNum/2
        Random_ISOs{i,j}=ISO_Ratio(i)*M_ISO_Pos+DC_Ratio(i,j)*M_DC+CLVD_Pos_Ratio(i,j)*M_CLVD_Pos;
        Random_ISOs{i,j+Random_ColNum/2}=ISO_Ratio(i)*M_ISO_Pos...
            +DC_Ratio(i,j+Random_ColNum/2)*M_DC...
            +CLVD_Neg_Ratio(i,j)*M_CLVD_Neg;
    end
    
end
% Transfor the MT into vector
Count=0;
for i=1:Random_RowNum
    for j=1:Random_ColNum
        Count=Count+1;
        Random_ISO=Random_ISOs{i,j};
        Random_ISOs_6xN(:,Count)=[Random_ISO(1,:)';Random_ISO(2,2:3)';Random_ISO(3,3)];
    end
    
end
% Transform the T-k parameters to x-y coordinates
[RandomISOs_Tk]=MT_To_Tk(Random_ISOs_6xN);
[RandomISOs_XY]=Tk_To_XY(RandomISOs_Tk);
% Delete the close MT
Zero_Tk=zeros(2,1);
for i=1:Count
    for j=i+1:Count
        Error=sum(abs(RandomISOs_XY(:,i)-RandomISOs_XY(:,j)));
        if Error<=2E-2
            RandomISOs_XY(:,j)=Zero_Tk;
        end
        
    end
end
RandomMts_6xN_Sum=sum(abs(RandomISOs_XY));
[Idx]=find(RandomMts_6xN_Sum>0);
New_Random_ISOs_6xN=Random_ISOs_6xN(:,Idx);
New_RandomISOs_XY=RandomISOs_XY(:,Idx);

%% Display the random ISO moment tensor
f2=figure();
set(f2,'position',[0 0 900 700])
hold on;

%         Plot the Source-Type diagram
axis off;
Plot_SourceTD();
FontSize=20;
Markersize=7;
LineWidth=2;
%
p1=plot(New_RandomISOs_XY(1,:),New_RandomISOs_XY(2,:),'.','LineWidth',LineWidth);
set(p1,'Markersize',Markersize,'Markeredgecolor','r');

Title='Initial Random Micro-source Mechanism';
title(Title,'FontSize',FontSize);
set(f2,'PaperPositionMode','manual','PaperUnits','centimeters','PaperPosition',[0 0 8 6]);
% print(f2,'-r300','-dtiff',Title);
end