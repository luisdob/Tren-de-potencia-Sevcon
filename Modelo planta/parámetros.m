%%
clear all;
clc
%% Constantes debanado motor
L = 86e-6;  % Inducatancia de fase
r = 0.049;  % Resistencia de fase
%% Parametros Motor
npp = 16;  % número de par de polos
lamdaf = 0.03;%0.0219;  % Constante de flujo mágnetico
Kt = sqrt(3) * lamdaf * npp;  % Constante de torque
%% Voltaje alimentación
Vdc = 106;  % Alimentación maxíma banco baterías
Vmax = (1/sqrt(3)) * Vdc;%sqrt(3 / 8) * Vdc;  % Voltaje máximo estator
%% Reespuesta inversor
fc = 8e3; %switching frequency of the inverter 
Vcm = Vmax; %Vcm represents the maximum control voltage
Kin = 0.6 * (Vdc / Vcm);
Tin = 1 / (2 * fc);
%% Factores de escala
Gd = 1.8;%1.4;%0.03;  % ganancia voltaje en componente directa
Gq = 1.8;%1.4;  % ganancia voltaje en componente cuadratura
Ts = 1e-6;
%% Control PI corriente
Kp = 105.999;  % Ganancia proporcional control corriente
Ki = 7e-1;%9.91e-4;  % Ganancia integral control corriente
%% Valores máximos.
RPM_MAX = 800;
TORQUE_MAX = 140;%80;
TORQUE_APLICADO = 120;%68;%3.7;
%% Status de carga
% CARGA = 0;  % cero = en vacío
reversa = 1;
%% Parametros Mecanicos Motor
J = 0.002;%1.3;  % inercia motor-rueda (11*0.3*0.3)/2 + (18*0.3*0.3)/2
B = 0.1;%0.0991;  % constante de fricción motor
%% Parametros carga
Mt = 700;   
A = 2.7;
g = 9.81;
rho = 1.3;
rr = 0.3;
% k = 2.91e-2;%1e-7;
% Cr = 9.7e-3;%0.9;
k = 6.1e-3;%1e-7;
Cr = 0.9;%0.9;
%% torque carga estimado
lambda = 100;
% %% Ruido
Xnoise = 0;
Varnoise = 0;
corr_q = 1;
%% % Modelo bateria
% K_bat = (sqrt(3 / 8) * 72) / 106;
K_bat = (72 / sqrt(3)) / Vdc; % Vac_mot / V_DCnom_bat
% K_bat_vacio = 0.51;
Q0 = 3.3 * 72; 
Qmax = 3.3 * 72;  % 3.3Ah * 72 serie
V = Vdc; %98.5; % voltaje inicial 
K = 0.21;
Loss = 1e-3;
%% Parametros identificador de parametros
% k1 = 1e7;
% k2 = 1e7;
% a_0_hat = r * (1 / L);
% b_0_hat = 1/L;
% c_0_hat = lamdaf * (1 / L);
% kf1 = 1e-4; % a_hat
% kf2 = 1e3;
% kq1 = 1e-4; % b_hat
% kq2 = 1e3;
% kh1 = 1e-4; % c_hat
% kh2 = 1e3;
%% Datos entrada para validación del modelo
% torque_act_resmple = csvread('D_carga12.csv');
% iq_act_resmple = csvread('D1_carga12.csv');
% kmh_act_resmple = csvread('D2_carga12.csv');
% id_act_resmple = csvread('D31_carga12.csv');
% vq_act_resmple = csvread('D4_carga12.csv');
% vd_act_resmple = csvread('D51_carga12.csv');
% V_act_resmple = csvread('D61_carga12.csv');
% I_act_resmple = csvread('D71_carga12.csv');
%%
% kmh_act_resmple(1:14) = 0;
% torque_act_resmple(1:14) = 0;
% %%
% torque_real = timeseries(torque_act_resmple);
% kmh_real = timeseries(kmh_act_resmple);
% iq_real = timeseries(iq_act_resmple);
% id_real = timeseries(id_act_resmple);
% vd_real = timeseries(vd_act_resmple);
% vq_real = timeseries(vq_act_resmple);
% Vbat_real = timeseries(V_act_resmple);
% Ibat_real = timeseries(I_act_resmple);
%%
% Simulation_Time = length(vq_act_resmple); %154;
% open_system('MODELO_FINAL_EOLIAN6_SISTEMA_TRACCION____CARGGA.slx')
% sim('MODELO_FINAL_EOLIAN6_SISTEMA_TRACCION____CARGGA',Simulation_Time)