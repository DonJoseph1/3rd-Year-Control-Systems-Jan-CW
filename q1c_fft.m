close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the first step is to set up the sampling and the array representing time

T = 0.01;                              % Define sample period

%t = 0:T:(5-T);                         % Create a 1D time array

N = length(Time);                         % calculate number of samples


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% next we create a sampled signal made up of two signals - one sine wave, 
% magnitude '2' and frequency 10 Hz, the other a cosine, magnitude '1' and
% frequency 20 Hz.  Then we take the fft using teh built in MATLAB function



sig_magnet_compass =magnet;
sig_true_signal = True_signal;

DFT = fft(True_signal);
DFT1 = fft(magnet);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Now let's plots what we have.  Does it make sense based on what you know
% about the fourier transform?

figure(1);

plot3(1:N, real(DFT),imag(DFT));
% ylim([-600,600]);
% zlim([-600,600]);
title('Step 1 - plot the raw FFT')
xlabel('Frequency, k');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The first thind to do is get the frequency axis right. We can do this by
% re-dimentionalising 'k'. Now we have things happening at the right
% frequency - and we can see where MATLAB puts the negative components -
% it puts them above the 1/2 sampling frquency

figure(2);

f = 0: 1/(N*T):(N-1)/(N*T);            % create 1D frequency array

plot3(f, real(DFT),imag(DFT));
% ylim([-600,600]);
% zlim([-600,600]);
title('Step 2 - redimensionalise the frequency range')
xlabel('Frequency, Hz');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Next, we dont often look at the phase of signals so we can just extract
% the magnitude.


figure(3);
plot(f, abs(DFT));
title('Step 3 - extract the magnitude.')
xlabel('Frequency, Hz');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We also know that the energy of the time domain signal was
% split over the positive and 'negative' frequency components, so to correct
% we can discard the negative components (Fs/2 - Fs in MATLAB) and double
% the remaining components


figure(4);
plot(f(1:N/2), 2*abs(DFT(1:N/2)));
title('Step 4 - remove 1/2Fs - Fs components, double those remaining.')
xlabel('Frequency, Hz');
axis padded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Finally we need to compensate for the length of the signal - remember the
% FT has units of 'signal_units*seconds', and this is not normlly what we
% want.  We correct by dividing by 'N' the descrete time length of the
% signal

%Final Combined Plot
figure(5);
plot(f(1:N/2), 2*abs(DFT(1:N/2))/N,'r-','LineWidth',3);
hold on;
plot(f(1:N/2), 2*abs(DFT1(1:N/2))/N,'Color', [0 0.4470 0.7410], 'LineStyle', '-','LineWidth',3);
grid on;
%title('Step 5 - scale the magnitude by dividing by the number of samples N')
title('FFT of Magnetic Compass and Input Signal')
xlabel('Frequency, Hz');
ylabel('Signal Amplitude');
xlim([0 1])
ylim([0 1])
ax = gca;
ax.FontSize = 25;  % Font Size of 15
legend('FFT of Input True Signal','FFT of Magnetic Compass Signal')

%Magnetic Compass FFT
figure(6)
plot(f(1:N/2), 2*abs(DFT1(1:N/2))/N,'Color', [0 0.4470 0.7410], 'LineStyle', '-','LineWidth',3);
hold on;
grid on;
%title('Step 5 - scale the magnitude by dividing by the number of samples N')
title('FFT of Magnetic Compass Signal')
xlabel('Frequency, Hz');
ylabel('Signal Amplitude');
%xlim([0 1])
%ylim([0 1])
ax = gca;
ax.FontSize = 25;  % Font Size of 15

%Fused Sensor FFT
figure(7)
plot(f(1:N/2), 2*abs(DFT(1:N/2))/N,'r-','LineWidth',3);
hold on;
grid on;
%title('Step 5 - scale the magnitude by dividing by the number of samples N')
title('FFT of Input Signal')
xlabel('Frequency, Hz');
ylabel('Signal Amplitude');
%xlim([0 1])
%ylim([0 1])
ax = gca;
ax.FontSize = 25;  % Font Size of 15
