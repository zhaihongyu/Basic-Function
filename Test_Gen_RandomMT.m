% Test generating single kind of random MT
clc
clear all
close all
% 
[Random_ISOs]=Gen_Random_ISO();
[Random_DCs]=Gen_Random_DC();
[Random_PosCLVDs]=Gen_Random_PosCLVD();
[Random_NegCLVDs]=Gen_Random_NegCLVD();

ISOs_Num=size(Random_ISOs,2);
DCs_Num=size(Random_DCs,2);
PosCLVDs_Num=size(Random_PosCLVDs,2);
NegCLVDs_Num=size(Random_NegCLVDs,2);

% Calculate the percentage of random ISO MTs
Percent_ISOs=zeros(ISOs_Num,3);
for i=1:ISOs_Num
    RandomMts=Random_ISOs(:,i);
    % Transform the MT to 3*3 matrix
    Input_MT=[RandomMts(1:3)';...
        RandomMts(2),RandomMts(4:5)';...
        RandomMts(3),RandomMts(5),RandomMts(6)];
    % Decompose the MT
    Percent_ISOs(i,:)=Decompose_MT(Input_MT);
end

% Calculate the percentage of random DC MTs
Percent_DCs=zeros(DCs_Num,3);
for i=1:DCs_Num
    RandomMts=Random_DCs(:,i);
    % Transform the MT to 3*3 matrix
    Input_MT=[RandomMts(1:3)';...
        RandomMts(2),RandomMts(4:5)';...
        RandomMts(3),RandomMts(5),RandomMts(6)];
    % Decompose the MT
    Percent_DCs(i,:)=Decompose_MT(Input_MT);
end

% Calculate the percentage of random PosCLVD MTs
Percent_PosCLVDs=zeros(PosCLVDs_Num,3);
for i=1:PosCLVDs_Num
    RandomMts=Random_PosCLVDs(:,i);
    % Transform the MT to 3*3 matrix
    Input_MT=[RandomMts(1:3)';...
        RandomMts(2),RandomMts(4:5)';...
        RandomMts(3),RandomMts(5),RandomMts(6)];
    % Decompose the MT
    Percent_PosCLVDs(i,:)=Decompose_MT(Input_MT);
end

% Calculate the percentage of random NegCLVD MTs
Percent_NegCLVDs=zeros(NegCLVDs_Num,3);
for i=1:NegCLVDs_Num
    RandomMts=Random_NegCLVDs(:,i);
    % Transform the MT to 3*3 matrix
    Input_MT=[RandomMts(1:3)';...
        RandomMts(2),RandomMts(4:5)';...
        RandomMts(3),RandomMts(5),RandomMts(6)];
    % Decompose the MT
    Percent_NegCLVDs(i,:)=Decompose_MT(Input_MT);
end

% Plot the percent of all MTs
Plot_MT_Decom('ISO',Percent_ISOs)
Plot_MT_Decom('DC',Percent_DCs)
Plot_MT_Decom('PosCLVD',Percent_PosCLVDs)
Plot_MT_Decom('NegCLVD',Percent_NegCLVDs)
