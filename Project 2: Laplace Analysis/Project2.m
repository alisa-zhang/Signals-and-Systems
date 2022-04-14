% Alisa Zhang, Keegan Blain BIOENG 1320 Project #2
clear
clc

%PROBLEM #2
Cc = 1.6;
Cp = 0.2;
Lc = 0.015;
Rp = 1.1;

%Hp(s) = Rp/(LcRpCcCps^3+LcCcs^2+Rp(Cp+Cc)s+1)
denom = [Lc*Rp*Cc*Cp Lc*Cc Rp*(Cp+Cc) 1];
num = Rp;
%`what range of frequencies should this plot show?
w = logspace(-1,1);

%frequency response of Hp
figure;
freqs(num, denom);
title("Frequency Response");

%bode plot of Hp
 Hp = tf(num, denom);
 figure;
 bode(Hp);

%impulse response
 figure;
 title("Impulse Response");
 impulse(Hp);

%   Underdamped, as proved by...
%   Bode Magnitude: Spike before decrease is indicative of a zeta that is
% less than one, also known as an underdamped system
%   Bode Phase: The steep drop indicates an underdamped system because a
% critically damped system has a much more gradually changing slope.
%   Impulse Response: The system oscillates quite a bit before reaching an
% amplitude of zero. 
%   I used the matlab function damp(Hp) to see if the damping ratio (zeta)
% was less than one for the pair of complex conjugate poles. The damping
% ratio is 1.05e-1, so the system is indeed underdamped. 

%PROBLEM #3
T = 1;
Ts = 0.3*sqrt(T);
dt1 = 0:0.001:(T-0.001);
ds = 0:0.001:(Ts-0.001);
SV = 80;
%initial pulse
sineBeat1 = (SV*pi/(2*Ts))*sin(pi*ds/Ts);
%remaining zeros to pad out the time
sineBeat2 = zeros(1, length(dt1)-length(ds));
%concatenate the two and graph against dt
sineBeat = cat(2, sineBeat1, sineBeat2);

impulseTrain = repmat([1, zeros(1, length(dt1)-1)], 1, 20);
dt2 = 0:0.001:19.999;

input = conv(impulseTrain, sineBeat, 'same');
figure;
plot(dt2, input);
title("Input Signal");
xlabel("time (s)");
ylabel("Ejection Rate (mL/s)");

%PROBLEM #4
dt = 0:0.001:(length(input)/1000-0.001);
output_p = lsim(Hp, input, dt);
figure;
subplot(2,1,1);
plot(dt, output_p);
title("${P}_{p}$(t) with periodic sine flow input", 'Interpreter','latex','FontSize',14);
xlabel("time (s)");
ylabel("Pressure (mmHg)");
%   lsim uses the transfer function and the input to `convolve the signal
% with the transfer function Hp for the output of the system
%   the transient response occurs as a result of an underdamped system,
% so the output gets closer to equilibrium as time progresses.

%PROBLEM #5
%Hc(s) = (LcRpCps^2+Lcs+Rp)/(LcRpCcCps^3+LcCcs^2+Rp(Cp+Cc)s+1)
denom = [Lc*Rp*Cc*Cp Lc*Cc Rp*(Cp+Cc) 1];
num = [Lc*Rp*Cc Lc Rp];
Hc = tf(num, denom);
output_c = lsim(Hc, input, dt);
subplot(2,1,2);
plot(dt, output_c);
title("${P}_{c}$(t) with periodic sine flow input", 'Interpreter','latex','FontSize',14);
xlabel("Time (s)");
ylabel("Pressure (mmHg)");

