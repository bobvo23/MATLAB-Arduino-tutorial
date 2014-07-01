% ~~~~~~~~~ SERIALPUSH SETUP ~~~~~~~~~ %
function [s,flag] = setupSerial(comPort)
% Initialize the serialpush port communication between Arduino and MATLAB
% The input value is the COMPORT should be changed as per requirement
% We ensure that the arduino is also communicatiing with MATLAB at this
% time. A predefined code on the arduino acknowledges this. 
% if setup is complete then the value of setup is returned as 1 else 0

%instrfind
flag = 1;
s = serial(comPort);
set(s,'DataBits', 8 );
set(s,'StopBits', 1 );
set(s,'BaudRate', 9600);
set(s,'Parity', 'none'); 

fopen(s);

%{
a='b';
while (a ~='a')
    a=fread(s,1,'uchar');
end
if (a=='a')
    disp('serial read');
end


fprintf(s,'%c','a');

  mbox = msgbox('Serial Communication setup.'); uiwait(mbox);
%}
  disp(fscanf(s,'%s'));

  