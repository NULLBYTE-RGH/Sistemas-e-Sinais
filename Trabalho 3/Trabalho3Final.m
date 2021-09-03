%Trabalho T3
% Joao Vitor Quirino Sarti 18.01224-8

% a) Para a vogal A determinar a funcao de laplace  --> G(s)=N(s)/D(s)
% b) Grafico de Laplace sobreposto com a vogal
% c) Relação entre polos de Laplace com Fourier
% d) s = sigma + j*w --> G(s) --> visualizar o grafico variando o w e
% comparando com Fourier
% e) Sintetizar a voz gerada por Laplace por 2 segundos 
% f) Determinar automaticamente G(s)
% g) gerar um circuito eletrico equivalente


clear;
clc;
close all;

% Carregar a voz trabalhada 
load('Voz.mat') 

%---------------------Graficos Amplitude e Frequencia----------------------
tiledlayout(2,1)
ax1 = nexttile;
plot(ax1,t,Vp);
title(ax1,'Sinal de voz');
xlabel(ax1,'Tempo em segundos');
ylabel(ax1,'Ampltude');

ax2 = nexttile;
plot(ax2,frequencia,Y0);
title(ax2,'Espectro de amplitude da vogal a')
xlabel(ax2,'Frequência em Hz');
ylabel(ax2,'dB')

%--------------------------------------------------------------------------

%-----------------Achando os Picos para montar a Exponencial---------------

%PicoV--> picos em X,Y da voz(V)
[PicoV,IndiceV]=findpeaks(Vp,t,'MinPeakDistance',0.005);
%YfpL--> picos em X,Y de Laplace(L)
param = 0.9*frequencia(size(frequencia));
[PicoF,IndiceF]=findpeaks(Y0,frequencia,'MinPeakDistance',param(1));

tiledlayout(2,1)
ax1 = nexttile;
p = plot(ax1,t,Vp,IndiceV,PicoV);% Grafico com o pico da Vogal
title(ax1,'Sinal de voz');
xlabel(ax1,'Tempo em segundos');
ylabel(ax1,'Ampltude');

p(1).LineWidth = 1;
p(2).Marker = 's';
p(2).LineStyle = ':';

ax2 = nexttile;
p = plot(ax2,frequencia,Y0,IndiceF,PicoF);% Grafico com o pico de Fourier
title(ax2,'Espectro de amplitude da vogal a')
xlabel(ax2,'Frequência em Hz');
ylabel(ax2,'dB')

p(1).LineWidth = 1;
p(2).Marker = 's';

%Pegando um intervalo entre os Picos Para Montar a Exponencial
[mds,IndiceV1] = findpeaks(diff(Vp),t(1:end-1),'MinPeakDistance',0.005);


%Escolhendo intervalo entre 1 e 2 pico
inicio =  find(t==IndiceV1(1));
fim    =  find(t==IndiceV1(2));



tempoAnalise = t(inicio:fim);

yAnalise = Vp(inicio:fim);

figure 
plot(tempoAnalise,yAnalise);

title('Sinal original')

%Selecioando os subPicos do Periodo Selecionado

[PicoV,IndiceV]=findpeaks(yAnalise,tempoAnalise,'MinPeakDistance',0.001);

%figure 
%plot(IndiceV,PicoV); ->Grafico com os picos internos

