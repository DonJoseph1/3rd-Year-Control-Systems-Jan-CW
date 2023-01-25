clear all
close all
clc;

% Steady-State Values
i0 = 3.27;
v0 = 0.525;
omega0 = 904;

%Constants
Kt = 2.5e3;
Cd = 1e-2;
Cl = 3e-6;
m = 1;
I = 1e-3;
R = 5e-2;
L = 1e-6;
g = 9.81;

% Transfer Functions of the linearised equatioons
G1 = tf ([1],[L R]); %I/V
G2 = tf ([-1],[Kt*L Kt*R]); %I/Omega
G3 = tf ([Kt],[I 2*Cd*omega0]); %Omega/I
G4 = tf ([8*Cl*omega0],[m 0 0]); %Y/Omega

% Transfer Function for combined system C(s)G(s)
Gs  = minreal((G1*G3*G4)/(1-(G2*G3)));%Combined transfer function of system
Cs = tf ([0.025 0.5],[1]);
CG = Cs*Gs;


% Transfer function of the closed-loop system
closed_loop = minreal(CG/(1+CG));

% Obtain Polse and Zeros
poles = pole(closed_loop);
zeros = zero(closed_loop);
%% Pole Plot
plo =pzoptions;
plo.XLim = [-1 4];
plo.XLabel.FontSize = 13;
plo.YLabel.FontSize = 13;
plo.TickLabel.FontSize = 14;
plo.Title.FontSize = 13;
pzmap(closed_loop,plo,'r-');
%% Bode Plot Options

opts = bodeoptions;
opts.Title.FontSize = 15;
opts.Title.String = 'Bode Diagram of the Transfer Function C(s)G(s)';
opts.Title.FontWeight = 'bold';
opts.XLabel.FontWeight = 'bold';
opts.YLabel.FontWeight = 'bold';
opts.XLabel.FontSize = 13;
opts.YLabel.FontSize = 13;
opts.XLim =[10e-3 10e6];
opts.TickLabel.FontSize = 12;
