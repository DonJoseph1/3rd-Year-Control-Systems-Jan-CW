clear all;
close all;
clc;

%% Section 1
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

%Complementary filters
bf = 1;
sim("task_5_model.slx")

%% Plot response
Time = [ans.data.Time];
gyro = [ans.data.Data(:,1)];
magnet = [ans.data.Data(:,2)];
fused = [ans.data.Data(:,3)];
True_signal = [ans.data.Data(:,4)];

% Gyro Compass
figure;
plot(ans.data.Time,gyro,'r-')
grid on;
hold on
xlabel('Time (s)');
axis padded
% Magnetic Compass
plot(ans.data.Time,magnet,'b-');
grid on;
hold on;
xlabel('Time (s)');

%Fused Sensor signal
plot(ans.data.Time,fused,'black-')
grid on;
hold on;
xlabel('Time (s)');

%True Signal
plot(ans.data.Time,True_signal,'m-')
grid on;
hold on;
xlabel('Time (s)');

%% Plot errors
error_gyro = gyro-True_signal;
error_magnetic = magnet-True_signal;
error_fused = fused-True_signal;

% True signal and Gyro Compass
plot(Time,error_gyro,'r-')
grid on;
xlabel('Time (s)');
ylabel('Error (Degrees)')
title('Plot of Gyroscopic Compass Error vs Time')
% true signal and magnetic compass
figure;
plot(Time,error_magnetic,'b-')
grid on;
xlabel('Time (s)');
ylabel('Error (Degrees)')
title('Plot of Magnetic Compass Error vs Time')

% True signal and fused sensor data
figure;
plot(Time,error_fused,'black-')
grid on;
xlabel('Time (s)');
ylabel('Error (Degrees)')
title('Plot of Overall Fused Sensor Error vs Time')

%% RMSE
%Gyro Error Metric
mean_err = mean(error_gyro);
RMSE = sqrt(mean(error_gyro.^2))
RMSEg = rms(error_gyro)

%Magnetic Error Metric
mean_err = mean(error_magnetic);
RMSE = sqrt(mean(error_magnetic.^2));
RMSEm = rms(error_gyro);
%Fused Sensor Error Metric
mean_err = mean(error_fused);
RMSE = sqrt(mean(error_fused.^2));
RMSEf = rms(error_gyro);
std_err = std(error_fused);

%% Complementary Filter Break Frequency Test

 