figure
EXP = fit(IndiceV',PicoV,'exp1');
plot(EXP,IndiceV',PicoV);
title('Curva Aproximada do sinal original (EXP^1)');

figure 

SIN = fit(tempoAnalise',yAnalise,'sin3');
plot(SIN,tempoAnalise',yAnalise);
title('Curva Apoximada do sinal original (SIN^2)');

figure 

plot(SIN);
hold on;
plot(EXP);
title('Sinal Composto F(X) ');
hold off;


%------------> Definindo variavel de transferencia <------------%

%freq = 1/(IndiceV(end)-IndiceV(1));
%w = 2*pi*freq;
%PicoV--> picos em X,Y da voz(V)

[PicoP,IndiceP]=findpeaks(Vp,t);
Periodo = mean(diff(IndiceP));

freq = 1/Periodo;

w = 2*pi*freq;

sigma = EXP.b;

%s = @(w) sigma + 1i*w;

%------valores da funcao F(x) e exp
a1 =SIN.a1;
b1 =SIN.b1;
c1 =SIN.c1;
a2 =SIN.a2;
b2 =SIN.b2;
c2 =SIN.c2;
a3 =SIN.a3;
b3 =SIN.b3;
c3 =SIN.c3; 
a = EXP.a;
b = sigma; % sigma = EXP.b;
%----------------------------

x = tempoAnalise';

%------------Função F(x) e EXP definidos------------------

%fx =a1*sin(b1*x+c1) + a2*sin(b2*x+c2) + a3*sin(b3*x+c3);
%ex = a*exp(b*x);

%polos-->local onde o sistema tem o maior ganho

%  C) Em Fourier é possivel ver por meio das formantes os locais de maior energia
%do sistema, logo os mesmo são contemplados pelos polos de Laplace, que
%mostarm o local de maior ganho do sistema.

%composto por parte real e (ou nao) parte imaginaria
%Parte real = Contola a Exponencial(Atenuação)
%Parte imaginaria = Controla a oscilação ( W )
%Pelo fato de ser uma exponencial decrescente o Polo esta no Semi plano
%esquerdo, logo o sistema é (estavel)

%variavel ganho é onde a formante f0 ocorre

ganho = IndiceF;

func = @(x) (a1.*sin(b1.*x+c1) + a2.*sin(b2.*x+c2)+ a3.*sin(b3.*x+c3)).*a.*exp(b.*x);
Fs = integral(func,0,inf);

%Como os polos Controlam a atenuação, e quem controla a atenuação é a
%Exponencial; e na formulação de Laplace a exponencia é dada por e^(-S*t),
%onde o S = sigma + j*w; esses valores podem ser obtidos , ja que a
%exponencial foi encontrada por aproximaçao com o sinal artificial , tambem
%aproximado:

poloA = sigma + 1i*2*pi*ganho;
poloB = sigma - 1i*2*pi*ganho;

% k = ganho de laplace = coeficiente multiplo da exponencial de atenuação
% multiplicado por omega (de quando ocorre o maior ganho de Fourier)

k  = a*2*pi*ganho;
z  = [];

%F)

VozLP = zpk(z,[poloA poloB],k);


%A)
% Funçao de Laplace para o Sinal considerando o 3 e 4 pico
% VozLP =
%  
%          3.4929e+07
%   ------------------------
%   (s^2 + 1119s + 1.803e07)
%  
% Continuous-time zero/pole/gain model.

%-----------Grafico de Laplace sobreposto a vogal

%B)
figure()
[Xv,Yv] = impulse(VozLP,tempoAnalise);

Xfinal = Yv';
Yfinal = Xv';

% Em amarelo , o sinal Em Laplace
plot(Yv,-Xv,'y');
title('Laplace sobreposto com o Sinal original')
hold on
plot(tempoAnalise,yAnalise,'r');
hold off
%-------------------------------------------------------------------------


%D)
%F)


TFaux = tf(VozLP);

Numerador = TFaux.Numerator;
Denominador = TFaux.Denominator;


Fourier = @(w) Numerador{1,1}(3)./(((Denominador{1,1}(1))*(1i*w)).^2 + (Denominador{1,1}(2))*(1i*w) + (Denominador{1,1}(3)));
omega = linspace(0,20000,10000000);
figure

%plot(freq,Y0);
plot(frequencia,Y0);
hold on;
plot(omega/(2*pi),20*log10(abs((Fourier(omega)))),'b');
hold off;
xlabel('Frequencia em Hz');
ylabel('ganho');
title('Comparacao entre Fourier e Laplace');


%--------------------------------------------------------------------------


%E)

Numero_De_Picos = size(IndiceV1);

for i = 2:Numero_De_Picos(2)-1
    
disp(i)

