function [gx gy gz] = readAcc(out,calCo)
 	%Innit from other missing function
    %out.s=s;
    %calCo.offset=1000;
    %calCo.g=1;

        % fprintf(out.s,'R');
          %readpush voltages from accelerometer and reorder
          accRawData = fscanf(out.s,'%s');
          while(accRawData(1)~='x');
             accRawData = fscanf(out.s,'%s');
          end   
          reordered(1) = str2double(accRawData(2:6));
          reordered(2) = str2double(accRawData(8:12));
          reordered(3) = str2double(accRawData(14:18));
                      
         
          offset = calCo.offset;
          gain = calCo.g;
          accel = (reordered - offset) ./ gain;
          %map analog inputs to axes
          gx = accel(1);
          gy = accel(2);
          gz = accel(3);
          
          disp(accel);
          
          