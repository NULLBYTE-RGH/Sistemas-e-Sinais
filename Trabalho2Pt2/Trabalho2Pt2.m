%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  0 -  Proposta de trabalho - parte 2
%%
%%  a. Cada aluno determina as frequências fo, f1 e f2 (3x) - cada vogal 9 valores - 45 valores.
%%  b. Base de conhecimento Número de alunos x 45.
%%  c. Histrograma de cada vogal - média e o desvio padrão de cada frequência para cada vogal.
%%  d. Elimnar valores fora de contexto e verificar diferenças da base
%%  e. Gravar cinco vogais que não serão usadas na base. Serão usadas somente para teste.
%%  f. 1 - acertou e 0 - errou --> a,e,i,o,u --> 1 1 0 0 1
%%  g. Qualidade do sistema de aprendizado para cada vogal
%%
%%  Entrega 15/04 até 23:59 - individual

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
pkg load io;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%Joao vitor sarti 18.01224-8

[gk,fs] = audioread ('E2-[AudioTrimmer.com].wav');



 %% 44 min
 %%https://mauabr-my.sharepoint.com/personal/vparro_maua_br/_layouts/15/onedrive.aspx?originalPath=aHR0cHM6Ly9tYXVhYnItbXkuc2hhcmVwb2ludC5jb20vOmY6L2cvcGVyc29uYWwvdnBhcnJvX21hdWFfYnIvRWpLQ1hHbmZHV2hBalNlYVc2Y3hKTTBCMjN4NWY3OThnT1pKckQxN190dGlLdz9ydGltZT1GaVZzYmhULTJFZw&id=%2Fpersonal%2Fvparro%5Fmaua%5Fbr%2FDocuments%2FIMT%2F2%20%2D%20IMT%2F3%20%2D%20Ano%202021%2FECM%20307%2F2021%2D03%2D26%2007%2E43%2E32%20Sistemas%20e%20sinais%20%2D%20turma%20L2%2099339844071%2Fzoom%5F0%2Emp4&parent=%2Fpersonal%2Fvparro%5Fmaua%5Fbr%2FDocuments%2FIMT%2F2%20%2D%20IMT%2F3%20%2D%20Ano%202021%2FECM%20307%2F2021%2D03%2D26%2007%2E43%2E32%20Sistemas%20e%20sinais%20%2D%20turma%20L2%2099339844071

if (length(gk)> 5000)

    
    gk = gk(1:5:end,:);
 
  end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  3 - Pré - processamento do sinal
%% 
%%  Ambiente de cálculo integral e simbólico
%%  
%%  X[n] = 1/N somatoria_{k=0}^{N-1} g(k) exp(-j*n*k*2*pi/N)
%%
%%
N          = length(gk);               % número de pontos de g(k)
Ts         = 1/fs;                     % Taxa de amostragem
Duracao    = N*Ts;                     % duração do sinal g(k)
ws         = 2*pi*fs;                  % frequencia angular
tempo      = linspace(0,Duracao,N);    % vetor tempo computacional 
fmax       = fs/2;                     % frequência máxima
frequencia = linspace(-fmax,fmax,N);   % frequências de interesse                


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4 -  Cáclculo de X(n)
%%  
%%  X[n] = 1/N somatoria_{k=0}^{N-1} g(k) exp(-j*n*k*2*pi/N)
%%
%%

%%% segunda estrutura: utilizando algebra linear

tic;                                % inicia um contator de tempo

Matriz_J      = (exp(-j*2*pi/N))*ones(N,N);   % cria a matriz de coeficientes

Matriz_nk     = [0:1:N-1]'*[0:1:N-1];         % matriz dos expoentes nk

WN            = Matriz_J.^Matriz_nk;          % matriz de Fourier - constante

Xf            = WN*gk;                       % Série discreeta de Fourier



%%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

funcao = fftshift(log10(abs(Xf)));

%j = mat2str(funcao, 1);
%funcao=eval(j);

%%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  6 -  Visualização
%%
%%

figure(2)

plot(tempo,gk,'k-','linewidth',3)     % configura plot(x,y, cor azul e linha cheia)
xlabel('Tempo em segundos')           % tempo em segundos
ylabel('Amplitude')                   % amplitude em volts
title('Sinal g(k) amostrado')         % título
grid

figure(3)

%%% fftshift rotaciona o vetor 0 --> 2*pi ; -pi --> +pi

