% 2015-11-4
% According to the azimuth and radius plot the polar figure
% Case 1: Plot all the inversion error in one figure
% Case 2: Plot this kind of inversion error in 3 subplots

function Plot_Polar_Figure(Azimuth,Radius,MT_Name,Plot_Type)
% Get the input parameters' propersity
FontSize=9;
Axis_LineWidth=0.1;
LineWidth=1;
MarkerSize=3;
Axis_Color=[0.5 0.5 0.5];
[Object_Num,Azimuth_Num]=size(Radius);

% Radius_Min=min(min());
Radius_Max=max(max(abs(Radius*10)));


%% Calculate the circle axis parameters
CircleAxis_azimuth=0:pi/100:2*pi;
CircleAxis_azimuth_Num=size(CircleAxis_azimuth,2);
CircleAxis_Radius_Int=ceil(Radius_Max)*10/5;
CircleAxis_Radius=CircleAxis_Radius_Int:CircleAxis_Radius_Int:ceil(Radius_Max)*10;
CircleAxis_Radius_Num=size(CircleAxis_Radius,2);
CircleAxis_Coor=zeros(CircleAxis_Radius_Num,CircleAxis_azimuth_Num,2);
for i=1:CircleAxis_Radius_Num
    CircleAxis_Coor(i,:,1)=CircleAxis_Radius(i)*sin(CircleAxis_azimuth);
    CircleAxis_Coor(i,:,2)=CircleAxis_Radius(i)*cos(CircleAxis_azimuth);
end

%% Calculate the radius axis
RadiusAxis_Azimuth=0:pi/6:2*pi;
RadiusAxis_Azimuth_Num=size(RadiusAxis_Azimuth,2);
RadiusAxis_Coor=zeros(2,RadiusAxis_Azimuth_Num,2);
RadiusAxis_Coor(2,:,1)=CircleAxis_Radius(CircleAxis_Radius_Num)*sin(RadiusAxis_Azimuth);
RadiusAxis_Coor(2,:,2)=CircleAxis_Radius(CircleAxis_Radius_Num)*cos(RadiusAxis_Azimuth);

%% Calculate the azimuth text position
Azimuth_Text={'0','30','60','90','120','150','180','210','240','270','300','330'};
AzimuthText_Azimuth=0:pi/6:2*pi-pi/6;
AzimuthText_Num=size(AzimuthText_Azimuth,2);
AzimuthText_Radius=CircleAxis_Radius(CircleAxis_Radius_Num)*1.1;
AzimuthText_Coor=zeros(2,AzimuthText_Num);
AzimuthText_Coor(1,:)=AzimuthText_Radius*sin(AzimuthText_Azimuth);
AzimuthText_Coor(2,:)=AzimuthText_Radius*cos(AzimuthText_Azimuth);

%% Calculate the Radius text position
Radius_Text=CircleAxis_Radius;
RadiusText_Azimuth=pi/4;
RadiusText_Num=size(Radius_Text,2);
% RadiusText_Radius_Coeff=1.5:-0.1:1.5-0.1*(RadiusText_Num-1);
RadiusText_Radius=CircleAxis_Radius+CircleAxis_Radius_Int/3;
RadiusText_Coor=zeros(2,RadiusText_Num);
RadiusText_Coor(1,:)=RadiusText_Radius*sin(RadiusText_Azimuth);
RadiusText_Coor(2,:)=RadiusText_Radius*cos(RadiusText_Azimuth);

%% Calculate objection position
Object_Line_Position=zeros(Object_Num,Azimuth_Num,2);
for i=1:Object_Num
    Object_Line_Position(i,:,1)=100*Radius(i,:).*sin(Azimuth);
    Object_Line_Position(i,:,2)=100*Radius(i,:).*cos(Azimuth);
end