%PROBLEM #6: For Pc, Pp, Ql
    T = 1;
    Ts = 0.3*sqrt(T);
    dt1 = 0:0.001:(T-0.001);
    ds = 0:0.001:(Ts-0.001);
    SV1 = 80;
    SV2 = 120;
    sineBeat1Old = (SV1*pi/(2*Ts))*sin(pi*ds/Ts);
    sineBeat2Old = zeros(1, length(dt1)-length(ds));
    sineBeat1New = (SV2*pi/(2*Ts))*sin(pi*ds/Ts);
    sineBeat2New = zeros(1, length(dt1)-length(ds));
    sineBeatOld = cat(2, sineBeat1Old, sineBeat2Old);
    sineBeatNew = cat(2, sineBeat1New, sineBeat2New);
    impulseTrain = repmat([1, zeros(1, length(dt1)-1)], 1, 20);
    
    inputOld = conv(impulseTrain, sineBeatOld, 'same');
    inputNew = conv(impulseTrain, sineBeatNew, 'same');
    
    figure('Position',[300 80 700 600]);
    subplot(3,1,1);
    dt2 = 0:0.001:19.999;
    plot(dt2, inputOld);
    hold on;
    plot(dt2, inputNew);
    title("Cardiac Output $\dot{q}_{l}$(t): blue SV=80mL and orange SV=120mL", 'Interpreter','latex','FontSize',14);
    xlabel("Time(s)");
    ylabel("Ejection Rate (mL/s)");
    
    dt = 0:0.001:(length(inputOld)/1000-0.001);
    output_Old = lsim(Hp, inputOld, dt);
    output_New = lsim(Hp, inputNew, dt);
    subplot(3,1,2);
    plot(dt, output_Old);
    hold on;
    plot(dt, output_New);
    title("Peripheral Pressure ${P}_{p}$(t): blue SV=80mL and orange SV=120mL", 'Interpreter','latex','FontSize',14);
    xlabel("Time (s)");
    ylabel("Pressure (mmHg)");
    
    output_Old = lsim(Hc, inputOld, dt);
    output_New = lsim(Hc, inputNew, dt);
    subplot(3,1,3);
    plot(dt, output_Old);
    hold on;
    plot(dt, output_New);
    title("Mean Blood Pressure ${P}_{c}$(t): blue SV=80mL and orange SV=120mL", 'Interpreter','latex','FontSize',14);
    xlabel("Time (s)");
    ylabel("Pressure (mmHg)");

%decreasing beat length T
    T1 = 1;
    T2 = 0.5;
    Ts1 = 0.3*sqrt(T1);
    Ts2 = 0.3*sqrt(T2);
    dt1 = 0:0.001:(T1-0.001);
    dt2 = 0:0.001:(T2-0.001);
    ds1 = 0:0.001:(Ts1-0.001);
    ds2 = 0:0.001:(Ts2-0.001);
    SV = 80;
    sineBeat1Old = (SV*pi/(2*Ts1))*sin(pi*ds1/Ts1);
    sineBeat2Old = zeros(1, length(dt1)-length(ds1));
    sineBeat1New = (SV*pi/(2*Ts2))*sin(pi*ds2/Ts2);
    sineBeat2New = zeros(1, length(dt2)-length(ds2));
    sineBeatOld = cat(2, sineBeat1Old, sineBeat2Old);
    sineBeatNew = cat(2, sineBeat1New, sineBeat2New);
    impulseTrainOld = repmat([1, zeros(1, length(dt1)-1)], 1, 20);
    impulseTrainNew = repmat([1, zeros(1, length(dt2)-1)], 1, 40);
    
    inputOld = conv(impulseTrainOld, sineBeatOld, 'same');
    inputNew = conv(impulseTrainNew, sineBeatNew, 'same');
    
    figure('Position',[300 80 700 600]);
    subplot(3,1,1);
    dt2 = 0:0.001:19.999;
    plot(dt2, inputOld);
    hold on;
    plot(dt2, inputNew);
    title("Cardiac Output $\dot{q}_{l}$(t): blue T=1sec and orange T=0.5sec", 'Interpreter','latex','FontSize',14);
    xlabel("Time(s)");
    ylabel("Ejection Rate (mL/s)");
    
    dt = 0:0.001:(length(inputOld)/1000-0.001);
    output_Old = lsim(Hp, inputOld, dt);
    output_New = lsim(Hp, inputNew, dt);
    subplot(3,1,2);
    plot(dt, output_Old);
    hold on;
    plot(dt, output_New);
    title("Peripheral Pressure ${P}_{p}$(t): blue T=1sec and orange T=0.5sec", 'Interpreter','latex','FontSize',14);
    xlabel("Time (s)");
    ylabel("Pressure (mmHg)");
    
    output_Old = lsim(Hc, inputOld, dt);
    output_New = lsim(Hc, inputNew, dt);
    subplot(3,1,3);
    plot(dt, output_Old);
    hold on;
    plot(dt, output_New);
    title("Mean Blood Pressure ${P}_{c}$(t): blue T=1sec and orange T=0.5sec", 'Interpreter','latex','FontSize',14);
    xlabel("Time (s)");
    ylabel("Pressure (mmHg)");

