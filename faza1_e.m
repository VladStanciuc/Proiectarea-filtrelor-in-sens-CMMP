

%subpunctul e
%metoda 1 - firls modificat

%FTS


omega_s = 0.3920;
omega_p = 0.5316;


M = 20; %ordinul filtrului
W = [0 omega_s omega_p 1]; %vector ce contine pulsatiile normalizate reprezentand benzile de interes 
A = [0 0 1 1]; %vector ce descrie valorile raspunsului dorit in benzile de interes 

h_FTS1_norma2 = firls(M,W,A,'h'); %functia pondere a FTS

%raspunsul in frecventa(metoda 1); rezolutia 110 linii spectrale

[H_FTS1_norma2,omega_FTS1_norma2] = freqz(h_FTS1_norma2,1,110); 

%FTB
omega_p = 0.3920;
omega_s = 0.5316;
pi_minus_omega_p = 0.8752;
pi_minus_omega_s = 0.8307;


M = 20; %ordinul filtrului
W = [0 omega_p omega_s pi_minus_omega_s pi_minus_omega_p 1];
A = [0 0 1 1 0 0];

h_FTB1_norma2 = firls(M,W,A,'h'); %functia pondere a FTB raspunsul in frecventa(metoda 1); rezolutia 110 linii spectrale

%%
[H_FTB1_norma2,omega_FTB1_norma2] = freqz(h_FTB1_norma2,1,110); 
%metoda 2 - folosind un FTJ
%FTS
%h_FTS = imp_unitar - h_FTJ

W = [0 omega_p omega_s 1]; 
A = [1 1 0 0]; 

h_FTJ = firls(M,W,A); %functia pondere a FTJ

%FTS = 1-FTJ 

for i = 1 : (M+1)
   
    h_FTS2_norma2(i) = 0 - h_FTJ(i); %functia pondere a FTS
    
    if(i == M/2+1) %mijlocul corespunzator, unde impulsul e 1(punctul 0); h are un singur maxim deoarece M este par
        h_FTS2_norma2(i) = 1 - h_FTJ(i); %functia pondere a FTS
    end
    
end

%FTB = FTJ_right - FTJ_left



W = [0 pi_minus_omega_s pi_minus_omega_p 1]; 
A = [1 1 0 0]; 

h_FTJ_r = firls(M,W,A); %functia pondere a FTJ mai departat de 0

W = [0 omega_p omega_s 1]; 

h_FTJ_l = firls(M,W,A); %functia pondere a FTJ mai apropiat de 0

for i = 1 : (M+1)
   
    h_FTB2_norma2(i) = h_FTJ_r(i) - h_FTJ_l(i);
    
end
%raspunsul in frecventa pentru FTS(metoda 2) cu rezolutia 110 linii spectrale
[H_FTS2_norma2,omega_FTS2_norma2] = freqz(h_FTS2_norma2,1,110); 
%raspunsul in frecventa pentru FTB(metoda 2) cu rezolutia 110 linii spectrale
[H_FTB2_norma2,omega_FTB2_norma2] = freqz(h_FTB2_norma2,1,110); 

%Calculam erorile care exista intre cele 2 metode:

Err_h_FTS_norma2 = norm(h_FTS1_norma2 - h_FTS2_norma2)
Err_H_FTS_norma2 = norm(H_FTS1_norma2 - H_FTS2_norma2)

Err_h_FTB_norma2 = norm(h_FTB1_norma2 - h_FTB2_norma2)
Err_H_FTB_norma2 = norm(H_FTB1_norma2 - H_FTB2_norma2)

 

%metoda 1 - firpm modificat

%FTS
%benzile la FTS sunt inversate

omega_s = 0.3920;
omega_p = 0.5316;

%definirea parametrilor functiei firls, respectiv firpm
M = 20; %ordinul filtrului
W = [0 omega_s omega_p 1]; %vector ce contine pulsatiile normalizate reprezentand benzile de interes 
A = [0 0 1 1]; %vector ce descrie valorile raspunsului dorit in benzile de interes 

