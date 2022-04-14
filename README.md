# BIOENG1320
Biosignals and Systems Projects
BIOENG 1320 – Biological Signals and Systems (Spring 2022 )
MATLAB Project 1
Issued: January 26, 202 2 Due: 1 : 00 p, February 1 6 , 202 2 (via Canvas)

Testing a biological system for linearity and time-invariance: It is important for the body to
keep arterial pressure within narrow limits. If arterial pressure is too low, tissue beds will not
be adequately perfused with blood. If arterial pressure is too high, the tissue beds can be
damaged. The baroreflex is a mechanism mediated by the autonomic nervous system for
maintaining arterial pressure. Stretch receptors in the neck sense the arterial pressure in the
carotid sinus region and relay this information to the brain. If the arterial pressure is
above/below the desired level (i.e., setpoint), the brain responds by decreasing/increasing
sympathetic nervous outflow to the circulation, which decreases/increases cardiac output
and total peripheral resistance to restore the arterial pressure. The interaction between the
baroreflex and circulation may be viewed as a negative feedback system as show in the figure.
This closed-loop system can be opened experimentally to investigate the total baroreflex arc,
which relates changes in carotid sinus pressure to changes in arterial pressure. The total
baroreflex arc will respond to an increase/decrease in carotid sinus pressure by
decreasing/increasing the arterial pressure. The function TotalBaroreflexArc is a model of
this system developed using experimental data from a rodent preparation. The function
arguments are the carotid sinus pressure input and “n” for normotensive or “h” for
hypertensive, which developed after years of aging in the same subject. The function output
is the resulting arterial pressure and corresponding time samples.
Use sinusoidal inputs with frequencies between 0.01 and 0.20 Hz, a sampling interval of 0.
sec, and a duration of at least 50 sec to answer the following questions.
(a) Is the system linear or nonlinear?
(b) Is the system time-invariant or time-varying?
(c) If it is not linear and/or time-invariant, can it be approximated as LTI under certain
conditions? If so, what are those conditions?
(d) What are the differences in classifying real biological systems versus mathematically-
defined systems (e.g., from Lecture)?
Include properly labeled plots as supporting evidence.
Filtering a biological signal to remove noise: Action potentials (commonly referred to as
spikes) are the electrical language that neurons use to communicate with one another. The
first experiments to understand the mechanism of action potentials were performed on giant
squid axons. These experiments involved stimulating the channels that control the
movement of ions across the axon membrane with voltage pulses. The investigated ion
channels were sodium, potassium and certain leak channels that allow the corresponding
ions to flow in and out of the cell.
A typical cell membrane has a negative resting membrane potential. When a voltage stimulus
causes the axon to increase its membrane potential above a threshold, the sodium channels
open causing an influx of sodium into the cell and depolarization to a peak potential (spiking).
During this time, the potassium channels slowly open causing expulsion of potassium out of
the cell and repolarization to the resting membrane potential. The resting, threshold, and
peak membrane potentials are important parameters for characterizing axons.
Measurement noise can be a practical problem in detecting these parameters.
The file apdata.mat contains two computer-simulated giant squid axon action potential
signals (spike trains) in units of mV and of 200 msec in duration with a “sampling interval” of
0.0796 msec each. One of the signals is artifact-free (vector labeled “clean”), while the other
signal is contaminated with noise (vector labeled “noisy”). The file also includes the
corresponding “time” vector for both signals (vector labeled “time”). The file apfilter.mat
contains an impulse response for removing noise in the action potential signals while
retaining information. The impulse response is given at the same sampling interval (vector
labeled “h”). This discrete-time filter may be applied to originally continuous-time spike
trains by approximating the convolution integral as follows:
𝑦(𝑡)=∫−∞∞ℎ(𝜏)𝑥(𝑡−𝜏)𝑑𝜏 → 𝑦(𝑛𝑇𝑠)≈∑𝑁𝑘=− 01 ℎ(𝑘𝑇𝑠)𝑥((𝑛−𝑘)𝑇𝑠)𝑇𝑠,
where 𝑇𝑠= 0. 0796 msec and 𝑁 is the impulse response length here.
a. Plot the two spike trains versus time and label the resting, threshold, and peak membrane
potentials for the clean signal. Can the same information be readily seen for the noisy
signal?
b. Apply the filter to both spike trains using the built-in conv function. Plot the two filtered
signals versus time. The filtered signals are longer than the original signals and have some
transients at the edges. What causes these edge effects and how should they be handled?
c. Describe the results of the filtering. Can you now better label the resting, threshold, and
peak membrane potentials for the noisy signal? Has all the noise been removed from the
noisy signal? Why or why not?
d. What do you still need to learn to be able to remove noise in other biological signals?

Deliverables: Submit a single pdf file containing answers to the questions, properly labeled
plots, and the source code.
