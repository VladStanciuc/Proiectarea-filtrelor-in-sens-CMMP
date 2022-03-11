

M = PS_Prj_2_Faza_1c(2,12) ; 
omega_p = 0.3920;
omega_s = 0.5316;
W = [0 omega_p omega_s 1]; %vector ce contine pulsatiile normalizate 
A = [1 1 0 0]; %vector ce descrie valorile raspunsului dorit in benzile de interes (coordonata y)
figure('Name','Faza 1-{omega_s,omega_p} - C');

subplot(2,1,1);
h_norma2 = firls(M-1,W,A); %functia pondere a FTJ
[H_norma2,omega_norma2] = freqz(h_norma2,1,120); %raspunsul in frecventa; rezolutia 120 linii spectrale
plot(omega_norma2,20*log(abs(H_norma2))); %trasarea caracteristicii de frecventa
xlabel('Vectorul frecventelor');
ylabel('Amplitudinea (dB)');
title("Caracteristica de frecventa a FTJ");




hold on;

ind_norma2 = find(omega_norma2>(omega_s*pi)); %subvector corespunzator benzii de stopare


for i = 1 : length(ind_norma2)
    
    n = ind_norma2(i); %indicii corespunzatori pentru a crea vectorul corespunzator benzii de stopare
    Hstop_norma2(i) = H_norma2(n); %frecvente din vectorul frecventelor in banda de stopare

end

h_normainf = firpm(M-1,W,A);
[H_normainf,omega_normainf] = freqz(h_normainf,1,120); %raspunsul in frecventa cu rezolutie de 120 linii spectrale
plot(omega_normainf,20*log(abs(H_normainf))); %trasarea caracteristicii de frecventa
legend('Norma 2','Norma infinit'); %legenda
hold off;

subplot(2,1,2);
[faza_norma2, omega_norma2] = phasez(h_norma2,1,120); %faza filtrului; rezolutia 120 de linii spectrale
plot(omega_norma2, faza_norma2); %trasarea graficului fazei
hold on;

[faza_normainf, omega_normainf] = phasez(h_normainf,1,120); %faza filtrului
plot(omega_normainf, faza_normainf); %afisarea graficului fazei
xlabel('Frecventa'); 
ylabel('Faza');
title("Faza");


legend('Norma 2','Norma infinit'); 
hold on;



ind_normainf = find(omega_normainf>(omega_s*pi)); %subvector corespunzator benzii de stopare

for i = 1 : length(ind_normainf)
    
    n = ind_normainf(i); %indicii corespunzatori pentru a crea vectorul corespunzator benzii de stopare
    Hstop_normainf(i) = H_normainf(n); %frecvente din vectorul frecventelor in banda de stopare

end

 APM = sprintf("APM %5.5g%", max(20*log(abs(Hstop_normainf))))
  ALS = sprintf( 'ALS = %5.5g%', max(20*log(abs(Hstop_norma2))))
 
 %%
  %pentru {pi-omega_s,pi-omega_p}.
pi_minus_omega_p = (pi - omega_p)/pi;
pi_minus_omega_s = (pi - omega_s)/pi;

W1 = [0 pi_minus_omega_s pi_minus_omega_p 1]; %vector ce contine pulsatiile normalizate 
A = [1 1 0 0]; %vector ce descrie valorile raspunsului dorit in benzile de interes 

figure('Name','Faza 1-{pi-omega_s,pi-omega_p} - C');

subplot(2,1,1);
h_norma2 = firls(M-1,W1,A); %functia pondere a FTJ
[H_norma2,omega_norma2] = freqz(h_norma2,1,120); %raspunsul in frecventa 
plot(omega_norma2,20*log(abs(H_norma2))); %afisarea caracteristicii de frecventa
xlabel('Vectorul frecventelor'); 
ylabel('Amplitudinea (dB)');
title('Caracteristica de frecventa a FTJ'); 
hold on;

ind_norma2 = find(omega_norma2>(pi_minus_omega_s*pi)); %subvector corespunzator benzii de stopare

for i = 1 : length(ind_norma2)
    
    n = ind_norma2(i); %indicii corespunzatori pentru a crea vectorul corespunzator benzii de stopare
    Hstop_norma2(i) = H_norma2(n); %frecvente din vectorul frecventelor in banda de stopare

end

h_normainf = firpm(M-1,W1,A); %functia pondere a FTJ
[H_normainf,omega_normainf] = freqz(h_normainf,1,120); %raspunsul in frecventa
plot(omega_normainf,20*log(abs(H_normainf))); %afisarea caracteristicii de frecventa
legend('Norma 2','Norma infinit'); 
hold off;

subplot(2,1,2);
[faza_norma2, omega_norma2] = phasez(h_norma2,1,120); %faza filtrului
plot(omega_norma2, faza_norma2); %afisarea graficului fazei
hold on;

[faza_normainf, omega_normainf] = phasez(h_normainf,1,120); %faza filtrului
plot(omega_normainf, faza_normainf); %afisarea graficului fazei
xlabel('Frecventa'); 
ylabel('Faza');

title('Faza FTJ'); 
legend('Norma 2','Norma infinit'); 
hold on;

saveas(gcf,'Faza1-C.png'); 

ind_normainf = find(omega_normainf>(pi_minus_omega_s*pi)); %subvector corespunzator benzii de stopare

for i = 1 : length(ind_normainf)
    
    n = ind_normainf(i); %indicii corespunzatori pentru a crea vectorul corespunzator benzii de stopare
    Hstop_normainf(i) = H_normainf(n); %frecvente din vectorul frecventelor in banda de stopare

end

 APM = sprintf("APM %5.5g%", max(20*log(abs(Hstop_normainf))))
 
 ALS = sprintf("ALS %5.5g%", max(20*log(abs(Hstop_norma2)))) 
 
 