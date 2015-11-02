function Plot_SourceTD()
% Plot the source type diagram ()
% T: shear component 
% k: volumetric component
T=-1:0.2:1;
k=-1:0.2:1;
UpPoint=[0 1];
DownPoint=[0 -1];
LeftPoint=[-4/3 -1/3];
RightPoint=[4/3 1/3];
OutSide_T=[UpPoint(1) LeftPoint(1) DownPoint(1) RightPoint(1) UpPoint(1)];
OutSide_k=[UpPoint(2) LeftPoint(2) DownPoint(2) RightPoint(2) UpPoint(2)];

ThirdAxis_T=-4/3:1/3:4/3;
ThirdAxis_k=ThirdAxis_T/4;

HorizontalAxis_T=-1:0.2:1;
HorizontalAxis_k=zeros(size(HorizontalAxis_T,2),1);

VerticalAxis_k=-1:0.2:1;
VerticalAxis_T=zeros(size(VerticalAxis_k,2),1);

% figure

hold on
plot(OutSide_T,OutSide_k,'k');
plot(ThirdAxis_T,ThirdAxis_k,'k','LineWidth',1);
plot(HorizontalAxis_T,HorizontalAxis_k,'k','LineWidth',1);
plot(VerticalAxis_T,VerticalAxis_k,'k','LineWidth',1)
%%% Plot the up horizontal dash line %%%
HorizontalLine_Interval=0.2;
% the dash line is ploted from left to right
HorizontalLine_UP_k1=1-HorizontalLine_Interval:-HorizontalLine_Interval:HorizontalLine_Interval;
HorizontalLine_UP_T1=HorizontalLine_UP_k1-1;
HorizontalLine_UP_k2=HorizontalLine_UP_k1;
HorizontalLine_UP_T2=zeros(size(HorizontalLine_UP_k1,2),1);
% Calculate the 3rd point along the most right line
RightLine_Length=sqrt((-2/3)^2+(4/3)^2)+sqrt((1/3)^2+(1/3)^2);
RightLine_AverageLength=RightLine_Length/(size(HorizontalLine_UP_k1,2)+1);
HorizontalLine_UP_T3=zeros(size(HorizontalLine_UP_k1,2),1);
HorizontalLine_UP_k3=zeros(size(HorizontalLine_UP_k1,2),1);
% Search the averaged point along the most right line form up to down
for i=1:size(HorizontalLine_UP_k1,2)
    HorizontalLine_UP_k3(i)=1-RightLine_AverageLength*i*sqrt(1/5);
    HorizontalLine_UP_T3(i)=2-2*HorizontalLine_UP_k3(i);
    if HorizontalLine_UP_k3(i)<1/3
        break;
    end
    HorizontalLine_T=[HorizontalLine_UP_T1(i) HorizontalLine_UP_T2(i) HorizontalLine_UP_T3(i)];
    HorizontalLine_k=[HorizontalLine_UP_k1(i) HorizontalLine_UP_k2(i) HorizontalLine_UP_k3(i)];
    plot(HorizontalLine_T,HorizontalLine_k,'k--','LineWidth',0.5);
end
% Search the averaged point along the most right line centroid  to up
AL_Id=1;
for i=size(HorizontalLine_UP_k1,2):-1:1
    HorizontalLine_UP_T3(i)=1+RightLine_AverageLength*AL_Id*sqrt(1/2);
    HorizontalLine_UP_k3(i)=HorizontalLine_UP_T3(i)-1;
    if HorizontalLine_UP_T3(i)>4/3
        break;
    end
    HorizontalLine_T=[HorizontalLine_UP_T1(i) HorizontalLine_UP_T2(i) HorizontalLine_UP_T3(i)];
    HorizontalLine_k=[HorizontalLine_UP_k1(i) HorizontalLine_UP_k2(i) HorizontalLine_UP_k3(i)];
    plot(HorizontalLine_T,HorizontalLine_k,'k--','LineWidth',0.5);
    AL_Id=AL_Id+1;
end