inicio =  find(t==IndiceV1(i));
fim    =  find(t==IndiceV1((i+1)));


tempoAnalise = t(inicio:fim);
yAnalise = Vp(inicio:fim);

[PicoV,IndiceV]=findpeaks(yAnalise,tempoAnalise,'MinPeakDistance',0.001);
EXP = fit(IndiceV',PicoV,'exp1');
SIN = fit(tempoAnalise',yAnalise,'sin3');
[PicoP,IndiceP]=findpeaks(Vp,t);
Periodo = mean(diff(IndiceP));
freq = 1/Periodo;
w = 2*pi*freq;
sigma = EXP.b;
a1 =SIN.a1;
b1 =SIN.b1;
c1 =SIN.c1;
a2 =SIN.a2;
b2 =SIN.b2;
c2 =SIN.c2;
a3 =SIN.a3;
b3 =SIN.b3;
c3 =SIN.c3; 
a = EXP.a;
b = sigma; 
x = tempoAnalise';
ganho = IndiceF;
func = @(x) (a1.*sin(b1.*x+c1) + a2.*sin(b2.*x+c2)+ a3.*sin(b3.*x+c3)).*a.*exp(b.*x);
Fs = integral(func,0,inf);
poloA = sigma + 1i*2*pi*ganho;
poloB = sigma - 1i*2*pi*ganho;
k  = a*2*pi*ganho;
z  = [];

VozLP = zpk(z,[poloA poloB],k);

[Xv,Yv] = impulse(VozLP,tempoAnalise);

Xfinal = [Xfinal,Yv'];
Yfinal = [Yfinal,Xv'];

%TFaux(i) = tf(VozLP);
end

%TFaux %---> Retorna todas as funçoes trasferencia que compoe o sinal

figure
plot(Xfinal,Yfinal,'y');
hold on
plot(t,Vp,'r');
hold off
play = [Yfinal,Yfinal]*200;

%E)
for i=1:20
play = [play,Yfinal];
end
sound(play,0.13*96000,16);


%A)

%a função de Lapace completa para a vogal seria: (A somas de todas as funçoes de Transferencia a vogal)

% 8.648e22 s^24 + 1.019e27 s^23 + 2.414e31 s^22 + 2.193e35 s^21 + 2.869e39 s^20 + 2.105e43 s^19 + 1.959e47 s^18 + 1.191e51 s^17 + 8.648e54 s^16 
%                                                                                                                                                 
%           + 4.419e58 s^15 + 2.616e62 s^14 + 1.129e66 s^13 + 5.575e69 s^12 + 2.029e73 s^11 + 8.444e76 s^10 + 2.563e80 s^9 + 9.012e83 s^8         
%                                                                                                                                                 
%                            + 2.23e87 s^7 + 6.59e90 s^6 + 1.272e94 s^5 + 3.116e97 s^4 + 4.279e100 s^3 + 8.464e103 s^2 + 6.418e106 s + 9.792e109  
%                                                                                                                                                 
%   ----------------------------------------------------------------------------------------------------------------------------------------------
%                                                                                                                                                
%    s^26 + 1.296e04 s^25 + 3.111e08 s^24 + 3.079e12 s^23 + 4.121e16 s^22 + 3.284e20 s^21 + 3.152e24 s^20 + 2.085e28 s^19 + 1.572e32 s^18        
%                                                                                                                                                
%            + 8.78e35 s^17 + 5.435e39 s^16 + 2.586e43 s^15 + 1.345e47 s^14 + 5.467e50 s^13 + 2.418e54 s^12 + 8.356e57 s^11 + 3.156e61 s^10      
%                                                                                                                                                
%            + 9.164e64 s^9 + 2.949e68 s^8 + 7.03e71 s^7 + 1.911e75 s^6 + 3.578e78 s^5 + 8.073e81 s^4 + 1.084e85 s^3 + 1.969e88 s^2 + 1.475e91 s 
%                                                                                                                                                
%                                                                                                                                      + 2.046e94
%--------------------------------------------------------------------------
