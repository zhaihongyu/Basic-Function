% Transform the moment tensor to T-k parameters
function [T_k]=MT_To_Tk(Inversion_m)
% The T & k parameters are calculated according to the different types of MT
M_R=size(Inversion_m,2);
T_k=zeros(2,M_R);
Inversion_MT=zeros(3,3);
Derivative_M=zeros(3,3);
for i=1:M_R
    Inversion_MT(1,1:3)=Inversion_m(1:3,i);
    Inversion_MT(2,1)=Inversion_m(2,i);
    Inversion_MT(2,2:3)=Inversion_m(4:5,i);
    Inversion_MT(3,1)=Inversion_m(3,i);
    Inversion_MT(3,2)=Inversion_m(5,i);
    Inversion_MT(3,3)=Inversion_m(6,i);
    [M_Vec,M_D]=eig(Inversion_MT);
    Aver_M=(M_D(1,1)+M_D(2,2)+M_D(3,3))/3;
    for j=1:3
        Derivative_M(i,j)=M_D(j,j)-Aver_M;
    end
%     Derivative_M(i,:)=abs(Derivative_M(i,:));
    [Sort_M,Sort_Id]=sort(Derivative_M(i,:),'descend');
    Derivative_M(i,:)=Derivative_M(i,Sort_Id);
    %{
%      Leading Edge March 2010
%      Calculate T
    T_k(1,i)=2*Derivative_M(i,1)/abs(Derivative_M(i,3));
%      Calculate k
    T_k(2,i)=Aver_M/(abs(Aver_M)+abs(Derivative_M(i,3)));
    %}

%     Calculate T
%     Hudson et al. 1989
    if Derivative_M(i,2)>10^-4
        T_k(1,i)=-2*Derivative_M(i,2)/Derivative_M(i,3);
    elseif abs(Derivative_M(i,3))<=10^-4
        T_k(1,i)=0;
    else
        T_k(1,i)=2*Derivative_M(i,2)/Derivative_M(i,1);
    end
%     Calculate k
    if Derivative_M(i,2)>=0
        T_k(2,i)=Aver_M/(abs(Aver_M)-Derivative_M(i,3));
    end
    if Derivative_M(i,2)<=0
        T_k(2,i)=Aver_M/(abs(Aver_M)+Derivative_M(i,1));
    end
    %}
end