%% According to the plot type, choose different plotting method
switch Plot_Type
    case 1
        %% Using 1 figure to display all inversion error
        % Plot the figure
        figure
        set(gcf,'PaperPositionMode','manual','PaperUnits','centimeters','PaperPosition',[0 0 15 15])
        hold on
        % Plot the circle axis
        for i=1:CircleAxis_Radius_Num
            plot(CircleAxis_Coor(i,:,1),CircleAxis_Coor(i,:,2),'Color',Axis_Color);
        end
        % Plot the radius axis
        for i=1:RadiusAxis_Azimuth_Num
            plot(RadiusAxis_Coor(:,i,1),RadiusAxis_Coor(:,i,2),'Color',Axis_Color);
        end
        % Plot the azimuth text
        for i=1:AzimuthText_Num
            t1=text(AzimuthText_Coor(1,i),AzimuthText_Coor(2,i),Azimuth_Text{i});
            set(t1,'HorizontalAlignment','center','FontSize',FontSize);
        end
        % Plot the radius text
        for i=1:RadiusText_Num
            t2=text(RadiusText_Coor(1,i),RadiusText_Coor(2,i),num2str(Radius_Text(i)),'Color',[0.5 0.5 0.5]);
            set(t2,'HorizontalAlignment','center','FontSize',FontSize);
        end
        % Plot the object line
        for i=1:Object_Num
            O(i)=plot(Object_Line_Position(i,:,1),Object_Line_Position(i,:,2),'-*',...
                'LineWidth',LineWidth,'MarkerSize',MarkerSize);
        end
        %Set the figure properties
        legend(O,{'ISO','CLVD','DC'})
        Title=['Inversion Error - ',MT_Name];
        title(Title);
        XLim=[-AzimuthText_Radius*1.1,AzimuthText_Radius*1.1];
        YLim=XLim;
        set(gca,'FontSize',FontSize,'XLim',XLim,'YLim',YLim);
        axis equal
        axis off
        % Save the polar figure
        SaveTitle=['Inversion Error - ',MT_Name,' (Polar Figure)'];
        print('-r300','-dtiff',SaveTitle)
    case 2
        %% Using 3 figure to display all inversion error
        Figure_Idx={'A','B','C'};
        Legend_Type2={'ISO','CLVD','DC'};
        Color_Type2={'r','g','b'};
        
        %Axxording to the class number of inversion error, generate subplot figure number 
        for Obj_Id=1:Object_Num
            figure
            set(gcf,'PaperPositionMode','manual','PaperUnits','centimeters','PaperPosition',[0 0 12 12])

            hold on
            % Plot the circle axis
            for i=1:CircleAxis_Radius_Num
                plot(CircleAxis_Coor(i,:,1),CircleAxis_Coor(i,:,2),'Color',Axis_Color);
            end
            % Plot the radius axis
            for i=1:RadiusAxis_Azimuth_Num
                plot(RadiusAxis_Coor(:,i,1),RadiusAxis_Coor(:,i,2),'Color',Axis_Color);
            end
            % Plot the azimuth text
            for i=1:AzimuthText_Num
                t1=text(AzimuthText_Coor(1,i),AzimuthText_Coor(2,i),Azimuth_Text{i});
                set(t1,'HorizontalAlignment','center','FontSize',FontSize);
            end
            % Plot the radius text
            for i=1:RadiusText_Num
                t2=text(RadiusText_Coor(1,i),RadiusText_Coor(2,i),num2str(Radius_Text(i)),'Color',[0.5 0.5 0.5]);
                set(t2,'HorizontalAlignment','center','FontSize',FontSize);
            end
            % Plot the object line
            Line_Type=['-*',Color_Type2{Obj_Id}];
            O=plot(Object_Line_Position(Obj_Id,:,1),Object_Line_Position(Obj_Id,:,2),Line_Type,...
                'LineWidth',LineWidth,'MarkerSize',MarkerSize);
            %Set the figure properties
            legend(O,Legend_Type2{Obj_Id})
            Title=['Absolute Inversion Error - ',Figure_Idx{Obj_Id}];
            title(Title);
            XLim=[-AzimuthText_Radius*1.1,AzimuthText_Radius*1.1];
            YLim=XLim;
            set(gca,'FontSize',FontSize,'XLim',XLim,'YLim',YLim);
            axis equal
            axis off
            % Save the polar figure
            SaveTitle=['Inversion Error - ',MT_Name,' - ',Figure_Idx{Obj_Id},' (Polar Figure)'];
            print('-r300','-dtiff',SaveTitle)
        end
        
        
    otherwise
        
end


% End the function
end