plot(frequencia,funcao,'k-','linewidth',3)     % configura plot(x,y, cor azul e linha cheia)
xlabel('Frequência em Hz')                      % tempo em segundos
ylabel('Amplitude')                             % amplitude em volts
title('Espectro de amplitude')                  % título
grid


%{
auxi1 = length(frequencia);

%amplitudes = abs(Xf(auxi1:length(Xf)));



teste = 0 ;



novoindice = 1;

i = 1;

passo = 100;

%funcao(i)

while true
    
    
    %if (funcao(i) <= 1)
      
      
      display("valor de i====================================:")
      i
      
      if (funcao(i) < funcao(i+passo)) && (i+passo < length(funcao)-passo)
        
        display("aaaaaaaaaaaaaaaaaaaaaaaaaaaa")
        
      while  (funcao(i) < funcao(i+passo)) && (i+passo < length(funcao)-passo)
        
        display("WHILE ++++++++++++++++++++++++++++++++:")
        display("FUNCAO I :")
        i
        funcao(i)
        
        display("FUNCAO I +p :")
        
        if i+passo < length(funcao)-passo
          
        display("jesusussssssssss:")
        length(funcao)
        %funcao(i+100)
        i += passo;
      else 
        break;
      endif

      
    endwhile
    
  else
    
    i++;
    
    endif
     
        display("valor de i____________________________________:")
        i
        
        display("funcao em I :")
        funcao(i)
        
        %display("FUNCAO I +100 :")
        %funcao(i+100)
        
        teste(end+1) = funcao(i);

%  else
  
%i++;
  
%endif

if (i+passo > length(funcao))
  
   break;
   
endif
    
 endwhile
 
 
 display("TESTE :")
 
 
 teste
 
 teste1 = flip(sort(teste));
 
 
 display("====================:")
 


display("fundamentais :")

display("--------------------")
display("F0 :")
%Form(1)
teste(1)
display("frequencia F0 :")
%Form(2)+17108
display("--------------------")
display("F1 :")
%Form(3)
teste(2)
display("frequencia F1 :")
%Form(4)+17108
display("--------------------")
display("F2 :")
%Form(5)
teste(3)
display("frequencia F2 :")
%Form(6)+17108
display("--------------------")




F0 = input ("Digite o valor de F0! ");
F1 = input ("Digite o valor de F0! ");
F2 = input ("Digite o valor de F0! ");

funcao

%}



%%lendo o xls

aBp = xlsread('TabA.xlsx');
eBp = xlsread('TabE.xlsx');
iBp = xlsread('TabI.xlsx');
oBp = xlsread('TabO.xlsx');
uBp = xlsread('TabU.xlsx');

%%pegando o tamaho das matrizes

tamanhoA = rows(aBp);
tamanhoE = rows(eBp);
tamanhoI = rows(iBp);
tamanhoO = rows(oBp);
tamanhoU = rows(uBp);


%% valores inicias das formnates
%%   f1   f2    f1   f2   f1   f2
%a = [3600 4333 3500 4234 3300 4379];
%e = [2600 4300 2700 9340 2600 3758];
%i = [1130 1510 1140 1433 1105 1424];
%o = [2613 4138 2614 4140 2580 4251];
%u = [3339 12219 3300 12230 3312 13220];

a = [];
e = [];
i = [];
o = [];
u = [];


%% traspondo a matrix


aBp = aBp';
eBp = eBp';
iBp = iBp';
oBp = oBp';
uBp = uBp';




aBp = aBp(:);
eBp = eBp(:);
iBp = iBp(:);
oBp = oBp(:);
uBp = uBp(:);

%% separando  a matrix do xls e colocando em um vetor


for kk = 1 : 2 : tamanhoA

a(end+1) = aBp(kk);
a(end+1) = aBp(kk+1);
   
endfor

for kk = 1 : 2 : tamanhoE

e(end+1) = eBp(kk);
e(end+1) = eBp(kk+1);
   
endfor

for kk = 1 : 2 : tamanhoI

i(end+1) = iBp(kk);
i(end+1) = iBp(kk+1);
   
endfor

for kk = 1 : 2 : tamanhoO

o(end+1) = oBp(kk);
o(end+1) = oBp(kk+1);
   
endfor

for kk = 1 : 2 : tamanhoU

u(end+1) = uBp(kk);
u(end+1) = uBp(kk+1);
   
endfor

x = [];
y = [];

mediax = [];
mediay = [];


%% calculando a media de cada vogal


for lola = 1 : 2 :length(a)
  
mediax(end+1) = a(lola);
mediay(end+1) = a(lola+1);
endfor

