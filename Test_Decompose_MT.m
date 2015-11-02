% Test the decomposition program

% Generate random MTs
[RandomMts]=Gen_RandomMTs_V4();
% Get the number of MTs
MTs_Num=size(RandomMts,2);
Percent_MTs=zeros(MTs_Num,3);
% Decompose the MT one by one
for i=1:MTs_Num
    % Transform the MT to 3*3 matrix
    Input_MT=[RandomMts(1:3,i)';...
        RandomMts(2,i),RandomMts(4:5,i)';...
        RandomMts(3,i),RandomMts(5,i),RandomMts(6,i)];
    % Decompose the MT
    Percent_MTs(i,:)=Decompose_MT(Input_MT);
end

% Plot the percent of all MTs
figure
MT_Idx=1:MTs_Num;
plot(MT_Idx,Percent_MTs','*');

figure
subplot(1,3,1)
hist(Percent_MTs(:,1),10);
subplot(1,3,2)
hist(Percent_MTs(:,2),10);
subplot(1,3,3)
hist(Percent_MTs(:,3),10);
