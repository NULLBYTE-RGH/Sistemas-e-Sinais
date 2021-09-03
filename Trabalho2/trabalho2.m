%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 0 - Proposta 
%% 
%%  a. implementar a série discreta
%%  Xn = 1/N somatoria_{k=0}^{N-1} gk(k) exp(-j*n*k*2*pi/N)
%%  b. visualizar graficamente
%%  c. interpretar o resultado
%%  d. comparar com tempo
%%
%%  Trabalho em Octave *.m
%%
%%  a. Analisar as cinco vogais: Xa, Xe, Xi, Xo, e Xu.
%%  b. Os tempos de execução de cada vogal.
%%  c. O que você observa de diferente em cada série de Fourier.
%%  d. Você conseguiria analisar no tempo?
%%  e. Como você transformaria o "for" em produto matricial como foi feito na teoria?
%%  
%%  Entrega 23/03 até 23:59 - individual
%%
%%  Reposição 07/04 e 14/04
%%
%%  


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1 - Preparação do código 
%% 
%% Boas práticas: limpeza de variáveis; variáveis globais
%% Constantes; carregar bibliotecas;...
%%
%%% Limpeza

clc;          % limpa visual da tela de comandos
close all;    % limpa as figuras
clear all;    % limpa as variáveis

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2 - Sinal: calibração e sinal real
%%
%% trabalhar com um sinal amostrado
%% 
%%% sinal artificial de referência - calibrar o Fourier nas mesmas condições
%%
%% criar um senoide artificial: amplitude - Ap, frequência - fo e fase - theta
%% 
%%   sinal = Ap * cos (2 * pi * fo * t + theta)

%%% configuração do sinal artificial

%fs      = 10;                       % frequência de amostragem
%Ap      = 1;                        % amplitude do sinal artificial
%fo      = 1;                        % frequência do sinal artificial em Hz
%theta   = 0;                        % fase do sinal artificial em radianos
%To      = 1/fo;                     % determino o período do meu sinal
%Np      = 2;                       % número de períodos em análise
%t       = linspace(0,Np*To,Np*fs);  % tempo total do sinal

%gk      = Ap*cos(2*pi*t+theta);     %adicionando o drobro da frequência
%gk      = gk + Ap*cos(1*pi*t+theta);% sinal artificial

%%% Visualização

%figure(1)

%stem(t,gk,'k-','linewidth',3)         % configura plot(x,y, cor azul e linha cheia)
%xlabel('Tempo em segundos')           % tempo em segundos
%ylabel('Amplitude')                   % amplitude em volts
%title('Sinal g(k) amostrado')         % título
%grid

%%% recuperar o sinal a partir de um arquivo - real

% [gk,fs] = audioread ('a.wav');     % transformei um arquivo .wav em um vetor g(k)
                                     % recuperei a taxa de amostragem - fs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  3 - Pré - processamento
%%
%%%%  Xn = 1/N somatoria_{k=0}^{N-1} gk(k) exp(-j*n*k*2*pi/N)

%N       = length(gk);               % número de pontos do sinal em análise
%Ts      = 1/fs;                     % tempo de amostragem
%ws      = 2*pi*fs;                  % frequência anngular
%duracao = N*Ts;                     % Duração do sinal
%tempo   = linspace(0,N*Ts,N);       % vetor tempo computacional
%fmax    = fs/2;                     % frequência máxima de amostragem


%frequencia = linspace(-fs/2,fs/2,N);% vetor de frequências de Fourier
%resolucao  = fs/N;                  % resoluÇào em frequência

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  4 - Fourier
%%
%%%%  Xn = 1/N somatoria_{k=0}^{N-1} gk(k) exp(-j*n*k*2*pi/N)

%%% usando a estrutura do tipo "for ... end"

%tic;                                % inicia um contador
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%for n = 0 : N-1                     % N pontos
  
%  aux_k = 0;                        % inicia com zero

%      for k = 0 :  N-1              %  N pontos - somatoria_{k=0}^{N-1}
        
        %%% gk(k) exp(-j*n*k*2*pi/N)
        %%% +1 --> transforma k de variável matemática para ponteiro
        
%        aux_k  = aux_k + gk(k+1)*exp(-j*n*k*2*pi/N);
        
%      end
      
      %%% +1 --> transforma n de variável matemática para ponteiro
      
%      Xn(n+1) = aux_k/N;              % valor final para n fixo - Fourier
      
%end

%Xn  = fftshift(Xn);                   % rotaciona o resultado de Fourier
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%toc;                                % estima o tempo de duração              

%%% estrutura matricial

%tic;                                % inicia um contador
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%toc;  


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  5 -  Visualização
%%
%%

%figure(2)

