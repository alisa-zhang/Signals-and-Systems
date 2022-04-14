% Alisa Zhang, Sean Wescott
clear
clc

%PROBLEM #1
dw = 0:0.01:pi;
Xreal = 12*(sin(6*dw)./(6*dw)).^2;

figure;
subplot(2,2,1);
plot(dw, Xreal);
title("X(w) by analysis");
ylabel("Magnitude");
xlabel("Frequency");

subplot(2,2,2);
Xim = (exp(1)).^(-12i.*dw);
plot(dw, angle(Xim));
title("X(w) by analysis");
ylabel("Phase");
xlabel("Frequency");

%PROBLEM #2
Ts = 1;
x = triang(25);
DFT = fft(x, 256);
dw = linspace(0,2*pi,256);

subplot(2,2,3);
plot(dw, abs(DFT));
title("Magnitude X(w) by fft");

subplot(2,2,4);
plot(dw, angle(DFT));
title("Phase X(w) by fft");
%max frequency is calculated at pi
%the fft function just takes [0,pi] from the analytical function and
%mirrors it so the function extends from [0,2*pi]

%PROBLEM #3
DFT16 = fft(x, 16);
DFT32 = fft(x, 32);
DFT128 = fft(x, 128);

figure;
subplot(4,2,1);
plot(linspace(0,2*pi,16), abs(DFT16));
title("Magnitude DFT N=16");
ylabel("Magnitude");
xlabel("Frequency");

subplot(4,2,2);
plot(linspace(0,2*pi,16), angle(DFT16));
title("Phase DFT N=16");
ylabel("Phase");
xlabel("Frequency");

subplot(4,2,3);
plot(linspace(0,2*pi,32), abs(DFT32));
title("Magnitude DFT N=32");
ylabel("Magnitude");
xlabel("Frequency");

subplot(4,2,4);
plot(linspace(0,2*pi,32), angle(DFT32));
title("Phase DFT N=32");
ylabel("Phase");
xlabel("Frequency");

subplot(4,2,5);
plot(linspace(0,2*pi,128), abs(DFT128));
title("Magnitude DFT N=128");
ylabel("Magnitude");
xlabel("Frequency");

subplot(4,2,6);
plot(linspace(0,2*pi,128), angle(DFT128));
title("Phase DFT N=128");
ylabel("Phase");
xlabel("Frequency");

subplot(4,2,7);
plot(0:0.01:pi, Xreal);
title("Magnitude DFT Analytical");
ylabel("Magnitude");
xlabel("Frequency");

subplot(4,2,8);
plot(0:0.01:pi, angle(Xim));
title("Phase DFT Analytical");
ylabel("Phase");
xlabel("Frequency");

%PROBLEM #5
load("apdata.mat");
DFTclean = fft(clean-mean(clean));
DFTnoise = fft(noisy-mean(noisy));

figure;
subplot(2,2,1);
plot(linspace(0,12.5628,length(clean)), abs(DFTclean));
title("Clean Action Potential DFT");
ylabel("Magnitude");
xlabel("Frequency");
xlim([0 6.2814]);

%PROBLEM #6
subplot(2,2,3);
plot(linspace(0,12.5628,length(clean)), angle(DFTclean));
title("Clean Action Potential DFT");
ylabel("Phase");
xlabel("Frequency");
xlim([0 6.2814]);

subplot(2,2,2);
plot(linspace(0,12.5628,length(noisy)), abs(DFTnoise));
title("Noisy Action Potential DFT");
ylabel("Magnitude");
xlabel("Frequency");
xlim([0 6.2814]);

subplot(2,2,4);
plot(linspace(0,12.5628,length(noisy)), angle(DFTnoise));
title("Noisy Action Potential DFT");
ylabel("Phase");
xlabel("Frequency");
xlim([0 6.2814]);

%PROBLEM #7
figure;
subplot(4,3,1);
filter1 = fir1(4,0.5/6.2814);
filter2 = fir1(4,1/6.2814);
filter3 = fir1(4,2/6.2814);
filter4 = fir1(4,3/6.2814);

noisyfiltered1 = conv(noisy,filter1,'same');
noisyfiltered2 = conv(noisy,filter2,'same');
noisyfiltered3 = conv(noisy,filter3,'same');
noisyfiltered4 = conv(noisy,filter4,'same');
cleanfiltered1 = conv(clean,filter1,'same');
cleanfiltered2 = conv(clean,filter2,'same');
cleanfiltered3 = conv(clean,filter3,'same');
cleanfiltered4 = conv(clean,filter4,'same');

%Wn = 0.8 is best
subplot(4,3,1);
plot(time,noisyfiltered1);
title("Filtered Noisy | Fc = 0.5");
ylabel("Cell Potential (mV)");
xlabel("time(s)");

subplot(4,3,4);
plot(time,noisyfiltered2);
title("Filtered Noisy | Fc = 1");
ylabel("Cell Potential (mV)");
xlabel("time(s)");

subplot(4,3,7);
plot(time,noisyfiltered3);
title("Filtered Noisy | Fc = 2");
ylabel("Cell Potential (mV)");
xlabel("time(s)");

subplot(4,3,10);
plot(time,noisyfiltered4);
title("Filtered Noisy | Fc = 3");
ylabel("Cell Potential (mV)");
xlabel("time(s)");

subplot(4,3,2);
plot(time,cleanfiltered1);
title("Filtered Clean | Fc = 0.5");
ylabel("Cell Potential (mV)");
xlabel("time(s)");

subplot(4,3,5);
plot(time,cleanfiltered2);
title("Filtered Clean | Fc = 1");
ylabel("Cell Potential (mV)");
xlabel("time(s)");

subplot(4,3,8);
plot(time,cleanfiltered3);
title("Filtered Clean | Fc = 2");
ylabel("Cell Potential (mV)");
xlabel("time(s)");

subplot(4,3,11);
plot(time,cleanfiltered4);
title("Filtered Clean | Fc = 3");
ylabel("Cell Potential (mV)");
xlabel("time(s)");

subplot(4,3,3);
impz(filter1);
title("Filter Impulse Response | Fc = 0.5");

subplot(4,3,6);
impz(filter2);
title("Filter Impulse Response | Fc = 1");

subplot(4,3,9);
impz(filter3);
title("Filter Impulse Response | Fc = 2");

subplot(4,3,12);
impz(filter4);
title("Filter Impulse Response | Fc = 3");
