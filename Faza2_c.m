


%subpunctul c

%FTS calculat cu functia firls_FTS_c.m

%Parametrii utilizati pentru apelarea functiei firls_FTS_c.m sunt:
M = 20; 
omega_p = 0.3920;
omega_s = 0.5316;


[h_FTS1 pr_FTS]= firls_FTS_c(M,omega_s,omega_p,M/2); %functia pondere a FTS;

%raspunsul in frecventa
[H_FTS1,omega_FTS1] = freqz(h_FTS1,1,110); %raspunsul in frecventa cu 110 de linii spectrale

figure();
subplot(2,1,1);
plot(omega_FTS1,20*log(abs(H_FTS1))); %trasarea caracteristicii de frecventa
xlabel('Vectorul frecventelor'); 
ylabel('Amplitudinea (dB)');
title('Caracteristica de frecventa a FTS construit cu noua functie si M = 20'); 
legend(['Performanta Relativa = ',num2str(pr_FTS)]); 

subplot(2,1,2);
[faza, omega] = phasez(h_FTS1,1,110); %faza filtrului cu rezolutia 110 de linii spectrale
plot(omega, faza); %trasarea graficului fazei
xlabel('Frecventa'); %denumirea axelor
ylabel('Faza');
title('Faza FTS construit cu noua functie si M = 20'); 
saveas(gcf,'Faza2-C-FTS1.png');

%FTS utilizand functia firls predefinita in Matlab

W = [0 omega_p omega_s 1]; 
A = [0 0 1 1]; 

h_FTS2 = firls(M,W,A); %functia pondere a FTS
[H_FTS2,omega_FTS2] = freqz(h_FTS2,1,110); %raspunsul in frecventa cu rezolutia 110 linii spectrale

figure();
subplot(2,1,1);
plot(omega_FTS2,20*log(abs(H_FTS2))); %trasarea caracteristicii de frecventa
xlabel('Vectorul frecventelor'); 
ylabel('Amplitudinea (dB)');
title('Caracteristica de frecventa a FTS construit cu functia FIRLS si avand M = 20'); %titlul figurii

subplot(2,1,2);
[faza, omega] = phasez(h_FTS2,1,110); %faza filtrului; rezolutia 110 de linii spectrale
plot(omega, faza); %trasarea graficului fazei
xlabel('Frecventa'); %denumirea axelor
ylabel('Faza');
title('Faza FTS construit cu functia FIRLS si M = 20'); %titlul figurii

saveas(gcf,'Faza2-C-FTS2.png'); 
hold off;
    
%FTB utilizand firls_FTB_c.m

%Parametrii utilizati pentru apelarea functiei firls_FTB_c.m sunt:
M = 20; 

omega_p = 0.3920;
omega_s = 0.5316;
pi_minus_omega_p = 0.8752;
pi_minus_omega_s = 0.8307;




figure();
[h_FTB1 pr_FTB]= firls_FTB_c(M,omega_s,omega_p, pi_minus_omega_s,pi_minus_omega_p,M/2); %functia pondere a FTB;

%raspunsul in frecventa
[H_FTB1,omega_FTB1] = freqz(h_FTB1,1,110); %raspunsul in frecventa cu 110 de linii spectrale

subplot(2,1,1);
plot(omega_FTB1,20*log(abs(H_FTB1))); %trasarea caracteristicii de frecventa
xlabel('Vectorul frecventelor'); 
ylabel('Amplitudinea (dB)');
title('Caracteristica de frecventa a FTB construit cu noua functie si M = 20'); 
legend(['Performanta Relativa = ',num2str(pr_FTB)]); %afisarea performantei relative

subplot(2,1,2);
[faza, omega] = phasez(h_FTB1,1,110); %faza filtrului cu rezolutia 110 de linii spectrale
plot(omega, faza); %trasarea graficului fazei
xlabel('Frecventa'); 
ylabel('Faza');
title('Faza FTB construit cu noua functie si M = 20'); 

saveas(gcf,'Faza2-C-FTB1.png'); 

%FTB utilizand functia firls

W = [0 omega_p omega_s pi_minus_omega_s pi_minus_omega_p 1];
A = [0 0 1 1 0 0]; 

h_FTB2 = firls(M,W,A); %functia pondere a FTB
[H_FTB2,omega_FTB2] = freqz(h_FTB2,1,110); 

figure();
subplot(2,1,1);
plot(omega_FTB2,20*log(abs(H_FTB2))); %afisarea caracteristicii de frecventa
xlabel('Vectorul frecventelor'); 
ylabel('Amplitudinea (dB)');
title('Caracteristica de frecventa a FTB construit cu functia FIRLS si avand M = 20'); 

subplot(2,1,2);
[faza, omega] = phasez(h_FTB2,1,110); %faza filtrului cu rezolutia 110 de linii spectrale
plot(omega, faza); %trasarea graficului fazei
xlabel('Frecventa'); 
ylabel('Faza');
title('Faza FTB construit cu functia FIRLS si M = 20'); 

saveas(gcf,'Faza2-C-FTB2.png'); 
hold off;   