%plot(tempo,gk,'k-','linewidth',3)     % configura plot(x,y, cor azul e linha cheia)
%xlabel('Tempo em segundos')           % tempo em segundos
%ylabel('Amplitude')                   % amplitude em volts
%title('Sinal g(k) amostrado')         % título
%grid

%figure(3)

%stem(frequencia,abs(Xn),'k-','linewidth',3)                % configura plot(x,y, cor azul e linha cheia)
%xlabel('Frequência em Hz')                 % tempo em segundos
%ylabel('Amplitude')                        % amplitude em volts
%title('Espectro de amplitude')             % título
%grid

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%analizando vogais:%%%%%%%%%%%%%%%%%%%%%%%%%%%

display('Iniciando for A')

[gka,fsa] = audioread ('a.wav');

NA       = length(gka);               
TsA      = 1/fsa;                     
wsA      = 2*pi*fsa;                  
duracaoA = NA*TsA;                    
tempoA   = linspace(0,NA*TsA,NA);       
fmaxA    = fsa/2;  
frequenciaA = linspace(-fsa/2,fsa/2,NA);
resolucaoA  = fsa/NA;            

tic;
for n = 0 : NA-1                     % N pontos
  
  aux_k = 0;                        % inicia com zero

      for k = 0 :  NA-1              %  N pontos - somatoria_{k=0}^{N-1}
        aux_k  = aux_k + gka(k+1)*exp(-j*n*k*2*pi/NA);
        
      end

      XnA(n+1) = aux_k/NA;              % valor final para n fixo - Fourier
      
end

XnA  = fftshift(XnA);                   % rotaciona o resultado de Fourier

display('Tempo de execução vogal A')
toc;

figure(1)

stem(tempoA,gka,'k-','linewidth',3)      % configura plot(x,y, cor azul e linha cheia)
xlabel('Tempo em segundos')           % tempo em segundos
ylabel('Amplitude')                   % amplitude em volts
title('Sinal g(k)A amostrado')         % título
grid

figure(6)

stem(frequenciaA,abs(XnA),'k-','linewidth',3)                % configura plot(x,y, cor azul e linha cheia)
xlabel('Frequência em Hz')                 % tempo em segundos
ylabel('Amplitude')                        % amplitude em volts
title('Espectro de amplitude')             % título
grid


display('Iniciando for E')


[gke,fse] = audioread ('e.wav');

NE       = length(gke);               
TsE      = 1/fse;                     
wsE      = 2*pi*fse;                  
duracaoE = NE*TsE;                    
tempoE   = linspace(0,NE*TsE,NE);       
fmaxE    = fse/2;
frequenciaE = linspace(-fse/2,fse/2,NE);
resolucaoE  = fse/NE;  


tic;



for n = 0 : NE-1                     % N pontos
  
  aux_k = 0;                        % inicia com zero

      for k = 0 :  NE-1              %  N pontos - somatoria_{k=0}^{N-1}
        
        aux_k  = aux_k + gke(k+1)*exp(-j*n*k*2*pi/NE);
        
      end

      XnE(n+1) = aux_k/NE;              % valor final para n fixo - Fourier
      
end

XnE  = fftshift(XnE);                   % rotaciona o resultado de Fourier

display('Tempo de execução vogal E')
toc;

figure(2)

stem(tempoE,gke,'k-','linewidth',3)      % configura plot(x,y, cor azul e linha cheia)
xlabel('Tempo em segundos')           % tempo em segundos
ylabel('Amplitude')                   % amplitude em volts
title('Sinal g(k)E amostrado')         % título
grid

figure(7)

stem(frequenciaE,abs(XnE),'k-','linewidth',3)                % configura plot(x,y, cor azul e linha cheia)
xlabel('Frequência em Hz')                 % tempo em segundos
ylabel('Amplitude')                        % amplitude em volts
title('Espectro de amplitude')             % título
grid


display('Iniciando for I')

[gki,fsi] = audioread ('i.wav');
NI       = length(gki);               
TsI      = 1/fsi;                     
wsI      = 2*pi*fsi;                  
duracaoI = NI*TsI;                    
tempoI   = linspace(0,NI*TsI,NI);       
fmaxI    = fsi/2; 
frequenciaI = linspace(-fsi/2,fsi/2,NI);
resolucaoI  = fsi/NI; 


tic;

for n = 0 : NI-1                     % N pontos
  
  aux_k = 0;                        % inicia com zero

      for k = 0 :  NI-1              %  N pontos - somatoria_{k=0}^{N-1}
        
        aux_k  = aux_k + gki(k+1)*exp(-j*n*k*2*pi/NI);
        
      end

      XnI(n+1) = aux_k/NI;              % valor final para n fixo - Fourier
      
end

XnI  = fftshift(XnI);                   % rotaciona o resultado de Fourier

display('Tempo de execução vogal I')
toc;

figure(3)

