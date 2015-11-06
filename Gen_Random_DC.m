% 2015-11-6
% Generate random ISO moment tensor
% In this version, we using the random ratio to replace the circulation
function [New_Random_DCs_6xN]=Gen_Random_DC()
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
DC_Ratio=ones(Random_RowNum,1)-abs(rand(Random_RowNum,1)*0.15);
% 
ISO_Ratio=zeros(Random_RowNum,Random_ColNum);
for i=1:Random_RowNum
    ISO_Ratio(i,:)=rand(1,Random_ColNum)*(1-DC_Ratio(i));
end
% 
CLVD_Pos_Ratio=zeros(Random_RowNum,Random_ColNum/2);
CLVD_Neg_Ratio=zeros(Random_RowNum,Random_ColNum/2);
for i=1:Random_RowNum
    CLVD_Pos_Ratio(i,:)=ones(1,Random_ColNum/2)*(1-DC_Ratio(i))-abs(ISO_Ratio(i,1:Random_ColNum/2));
    CLVD_Neg_Ratio(i,:)=ones(1,Random_ColNum/2)*(1-DC_Ratio(i))-abs(ISO_Ratio(i,Random_ColNum/2+1:Random_ColNum));
end

%% Calculate the random +DC moment tensor
Random_Num=Random_RowNum*Random_ColNum;
Random_DCs_Part1=cell(Random_RowNum,Random_ColNum);
Random_DCs_6xN_Part1=zeros(6,Random_Num);

for i=1:Random_RowNum
    for j=1:Random_ColNum/2
        Random_DCs_Part1{i,j}=DC_Ratio(i)*M_DC+ISO_Ratio(i,j)*M_ISO_Pos+CLVD_Pos_Ratio(i,j)*M_CLVD_Pos;
        Random_DCs_Part1{i,j+Random_ColNum/2}=DC_Ratio(i)*M_DC...
            +ISO_Ratio(i,j+Random_ColNum/2)*M_ISO_Pos...
            +CLVD_Neg_Ratio(i,j)*M_CLVD_Neg;
    end
    
end
% Transfor the MT into vector
Count=0;
for i=1:Random_RowNum
    for j=1:Random_ColNum
        Count=Count+1;
        Random_DC=Random_DCs_Part1{i,j};
        Random_DCs_6xN_Part1(:,Count)=[Random_DC(1,:)';Random_DC(2,2:3)';Random_DC(3,3)];
    end
    
end
% Transform the T-k parameters to x-y coordinates
[RandomDCs_Tk_Part1]=MT_To_Tk(Random_DCs_6xN_Part1);
[RandomDCs_XY_Part1]=Tk_To_XY(RandomDCs_Tk_Part1);
% Delete the close MT
Zero_Tk=zeros(2,1);
for i=1:Count
    for j=i+1:Count
        Error=sum(abs(RandomDCs_XY_Part1(:,i)-RandomDCs_XY_Part1(:,j)));
        if Error<=2E-2
            RandomDCs_XY_Part1(:,j)=Zero_Tk;
        end
        
    end
end
RandomMts_6xN_Sum=sum(abs(RandomDCs_XY_Part1));
[Idx]=find(RandomMts_6xN_Sum>0);
New_Random_DCs_6xN_P1=Random_DCs_6xN_Part1(:,Idx);
New_RandomDCs_XY_P1=RandomDCs_XY_Part1(:,Idx);

%% Calculate the random -DC moment tensor
% -ISO Ratio
for i=1:Random_RowNum
    ISO_Ratio(i,:)=-rand(1,Random_ColNum)*(1-DC_Ratio(i));
end
Random_DCs_Part2=cell(Random_RowNum,Random_ColNum);
Random_DCs_6xN_Part2=zeros(6,Random_Num);

for i=1:Random_RowNum
    for j=1:Random_ColNum/2
        Random_DCs_Part2{i,j}=DC_Ratio(i)*M_DC+ISO_Ratio(i,j)*M_ISO_Pos+CLVD_Pos_Ratio(i,j)*M_CLVD_Pos;
        Random_DCs_Part2{i,j+Random_ColNum/2}=DC_Ratio(i)*M_DC...
            +ISO_Ratio(i,j+Random_ColNum/2)*M_ISO_Pos...
            +CLVD_Neg_Ratio(i,j)*M_CLVD_Neg;
    end
    
end
% Transfor the MT into vector
Count=0;
for i=1:Random_RowNum
    for j=1:Random_ColNum
        Count=Count+1;
        Random_DC=Random_DCs_Part2{i,j};
        Random_DCs_6xN_Part2(:,Count)=[Random_DC(1,:)';Random_DC(2,2:3)';Random_DC(3,3)];
    end
    
end
% Transform the T-k parameters to x-y coordinates
[RandomDCs_Tk_Part2]=MT_To_Tk(Random_DCs_6xN_Part2);
[RandomDCs_XY_Part2]=Tk_To_XY(RandomDCs_Tk_Part2);
% Delete the close MT
Zero_Tk=zeros(2,1);
for i=1:Count
    for j=i+1:Count
        Error=sum(abs(RandomDCs_XY_Part2(:,i)-RandomDCs_XY_Part2(:,j)));
        if Error<=2E-2
            RandomDCs_XY_Part2(:,j)=Zero_Tk;
        end
        
    end
end
RandomMts_6xN_Sum=sum(abs(RandomDCs_XY_Part2));
[Idx]=find(RandomMts_6xN_Sum>0);
New_Random_DCs_6xN_P2=Random_DCs_6xN_Part2(:,Idx);
New_RandomDCs_XY_P2=RandomDCs_XY_Part2(:,Idx);

%% Combine the part1 and part2 random DC MTs
New_Random_DCs_6xN=[New_Random_DCs_6xN_P1,New_Random_DCs_6xN_P2];
New_RandomDCs_XY=[New_RandomDCs_XY_P1,New_RandomDCs_XY_P2];
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
p1=plot(New_RandomDCs_XY(1,:),New_RandomDCs_XY(2,:),'.','LineWidth',LineWidth);
set(p1,'Markersize',Markersize,'Markeredgecolor','r');

Title='Initial Random Micro-source Mechanism';
title(Title,'FontSize',FontSize);
set(f2,'PaperPositionMode','manual','PaperUnits','centimeters','PaperPosition',[0 0 8 6]);
% print(f2,'-r300','-dtiff',Title);
end