h_FTS1_inf = firpm(M,W,A); %functia pondere a FTS
[H_FTS1_inf,omega_FTS1_inf] = freqz(h_FTS1_inf,1,110); %raspunsul in frecventa cu rezolutia 110 linii spectrale

%FTB


omega_p = 0.3920;
omega_s = 0.5316;

pi_minus_omega_p = 0.8752;
pi_minus_omega_s = 0.8307;

%definirea parametrilor functiei firls, respectiv firpm
M = 20; %ordinul filtrului
W = [0 omega_p omega_s pi_minus_omega_s pi_minus_omega_p 1]; 
A = [0 0 1 1 0 0]; 

h_FTB1_inf = firpm(M,W,A); %functia pondere a FTB
[H_FTB1_inf,omega_FTB1_inf] = freqz(h_FTB1_inf,1,110); %raspunsul in frecventa cu rezolutia 110 linii spectrale

%metoda 2 - folosind un FTJ

%FTS
%h_FTS = imp_unitar - h_FTJ

%benzile de trecere pentru FTJ



W = [0 omega_p omega_s 1]; 
A = [1 1 0 0]; 

h_FTJ_inf = firpm(M,W,A); %functia pondere a FTJ

%FTS = 1-FTJ 

for i = 1 : (M+1)
   
    h_FTS2_inf(i) = 0 - h_FTJ_inf(i); %functia pondere a FTS
    
    if(i == M/2+1) %mijlocul corespunzator, unde impulsul e 1(punctul 0); h are un singur maxim deoarece M este par
        h_FTS2_inf(i) = 1 - h_FTJ_inf(i); %functia pondere a FTS
    end
    
end

%FTB = FTJ_right - FTJ_left
%FTB se obtine scazand un FTJ ce are omega_p si omega_s mai departe de 0 si un FTJ ce are wp si ws mai aproape de 0

pi_minus_omega_p = 0.8752;
pi_minus_omega_s = 0.8307;

W = [0 pi_minus_omega_s pi_minus_omega_p 1]; %vector ce contine pulsatiile normalizate reprezentand benzile de interes (coordonata x)
A = [1 1 0 0]; %vector ce descrie valorile raspunsului dorit in benzile de interes (coordonata y)

h_FTJ_r_inf = firpm(M,W,A); %functia pondere a FTJ mai departat de 0

omega_p = 0.3920; 
omega_s = 0.5316;

W = [0 omega_p omega_s 1]; 

h_FTJ_l_inf = firpm(M,W,A); %functia pondere a FTJ mai apropiat de 0

for i = 1 : (M+1)
   
    h_FTB2_inf(i) = h_FTJ_r_inf(i) - h_FTJ_l_inf(i);
    
end
%raspunsul in frecventa pentru FTS cu rezolutia 110 linii spectrale
[H_FTS2_inf,omega_FTS2_inf] = freqz(h_FTS2_inf,1,110);

%raspunsul in frecventa pentru FTB cu rezolutia 110 linii spectrale
[H_FTB2_inf,omega_FTB2_inf] = freqz(h_FTB2_inf,1,110); 


%Calculam erorile care exista intre cele 2 metode:

Err_h_FTS_normainf = norm(h_FTS1_inf - h_FTS2_inf)
Err_H_FTS_normainf = norm(H_FTS1_inf - H_FTS2_inf)

Err_h_FTB_normainf = norm(h_FTB1_inf - h_FTB2_inf)
Err_H_FTB_normainf = norm(H_FTB1_inf - H_FTB2_inf)

%trasarea graficelor

%Norma Euclidiana - CMMP

figure('Name','Faza 1 - E - FTS');

subplot(2,1,1);
plot(omega_FTS1_norma2,20*log(abs(H_FTS1_norma2))); %trasarea caracteristicii de frecventa(metoda 1)
hold on;
plot(omega_FTS1_inf,20*log(abs(H_FTS1_inf))); %trasarea caracteristicii de frecventa(metoda 1)
hold on;
plot(omega_FTS2_norma2,20*log(abs(H_FTS2_norma2))); %trasarea caracteristicii de frecventa(metoda 2)
hold on; 
plot(omega_FTS2_inf,20*log(abs(H_FTS2_inf))); %trasarea caracteristicii de frecventa(metoda 2)
xlabel('Vectorul frecventelor'); 
ylabel('Amplitudinea (dB)');
title('Caracteristica de frecventa a FTS');
legend('CMMP-metoda 1','Alg. PMC-metoda 1','CMMP-metoda 2','Alg. PMC-metoda 2');
hold off;