mediax(:)
mediay(:)
x(end+1) = mean(mediax);
y(end+1) = mean(mediay);

display('media A f1')
x(:)
display('media A f2')
y(:)
mediax = [];
mediay = [];

for lola = 1 : 2 :length(e)
  
mediax(end+1) = e(lola);
mediay(end+1) = e(lola+1);
endfor
x(end+1) = mean(mediax);
y(end+1) = mean(mediay);

mediax(:)
mediay(:)
display('media E f1')
x(:)
display('media E f2')
y(:)
mediax = [];
mediay = [];

for lola = 1 : 2 :length(i)
  
mediax(end+1) = i(lola);
mediay(end+1) = i(lola+1);
endfor
x(end+1) = mean(mediax);
y(end+1) = mean(mediay);

mediax(:)
mediay(:)
display('media I f1')
x(:)
display('media I f2')
y(:)
mediax = [];
mediay = [];

for lola = 1: 2 :length(o)
  
 mediax(end+1) = o(lola);
 mediay(end+1) = o(lola+1);
endfor
x(end+1) = mean(mediax);
y(end+1) = mean(mediay);

mediax(:)
mediay(:)
display('media O f1')
x(:)
display('media O f2')
y(:)
mediax = [];
mediay = [];

for lola = 1 : 2 :length(u)
  
 mediax = u(lola);
 mediay = u(lola+1);
endfor
x(end+1) = mean(mediax);
y(end+1) = mean(mediay);

mediax(:)
mediay(:)
display('media U f1')
x(:)
display('media U f2')
y(:)


%%grafico com o espaçamento das medias das vogais

figure(4)

scatter(x,y)     % configura plot(x,y, cor azul e linha cheia)
xlabel('F1')                      % tempo em segundos
ylabel('F2')                             % amplitude em volts
title('Vogais')                  % título
grid

%%pedindo ao usuario a entrada das formantes

F1 = input ("Digite o valor de F1! ");
F2 = input ("Digite o valor de F2! ");


%%calculando a distancia entre as vogais

DA = sqrt(((F1-x(1))**2)+((F2-y(1)))**2);
DE = sqrt(((F1-x(2))**2)+((F2-y(2)))**2);
DI = sqrt(((F1-x(3))**2)+((F2-y(3)))**2);
D0 = sqrt(((F1-x(4))**2)+((F2-y(4)))**2);
DU = sqrt(((F1-x(5))**2)+((F2-y(5)))**2);


if DA < DE && DA < DI && DA < D0 && DA < DU
 
 display("Foi falado a vogal A")
 
endif

if DE < DA && DE < DI && DE < D0 && DE < DU
 
 display("Foi falado a vogal E")
 
endif

if DI < DA && DI < DE && DI < D0 && DI < DU
 
 display("Foi falado a vogal I")
 
endif

if D0 < DA && D0 < DE && D0 < DI && D0 < DU
 
 display("Foi falado a vogal O")
 
endif

if DU < DA && DU < DE && DU < DI && DU < D0
 
 display("Foi falado a vogal U")
 
endif


%a1 = 580 3600 4333 // desvio padrao = 3110.4 // media = 3660
%a2 = 600 3500 4234 // desvio padrao = 3000.6 // media = 3566
%a3 = 530 3300 4379// desvio padrao = 3142.1 // media = 3543

%e1 = 550 2600 4300 // desvio padrao = 1877.7 // media = 2483
%e2 = 540 2700 9340 // desvio padrao = 4586.1 // media = 4193
%e3 = 520 2600 3758 // desvio padrao = 4475.7 // media = 4073

%i1 = 550 1130 1510 // desvio padrao = 483.46 // media = 1063 
%i2 = 500 1140 1433 // desvio padrao = 477.13 // media = 1024
%i3 = 529 1105 1424 // desvio padrao = 453.61 // media = 1019
 
%o1 = 507 2613 4138 // desvio padrao = 1823.2 // media = 2419
%o2 = 500 2614 4140 // desvio padrao = 1827.9 // media = 2418
%o3 = 533 2580 4251 // desvio padrao = 1862.2 // media = 2454

%u1 = 1666 3339 12219 // desvio padrao = 5671.8 // media = 5741
%u2 = 1630 3300 12230 // desvio padrao = 5699.3 // media = 5720 
%u3 = 1599 3312 13220 // desvio padrao = 6273.6 // media = 6043 


%d. Elimnar valores fora de contexto e verificar diferenças da base  == "não sei como os outros pegaram os valores, mas eu usei a mesma forma como dado em aula no link a cima."



