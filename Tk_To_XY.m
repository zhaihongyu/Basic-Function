% Transform the T-k parameters to x-y coordinates
function [Tk_XY]=Tk_To_XY(T_k)

M_R=size(T_k,2);
Tk_XY=zeros(2,M_R);

for i=1:M_R
% % %     Calculate the x-y coordinates in different quadrant
% %     2nd quadrant
    if T_k(1,i)<=0&&T_k(2,i)>=0
%         Using the geomatrical relationship to calculate the x,y corrdinate
        L=sqrt((T_k(1,i))^2+1)*T_k(2,i);
        DeltaT=L*cos(atan(1/T_k(1,i)));
        Tk_XY(1,i)=T_k(1,i)+DeltaT;
        Tk_XY(2,i)=T_k(2,i);
%         Tk_XY(:,i)=[1/T_k(1,i) 1;0 1]\[1;T_k(2,i)];
    end
% %     4th quadrant
    if T_k(1,i)>=0&&T_k(2,i)<=0
%         Using the geomatrical relationship to calculate the x,y corrdinate
        L=sqrt((T_k(1,i))^2+1)*T_k(2,i);
        DeltaT=L*cos(atan(1/T_k(1,i)));
        Tk_XY(1,i)=T_k(1,i)+DeltaT;
        Tk_XY(2,i)=T_k(2,i);
%         Tk_XY(:,i)=[1/T_k(1,i) -1;0 1]\[1;T_k(2,i)];
    end
% %     3rd quadrant
    if T_k(1,i)<0&&T_k(2,i)<0
        TSlant_L=-sqrt((4/3)^2+(1/3)^2)*T_k(1,i);
%         Calculate the slant point corresponding to the T value
        Slant_PointX=-sqrt(16/17)*TSlant_L;
        Slant_PointY=Slant_PointX/4;
%         Calculate the k value corresponding to the slant point
        kSlant_L1=sqrt((Slant_PointX)^2+(Slant_PointY+1)^2);
        kSlant_L2=sqrt((Slant_PointX-T_k(1,i))^2+(Slant_PointY)^2);
        k_SP=-kSlant_L2/(kSlant_L1+kSlant_L2);
%         According to the k_SP identify the x-y position
        if T_k(2,i)>=k_SP   % the x-y position is up the line of  y=x/4
            Theta=atan(-Slant_PointY/(T_k(1,i)-Slant_PointX));
            Real_kSlant_L=-(kSlant_L1+kSlant_L2)*T_k(2,i);
            
            Tk_XY(1,i)=T_k(1,i)-Real_kSlant_L*cos(Theta);
            Tk_XY(2,i)=-Real_kSlant_L*sin(Theta);
        else % the x-y position is under the line of y=x/4
            Theta=atan(-Slant_PointX/(1+Slant_PointY));
            Real_kSlant_L=(kSlant_L1+kSlant_L2)*(1+T_k(2,i));
            
            Tk_XY(1,i)=-Real_kSlant_L*sin(Theta);
            Tk_XY(2,i)=Real_kSlant_L*cos(Theta)-1;
        end
    end
% %     1st quadrant
    if T_k(1,i)>0&&T_k(2,i)>0
        TSlant_L=sqrt((4/3)^2+(1/3)^2)*T_k(1,i);
%         Calculate the slant point corresponding to the T value
        Slant_PointX=sqrt(16/17)*TSlant_L;
        Slant_PointY=Slant_PointX/4;
%         Calculate the k value corresponding to the slant point
        kSlant_L1=sqrt((Slant_PointX)^2+(Slant_PointY-1)^2);
        kSlant_L2=sqrt((Slant_PointX-T_k(1,i))^2+(Slant_PointY)^2);
        k_SP=kSlant_L2/(kSlant_L1+kSlant_L2);
%         According to the k_SP identify the x-y position
        if T_k(2,i)<=k_SP   % the x-y position is under the line of  y=x/4
            Theta=atan(Slant_PointY/(Slant_PointX-T_k(1,i)));
            Real_kSlant_L=(kSlant_L1+kSlant_L2)*T_k(2,i);
            
            Tk_XY(1,i)=T_k(1,i)+Real_kSlant_L*cos(Theta);
            Tk_XY(2,i)=Real_kSlant_L*sin(Theta);
        else % the x-y position is up the line of y=x/4
            Theta=atan(Slant_PointX/(1-Slant_PointY));
            Real_kSlant_L=(kSlant_L1+kSlant_L2)*(1-T_k(2,i));
            
            Tk_XY(1,i)=Real_kSlant_L*sin(Theta);
            Tk_XY(2,i)=1-Real_kSlant_L*cos(Theta);
        end
    end
end