% Plot the down horizontal dash line
% the dash line is ploted from right to left
HorizontalLine_Down_k1=-1+HorizontalLine_Interval:HorizontalLine_Interval:-HorizontalLine_Interval;
HorizontalLine_Down_T1=HorizontalLine_Down_k1+1;
HorizontalLine_Down_k2=HorizontalLine_Down_k1;
HorizontalLine_Down_T2=zeros(size(HorizontalLine_Down_k1,2),1);
% Calculate the 3rd point along the most left line
LeftLine_Length=sqrt((2/3)^2+(-4/3)^2)+sqrt((-1/3)^2+(-1/3)^2);
LeftLine_AverageLength=LeftLine_Length/(size(HorizontalLine_Down_k1,2)+1);
HorizontalLine_Down_T3=zeros(size(HorizontalLine_Down_k1,2),1);
HorizontalLine_Down_k3=zeros(size(HorizontalLine_Down_k1,2),1);
% Search the averaged point along the most left line form down to up
for i=1:size(HorizontalLine_Down_k1,2)
    HorizontalLine_Down_k3(i)=-1+LeftLine_AverageLength*i*sqrt(1/5);
    HorizontalLine_Down_T3(i)=-2-2*HorizontalLine_Down_k3(i);
    if HorizontalLine_Down_k3(i)>-1/3
        break;
    end
    HorizontalLine_T=[HorizontalLine_Down_T1(i) HorizontalLine_Down_T2(i) HorizontalLine_Down_T3(i)];
    HorizontalLine_k=[HorizontalLine_Down_k1(i) HorizontalLine_Down_k2(i) HorizontalLine_Down_k3(i)];
    plot(HorizontalLine_T,HorizontalLine_k,'k--','LineWidth',0.5);
end
% Search the averaged point along the most right line centroid  to down
AL_Id=1;
for i=size(HorizontalLine_Down_k1,2):-1:1
    HorizontalLine_Down_T3(i)=-1-LeftLine_AverageLength*AL_Id*sqrt(1/2);
    HorizontalLine_Down_k3(i)=HorizontalLine_Down_T3(i)+1;
    if HorizontalLine_Down_T3(i)<-4/3
        break;
    end
    HorizontalLine_T=[HorizontalLine_Down_T1(i) HorizontalLine_Down_T2(i) HorizontalLine_Down_T3(i)];
    HorizontalLine_k=[HorizontalLine_Down_k1(i) HorizontalLine_Down_k2(i) HorizontalLine_Down_k3(i)];
    plot(HorizontalLine_T,HorizontalLine_k,'k--','LineWidth',0.5);
    AL_Id=AL_Id+1;
end

% Plot the right vertical dash line
% the dash line is ploted from centroid to right
VerticalLine_Interval=0.2;
VerticalLine_Right_T1=VerticalLine_Interval:VerticalLine_Interval:1-VerticalLine_Interval;
VerticalLine_Right_k1=zeros(size(VerticalLine_Right_T1,2),1);
for i=1:size(VerticalLine_Right_T1,2)
    VerticalLine_Right_P2=[1/VerticalLine_Right_T1(i) -1;1/4 -1]\[1;0]; 
    VerticalLine_T=[DownPoint(1) VerticalLine_Right_T1(i) VerticalLine_Right_P2(1) UpPoint(1)];
    VerticalLine_k=[DownPoint(2) VerticalLine_Right_k1(i) VerticalLine_Right_P2(2) UpPoint(2)];
    plot(VerticalLine_T,VerticalLine_k,'k--','LineWidth',0.5);
end
% Plot the left vertical dash line
% the dash line is ploted from centroid to left
VerticalLine_Left_T1=-1+VerticalLine_Interval:VerticalLine_Interval:-VerticalLine_Interval;
VerticalLine_Left_k1=zeros(size(VerticalLine_Left_T1,2),1);
for i=1:size(VerticalLine_Left_T1,2)
    VerticalLine_Left_P2=[1/-VerticalLine_Left_T1(i) -1;1/4 -1]\[-1;0]; 
    VerticalLine_T=[UpPoint(1) VerticalLine_Left_T1(i) VerticalLine_Left_P2(1) DownPoint(1)];
    VerticalLine_k=[UpPoint(2) VerticalLine_Left_k1(i) VerticalLine_Left_P2(2) DownPoint(2)];
    plot(VerticalLine_T,VerticalLine_k,'k--','LineWidth',0.5);
end

% Text Illustration
% axis([-15 15 -12 12]);
FontSize=9;
axis([-1.5 1.5 -1.2 1.2]);
text(-1.6,0.02,'+CLVD','FontSize',FontSize);
text(-2/3-0.5,1/3,'+LVD','FontSize',FontSize);
text(-4/9-0.42,5/9,'+TC','FontSize',FontSize)
text(-0.1,1.1,'E','FontSize',FontSize);
text(1.05,0,'-CLVD','FontSize',FontSize);
text(2/3+0.05,-1/3,'-LVD','FontSize',FontSize);
text(4/9+0.05,-5/9,'-TC','FontSize',FontSize)
text(0.05,-1.05,'I','FontSize',FontSize);
text(0.03,0.07,'DC','FontSize',FontSize)
% set(gcf,'position',[100 200 800 600]);
axis off;