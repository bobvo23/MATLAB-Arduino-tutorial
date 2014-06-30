%% Arduino Matlab tutorial 3
%link: http://bit.ly/1nTiMDi

%% 1. Specifies the COM Port that the arduino is connected to
comPort = 'COM7';

%% 2. Initialize the Serial Port
if (~exist('serialFlag','var'))
    [s,flag] = setupSerial(comPort);
end

%% 3. Run a calibration routine

%calibrate the sensor if it is not calibrated
if (~exist('calCo','var'))
    calCo= calibrate(s);
    out.s = s; %Prepair for the readAcc input argument (it was designed to
    %take 's' as a variable of a struct 
end

%% 4. Open a new figure - add start/stop and close serial buttons

%initialize the figure that we will plot if it does not exist
if (~exist('h', 'var') || ~ishandle(h))
    h = figure(1);
    ax = axes('box','on'); %enclose the plot in axes limit
end

%add a start/stop and close serial button inside the figure
%stop button
if(~exist('button','var'))
    button = uicontrol('Style','pushbutton','String','Stop',...
                        'pos',[0 0 50 25],'parent',h,...
                        'Callback','stop_call_vector','UserData',1);
                    %missing this function in the video
                    %note: userdata is just a private variable for user to
                    %store whatever user want. Matlab doesn't use it
end

%close serial button
if(~exist('button2','var'))
    button = uicontrol('Style','pushbutton','String','Close Serial',...
        'pos',[250 0 150 25],'parent',h,...
        'Callback','closeSerial','UserData',1);
end

%% 5. Runs a loop that continually reads the accelerometer values
% The accelerometer data is placed in the variables [gx,gy,gz]

while (get(button,'UserData')) %while(1)?
    %read accelerometer output
    [gx,gy,gz] = readAcc(out,calCo);
    
    cla;    %clear everything from the current axis
    
    %plot X acceleration vector
    line([0 gx], [0 0], 'Color', 'r', 'LineWidth', 2, 'Marker', 'o');
    
    %limit plot to +/- 1.25g in all direction and make axis square
    limits = 1.5;
    axis([-limits limits -limits limits]);
    axis square; %x,y legen will have equal lenght
    grid on;    
    xlabel('X-axis accelertion')
    
    %calculate the angle of the resultant acceleration vector and print
    theta = atand(gy/gx);
    title(['Accelerometer tilt angle: ' num2str(theta, '%.0f')]);
    
    %force MATLAB to redraw the figure
    drawnow;
       
end