subplot(2,1,2);
[faza_FTS1_norma2, omega_FTS1_norma2] = phasez(h_FTS1_norma2,1,110); %faza filtrului cu rezolutia 110 de linii spectrale
plot(omega_FTS1_norma2, faza_FTS1_norma2); %trasarea graficului fazei
hold on;
[faza_FTS1_inf, omega_FTS1_inf] = phasez(h_FTS1_inf,1,110); %faza filtrului cu rezolutia 110 de linii spectrale
plot(omega_FTS1_inf, faza_FTS1_inf); %trasarea graficului fazei
hold on;
[faza_FTS2_norma2, omega_FTS2_norma2] = phasez(h_FTS2_norma2,1,110); %faza filtrului cu rezolutia 110 de linii spectrale
plot(omega_FTS2_norma2, faza_FTS2_norma2); %trasarea graficului fazei
hold on;
[faza_FTS2_inf, omega_FTS2_inf] = phasez(h_FTS2_inf,1,110); %faza filtrului cu rezolutia 110 de linii spectrale
plot(omega_FTS2_inf, faza_FTS2_inf); %trasarea graficului fazei
xlabel('Frecventa');
ylabel('Faza');
title('Faza FTS'); 
legend('CMMP-metoda 1','Alg. PMC-metoda 1','CMMP-metoda 2','Alg. PMC-metoda 2'); 
hold on;

saveas(gcf,'Faza1-E-FTS.png');

figure('Name','Faza 1 - E - FTB');

subplot(2,1,1);
plot(omega_FTB1_norma2,20*log(abs(H_FTB1_norma2))); %afisarea caracteristicii de frecventa
hold on;
plot(omega_FTB1_inf,20*log(abs(H_FTB1_inf))); %afisarea caracteristicii de frecventa
plot(omega_FTB2_norma2,20*log(abs(H_FTB2_norma2))); %afisarea caracteristicii de frecventa
hold on;
plot(omega_FTB2_inf,20*log(abs(H_FTB2_inf))); %afisarea caracteristicii de frecventa
xlabel('Vectorul frecventelor');
ylabel('Amplitudinea (dB)');
title('Caracteristica de frecventa a FTB'); 
legend('CMMP-metoda 1','Alg. PMC-metoda 1','CMMP-metoda 2','Alg. PMC-metoda 2'); 
hold off;

subplot(2,1,2);
[faza_FTB1_norma2, omega_FTB1_norma2] = phasez(h_FTB1_norma2,1,110); %faza filtrului cu rezolutia 110 de linii spectrale
plot(omega_FTB1_norma2, faza_FTB1_norma2); %trasarea graficului fazei
hold on;

[faza_FTB1_inf, omega_FTB1_inf] = phasez(h_FTB1_inf,1,110); %faza filtrului cu rezolutia 110 de linii spectrale
plot(omega_FTB1_inf, faza_FTB1_inf); %trasarea graficului fazei
hold on;

[faza_FTB2_norma2, omega_FTB2_norma2] = phasez(h_FTB2_norma2,1,110); %faza filtrului cu rezolutia 110 de linii spectrale
plot(omega_FTB2_norma2, faza_FTB2_norma2); %trasarea graficului fazei
hold on;

[faza_FTB2_inf, omega_FTB2_inf] = phasez(h_FTB2_inf,1,110); %faza filtrului cu rezolutia 110 de linii spectrale
plot(omega_FTB2_inf, faza_FTB2_inf); %trasarea graficului fazei
xlabel('Frecventa');
ylabel('Faza');
title('Faza FTB'); 
legend('CMMP-metoda 1','Alg. PMC-metoda 1','CMMP-metoda 2','Alg. PMC-metoda 2'); 
hold on;