%increasing central compliance Cc

    Cc1 = 1.6;
    Cc2 = 2.9;
    Cp = 0.2;
    Lc = 0.015;
    Rp = 1.1;
    
    figure('Position',[300 80 700 600]);
    subplot(3,1,1);
    dt2 = 0:0.001:19.999;
    plot(dt2, input);
    title("Cardiac Output $\dot{q}_{l}$(t): identical for Cc=1.6mL/mmHg and Cc=2.9mL/mmHg", 'Interpreter','latex','FontSize',12);
    xlabel("Time(s)");
    ylabel("Ejection Rate (mL/s)");

    denom1 = [Lc*Rp*Cc1*Cp Lc*Cc1 Rp*(Cp+Cc1) 1];
    denom2 = [Lc*Rp*Cc2*Cp Lc*Cc2 Rp*(Cp+Cc2) 1];
    num = Rp;

    Hp1 = tf(num, denom1);
    Hp2 = tf(num, denom2);

    dt = 0:0.001:(length(inputOld)/1000-0.001);
    output_Old = lsim(Hp1, input, dt);
    output_New = lsim(Hp2, input, dt);
    subplot(3,1,2);
    plot(dt, output_Old);
    hold on;
    plot(dt, output_New);
    title("Peripheral Pressure ${P}_{p}$(t): blue Cc=1.6mL/mmHg and orange Cc=2.9mL/mmHg", 'Interpreter','latex','FontSize',12);
    xlabel("Time (s)");
    ylabel("Pressure (mmHg)");
    
    denom1 = [Lc*Rp*Cc1*Cp Lc*Cc1 Rp*(Cp+Cc1) 1];
    num1 = [Lc*Rp*Cc1 Lc Rp];
    denom2 = [Lc*Rp*Cc2*Cp Lc*Cc2 Rp*(Cp+Cc2) 1];
    num2 = [Lc*Rp*Cc2 Lc Rp];
    Hc1 = tf(num1, denom1);
    Hc2 = tf(num2, denom2);
    output_Old = lsim(Hc1, input, dt);
    output_New = lsim(Hc2, input, dt);
    subplot(3,1,3);
    plot(dt, output_Old);
    hold on;
    plot(dt, output_New);
    title("Mean Blood Pressure ${P}_{c}$(t): blue Cc=1.6mL/mmHg and orange Cc=2.9mL/mmHg", 'Interpreter','latex','FontSize',12);
    xlabel("Time (s)");
    ylabel("Pressure (mmHg)");

%decreasing peripheral resistance Rp
    Cc = 1.6;
    Cp = 0.2;
    Lc = 0.015;
    Rp1 = 1.1;
    Rp2 = 1.6;
    
    figure('Position',[300 80 700 600]);
    subplot(3,1,1);
    dt2 = 0:0.001:19.999;
    plot(dt2, input);
    title("Cardiac Output $\dot{q}_{l}$(t): identical for Rp=1.1mmHg/(mL/s) and Rp=1.6mmHg/(mL/s)", 'Interpreter','latex','FontSize',12);
    xlabel("Time(s)");
    ylabel("Ejection Rate (mL/s)");

    denom1 = [Lc*Rp1*Cc*Cp Lc*Cc Rp1*(Cp+Cc) 1];
    denom2 = [Lc*Rp2*Cc*Cp Lc*Cc Rp2*(Cp+Cc) 1];
    num1 = Rp1;
    num2 = Rp2;
    w = logspace(-1,1);

    Hp1 = tf(num1, denom1);
    Hp2 = tf(num2, denom2);

    dt = 0:0.001:(length(inputOld)/1000-0.001);
    output_Old = lsim(Hp1, input, dt);
    output_New = lsim(Hp2, input, dt);
    subplot(3,1,2);
    plot(dt, output_Old);
    hold on;
    plot(dt, output_New);
    title("Peripheral Pressure ${P}_{p}$(t): blue Rp=1.1mmHg/(mL/s) and orange Rp=1.6mmHg/(mL/s)", 'Interpreter','latex','FontSize',12);
    xlabel("Time (s)");
    ylabel("Pressure (mmHg)");
    
    denom1 = [Lc*Rp1*Cc*Cp Lc*Cc1 Rp1*(Cp+Cc) 1];
    num1 = [Lc*Rp1*Cc Lc Rp1];
    denom2 = [Lc*Rp2*Cc*Cp Lc*Cc Rp2*(Cp+Cc) 1];
    num2 = [Lc*Rp2*Cc Lc Rp2];
    Hc1 = tf(num1, denom1);
    Hc2 = tf(num2, denom2);
    output_Old = lsim(Hc1, input, dt);
    output_New = lsim(Hc2, input, dt);
    subplot(3,1,3);
    plot(dt, output_Old);
    hold on;
    plot(dt, output_New);
    title("Mean Blood Pressure ${P}_{c}$(t): blue Rp=1.1mmHg/(mL/s) and orange Rp=1.6mmHg/(mL/s)", 'Interpreter','latex','FontSize',12);
    xlabel("Time (s)");
    ylabel("Pressure (mmHg)");
