clc
clear all
close all

%% Calculate the slowness surface and wave front

%% Basic parameters
% Elastic parameter (Transverse isotropic media)
c=zeros(6,6);
c(1,1)=23.52;
c(2,2)=23.52;
c(3,3)=10.89;
c(4,4)=5.29;
c(5,5)=5.29;
c(6,6)=9.42;
c(1,2)=4.69;
c(2,1)=4.69;
c(1,3)=9.46;
c(3,1)=9.46;
c(2,3)=9.46;
c(3,2)=9.46;
