


%subpunctul d

%definirea parametrilor functiei firls, respectiv firpm
ws = PS_Prj_2_Faza_1d(2,12) ;
M = 38;
omega_p = 0.3920;
omega_s = 0.5316;

W = [0 omega_p omega_s 1]; %vector ce contine pulsatiile normalizate reprezentand benzile de interes 
A = [1 1 0 0]; %vector ce descrie valorile raspunsului dorit in benzile de interes 
w = [1 5]; %ponderile, definesc amplitudinile pentru banda de trecere, respectiv de stopare

figure('Name','Faza 1 - D - Sens CMMP');

% cu functia pondere [1 5]
subplot(2,1,1);
h_norma2 = firls(M,W,A,w); %functia pondere a FTJ
[H_norma2,omega_norma2] = freqz(h_norma2,1,120); %raspunsul in frecventa
plot(omega_norma2,20*log(abs(H_norma2))); %trasarea caracteristicii de frecventa
xlabel('Vectorul frecventelor'); 
ylabel('Amplitudinea (dB)');
title('Caracteristica de frecventa a FTJ - Sens CMMP'); 
hold on;

%fara functia pondere
h_norma2w = firls(M,W,A); %functia pondere a FTJ
[H_norma2w,omega_norma2w] = freqz(h_norma2w,1,120); %raspunsul in frecventa
plot(omega_norma2w,20*log(abs(H_norma2w))); %trasarea caracteristicii de frecventa
legend('Functia pondere [1 5]','Functia pondere [1 1]'); 
hold off;

subplot(2,1,2);
[faza_norma2, omega_norma2] = phasez(h_norma2,1,120); %faza filtrului
plot(omega_norma2, faza_norma2); %afisarea graficului fazei
hold on;

[faza_norma2w, omega_norma2w] = phasez(h_norma2w,1,120); %faza filtrului
plot(omega_norma2w, faza_norma2w); %afisarea graficului fazei
xlabel('Frecventa');
ylabel('Faza');
title('Faza FTJ - Sens CMMP'); 
legend('Functia pondere [1 5]','Functia pondere [1 1]'); 
hold off;





indstop_norma2 = find(omega_norma2>(ws*pi)); %subvector corespunzator benzii de stopare [omega_s,pi]

for i = 1 : length(indstop_norma2)
    
    n = indstop_norma2(i); %indicii corespunzatori pentru a crea vectorul corespunzator benzii de stopare
    Hstop_norma2(i) = H_norma2(n); %frecvente din vectorul frecventelor in banda de stopare

end

indtrecere_norma2 = find(omega_norma2<(omega_p*pi)); %subvector corespunzator benzii de trecere [0,omega_p]

for i = 1 : length(indtrecere_norma2)
    
    n = indtrecere_norma2(i); %indicii corespunzatori pentru a crea vectorul corespunzator benzii de trecere
    Htrecere_norma2(i) = H_norma2(n); %frecvente din vectorul frecventelor in banda de trecere

end

figure('Name','Faza 1 - D - Sens Norma Infinit');

subplot(2,1,1);
%cu functia pondere [1 5]
h_normainf = firpm(M,W,A,w); %functia pondere a FTJ
[H_normainf,omega_normainf] = freqz(h_normainf,1,120); %raspunsul in frecventa
plot(omega_normainf,20*log(abs(H_normainf))); %afisarea caracteristicii de frecventa
xlabel('Vectorul frecventelor'); 
ylabel('Amplitudinea (dB)');
title('Caracteristica de frecventa a FTJ - Sensul Normei Infinit'); 
hold on;

%fara functia pondere
h_normainfw = firpm(M,W,A); %functia pondere a FTJ
[H_normainfw,omega_normainfw] = freqz(h_normainfw,1,120); %raspunsul in frecventa
plot(omega_normainfw,20*log(abs(H_normainfw))); %afisarea caracteristicii de frecventa
legend('Functia pondere [1 5]','Functia pondere [1 1]'); 
hold off;

subplot(2,1,2);
[faza_normainf, omega_normainf] = phasez(h_normainf,1,120); %faza filtrului
plot(omega_normainf, faza_normainf); %trasarea graficului fazei
hold on;

[faza_normainfw, omega_normainfw] = phasez(h_normainfw,1,120); %faza filtrulu
plot(omega_normainfw, faza_normainfw); %afisarea graficului fazei
xlabel('Frecventa'); 
ylabel('Faza');
title('Faza FTJ - Sensul Normei Infinit'); 
legend('Functia pondere [1 5]','Functia pondere [1 1]'); 
hold off;

saveas(gcf,'Faza1-D-Normainf.png'); 

indstop_normainf = find(omega_normainf>(omega_s*pi)); %subvector corespunzator benzii de stopare [omega_s,pi]

for i = 1 : length(indstop_normainf)
    
    n = indstop_normainf(i); %indicii corespunzatori pentru a crea vectorul corespunzator benzii de stopare
    Hstop_normainf(i) = H_normainf(n); %frecvente din vectorul frecventelor in banda de stopare

end

indtrecere_normainf = find(omega_normainf<(omega_p*pi)); %subvector corespunzator benzii de trecere [0,omega_p]

for i = 1 : length(indtrecere_normainf)
    
    n = indtrecere_normainf(i); %indicii corespunzatori pentru a crea vectorul corespunzator benzii de trecere
    Htrecere_normainf(i) = H_normainf(n); %frecvente din vectorul frecventelor in banda de trecere

end

Err_banda_stop_normainf = abs(Hstop_normainf); %eroarea din banda de stopare
Err_banda_trecere_normainf = abs(1-Htrecere_normainf); %eroarea din banda de trecere
RPM  = std(abs(Hstop_normainf))/std(abs(1-Htrecere_normainf))

Err_banda_stop_norma2 = abs(Hstop_norma2); %eroarea din banda de stopare
Err_banda_trecere_norma2 = abs(1-Htrecere_norma2); %eroarea din banda de trecere
RLS  = std(abs(Hstop_norma2))/std(abs(1-Htrecere_norma2))
