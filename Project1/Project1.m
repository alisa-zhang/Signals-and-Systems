%Alisa Zhang, Ryan Gatto BIOENG 1320 Project 1
clear
clc

dt = 0.5;
t = 0:dt:50;

%first signal
w1 = 2*pi*.01;
x1 = 5*sin(w1*t);

%second signal
w2 = 2*pi*.05;
x2 = 6*sin(w2*t);

%LINEARITY TESTING
%adding inputs before the system
[art, ] = TotalBaroreflexArc(x1+x2, "n");

%adding outputs after the system
[art1, ] = TotalBaroreflexArc(x1,"n");
[art2, samples] = TotalBaroreflexArc(x2,"n");

%graph both to see if they're identical signals
figure;
subplot(2,1,1);
plot(samples, art);
hold on;
plot(samples, art1+art2);
title("Arterial Pressure: Linearity");
xlabel("time(s)");
ylabel("arterial pressure");
%since the peaks and troughs don't line up, this system isn't linear

%TIME INVARIANCE TESTING
dt = 0.5;
w = 2*pi*.1;

%first signal
t = 0:dt:50;
x = sin(w*t);

%same input, shifted time from n to h
[art1, ] = TotalBaroreflexArc(x,"n");
[art2, samples] = TotalBaroreflexArc(x, "h");

subplot(2,1,2);
plot(samples, art1);
hold on;
plot(samples, art2);
title("Arterial Pressure: Time Invariance");
xlabel("time(s)");
ylabel("arterial pressure");
%system is time varying because changing the input time changes the output

%test different amplitude and frequency ranges to see when they're LTI
%for linearity, at amplitudes less than 1, the system can be assumed to be linear
    dt = 0.5;
    t = 0:dt:50;

    %first signal
    w1 = 2*pi*.01;
    x1 = .5*sin(w1*t);

    %second signal
    w2 = 2*pi*.05;
    x2 = .5*sin(w2*t);
    
    [art, ] = TotalBaroreflexArc(x1+x2, "n");
    [art1, ] = TotalBaroreflexArc(x1,"n");
    [art2, samples] = TotalBaroreflexArc(x2,"n");

    %graph both to see if they're identical signals
    figure;
    subplot(2,1,1);
    plot(samples, art);
    hold on;
    plot(samples, art1+art2);
    title("Arterial Pressure: Imposed Linearity");
    xlabel("time(s)");
    ylabel("arterial pressure");
    
%for time invariance, the time shift must correspond to signal phase and
%frequency according to the equation: phase/freq = shift
    dt = 0.5;
    w = 2*pi*0.1;

    %signal
    t = 0:dt:50;
    x = sin(w*t);

    %same input, shifted right by pi/2
    [art1, ] = TotalBaroreflexArc(sin(w*t),"n");
    [art2, samples] = TotalBaroreflexArc(sin(w*t-pi/2), "n");

    subplot(2,1,2);
    plot(samples, art1);
    hold on;
    %shift back by shift/frequency = (pi/2)/(pi*2*0.1) = 2.5sec
    plot(samples - 2.5, art2);
    title("Arterial Pressure: Imposed Time Invariance");
    xlabel("time(s)");
    ylabel("arterial pressure");

figure;
load("apdata.mat");
load("apfilter.mat");
subplot(2,1,1);
plot(time, clean);
hold on;
plot(time, zeros(length(clean))-54,':');
hold on;
plot(time, zeros(length(clean))+25,'--');
hold on;
plot(time, zeros(length(clean))-70,'-.');
title("Clean Giant Squid Axon Potentials");
ylabel("Cell Potential (mV)");
xlabel("time");
ylim([-80 40]);
subplot(2,1,2);
plot(time, noisy);
title("Noisy Giant Squid Axon Potentials");
ylabel("Cell Potential (mV)");
xlabel("time");

convClean = conv(h, clean, "same");
convNoisy = conv(h, noisy, "same");

% figure;
% subplot(2,1,1);
% plot(time, convClean);
% hold on;
% plot(time, zeros(length(clean))-54,':');
% hold on;
% plot(time, zeros(length(clean))+25,'--');
% hold on;
% plot(time, zeros(length(clean))-70,'-.');
% title("Convolved Clean Giant Squid Axon Potentials");
% ylabel("Cell Potential (mV)");
% xlabel("time");
% ylim([-80 40]);
% subplot(2,1,2);
% plot(time, convNoisy);
% title("Convolved Noisy Giant Squid Axon Potentials");
% ylabel("Cell Potential (mV)");
% xlabel("time");
