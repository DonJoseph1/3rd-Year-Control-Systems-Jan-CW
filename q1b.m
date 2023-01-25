clear all;

close all;

clc;

%Constants
k=2;
t_r =0.4;
t_s=18;
omega = 1.02/t_r;
damping = (3/(t_s*omega));

%Define Coefficients in 2nd order system - magnetic compas
a = 1;
b = (2*damping/omega);
c = 1/(omega^2);
d = k;
e = 0;

% matlab model - magnetic compass
%sys = tf([e d],[c b a]);

% Fixed Parameters for error calculations:
% Gain = 40
% RNG: mean = 0.02, variance - 0.01. Sample time = 0.1.
% bf = 1
% sys =tf ([1],[c b a])

% Range of Complementary filters
% bf=1;
% error=zeros(1,201);
% for bf = 0:0.5:100
%     sim("task_5_model.slx");
%     error_fused = ans.data.Data(:,3)-ans.data.Data(:,4);
%     RMSE = sqrt(mean(error_fused.^2));
%     %RMSE = rms(error_fused);
%     error(bf) = [RMSE];
% 
% end

bf=0;
error=zeros(1,10);
for i = 1:1:1000;
    bf=bf+0.1;
    sim("task_5_model.slx");
    error_fused = ans.data.Data(:,3)-ans.data.Data(:,4);
    %RMSE = sqrt(mean(error_fused.^2));
    RMSE = rms(error_fused);
    error(i) = RMSE;

end




%% Plot Break Frequency vs Overall Fused sensor error
figure;
bf = 0.1:0.1:100;
plot(bf,error,'m-','LineWidth',1.5)
grid on;
xlabel('Break Frequency (Hz)');
ylabel('RMSE Error')
title('Plot of RMSE Error of the Overall Fused Sensor vs Break Frequency')