stem(tempoI,gki,'k-','linewidth',3)      % configura plot(x,y, cor azul e linha cheia)
xlabel('Tempo em segundos')           % tempo em segundos
ylabel('Amplitude')                   % amplitude em volts
title('Sinal g(k)I amostrado')         % título
grid

figure(8)

stem(frequenciaI,abs(XnI),'k-','linewidth',3)                % configura plot(x,y, cor azul e linha cheia)
xlabel('Frequência em Hz')                 % tempo em segundos
ylabel('Amplitude')                        % amplitude em volts
title('Espectro de amplitude')             % título
grid


display('Iniciando for O')
[gko,fso] = audioread ('o.wav');
NO       = length(gko);               
TsO      = 1/fso;                     
wsO      = 2*pi*fso;                  
duracaoO = NO*TsO;                    
tempoO   = linspace(0,NO*TsO,NO);       
fmaxO    = fso/2; 
frequenciaO = linspace(-fso/2,fso/2,NO);
resolucaoO  = fso/NO; 
tic;

for n = 0 : NO-1                     % N pontos
  
  aux_k = 0;                        % inicia com zero

      for k = 0 :  NO-1              %  N pontos - somatoria_{k=0}^{N-1}

        aux_k  = aux_k + gko(k+1)*exp(-j*n*k*2*pi/NO);
        
      end

      XnO(n+1) = aux_k/NO;              % valor final para n fixo - Fourier
      
end

XnO  = fftshift(XnO);                   % rotaciona o resultado de Fourier

display('Tempo de execução vogal O')
toc;

figure(4)

stem(tempoO,gko,'k-','linewidth',3)      % configura plot(x,y, cor azul e linha cheia)
xlabel('Tempo em segundos')           % tempo em segundos
ylabel('Amplitude')                   % amplitude em volts
title('Sinal g(k)O amostrado')         % título
grid

figure(9)

stem(frequenciaO,abs(XnO),'k-','linewidth',3)                % configura plot(x,y, cor azul e linha cheia)
xlabel('Frequência em Hz')                 % tempo em segundos
ylabel('Amplitude')                        % amplitude em volts
title('Espectro de amplitude')             % título
grid

display('Iniciando for U')
[gku,fsu] = audioread ('u.wav');
NU       = length(gku);               
TsU      = 1/fsu;                     
wsU      = 2*pi*fsu;                  
duracaoU = NU*TsU;                    
tempoU   = linspace(0,NU*TsU,NU);       
fmaxU    = fsu/2; 
frequenciaU = linspace(-fsu/2,fsu/2,NU);
resolucaoU  = fsu/NU; 
tic;

for n = 0 : NU-1                     % N pontos
  
  aux_k = 0;                        % inicia com zero

      for k = 0 :  NU-1              %  N pontos - somatoria_{k=0}^{N-1}

        aux_k  = aux_k + gku(k+1)*exp(-j*n*k*2*pi/NU);
        
      end

      XnU(n+1) = aux_k/NU;              % valor final para n fixo - Fourier
      
end

XnU  = fftshift(XnU);                   % rotaciona o resultado de Fourier

display('Tempo de execução vogal U')
toc;

figure(5)

stem(tempoU,gku,'k-','linewidth',3)      % configura plot(x,y, cor azul e linha cheia)
xlabel('Tempo em segundos')           % tempo em segundos
ylabel('Amplitude')                   % amplitude em volts
title('Sinal g(k)U amostrado')         % título
grid

figure(10)

stem(frequenciaU,abs(XnU),'k-','linewidth',3)                % configura plot(x,y, cor azul e linha cheia)
xlabel('Frequência em Hz')                 % tempo em segundos
ylabel('Amplitude')                        % amplitude em volts
title('Espectro de amplitude')             % título
grid

%Tempo de execução vogal A
%Elapsed time is 287.93 seconds. --> 4.7 minutos

%Tempo de execução vogal E
%Elapsed time is 402.46 seconds. --> 6.7 minutos

%Tempo de execução vogal I
%Elapsed time is 192.923 seconds. --> 3,2 minutos

%Tempo de execução vogal O
%Elapsed time is 243.755 seconds. --> 4 minutos

%Tempo de execução vogal U
%Elapsed time is 730.771 seconds. --> 12 minutos

%Minhas Configurações :
%Intel(R) Core(TM) i7-8750H CPU @ 2.20GHz   2.20 GHz
%16,0 GB RAM
%GeForce RTX 2060 6GB

%C) é notavel o tempo de execução de cada vogal. porem eu nao achei nenhuma relacão entre amplitudes e o tempo levado para executar a serie.

%D) Essa forma de resolução eu achei na internet:

%wn   = exp(-1i*2*pi/N);            
%J    = wn*ones(N, N);                   
%ExpM = [0:1:N-1]'*[0:1:N-1];     
%M    = J.^ExpM;   
%Xf = M*gk;



