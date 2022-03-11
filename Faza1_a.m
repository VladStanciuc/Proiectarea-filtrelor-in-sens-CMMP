%Proiect PS  Proiectarea filtrelor FIR prin optimizare

%Nume: Stanciuc
%Prenume: Vlad-Nicolae
ng = 2;
ns = 12;

%Obtinerea datelor initiale
[omega_p,omega_s,M] = PS_Prj_2_Faza_1ab(ng,ns);

%Salvare omega_p si omega_s impartite la pi
omega_p = 0.3920; 
omega_s = 0.5316;
M = [10 27 37 47 73 87 100];




%Notare automata a legendei pe grafice
legendString = 'M = ' + string(M);

%Subpunctul a.


%Declaram parametrii necesari pentru apelarea firls
W = [0 omega_p omega_s 1]; %W contine benzile de interes
A = [1 1 0 0]; %A contine valorile raspunsului dorit in benzile de interes

%Matricea numarul 1
figure('Name', 'Faza 1 - a - {omega_p, omega_s, M}');

for i = 1:1:7
    
   %Spectrul filtrului in coordonate liniare
   
   subplot(3, 1, 1);
   h = firls(M(i)-1,W,A); %functia pondere a FTJ
   plot(h);
   xlabel('Pulsatiile normalizate');
   ylabel('Raspunsul dorit in benzile de interes');
   title('Spectrul filtrului in coordonate liniare - metoda LS');
   hold on;

   
   %Caracteristica de frecventa
   subplot(3, 1, 2);
   h = firls(M(i)-1,W,A); 
   [H,omega] = freqz(h,1,1000); %raspunsul in frecventa cu o rezulutie de peste 1000 de puncte
   plot(omega, 20*log(abs(H))); %trasarea caracteristicii de frecventa
   xlabel('Vectorul de frecvente');
   ylabel('Amplitudinea masurata in dB');
   title('Caracteristica de frecventa a FTJ - metoda CMMP');
   hold on;

   legend(legendString);
   
   %Faza filtrului
   subplot(3, 1, 3);
   [faza, omega] = phasez(h,1,1000); %faza filtrului cu o rezolutie de peste 1000 de puncte
   plot(omega, faza); %trasarea graficului fazei
   xlabel('Vectorul de frecvente');
   ylabel('Faza');
   title('Faza filtrului ');
   hold on;
   legend(legendString);
end


%Matricea numarul 2
pi_minus_omega_p = (pi - omega_p)/ pi;
pi_minus_omega_s = (pi - omega_s) / pi;

figure('Name', 'Faza 1 - a - {pi-omega_s, pi-omega_p, M}');
W1 = [0 pi_minus_omega_s pi_minus_omega_p 1]; 
A = [1 1 0 0]; 

for i = 1:1:7
   % %Spectrul filtrului in coordonate liniare
   subplot(3, 1, 1);
   h = firls(M(i)-1,W1,A);
   plot(h);
   xlabel('Pulsatiile normalizate');
   ylabel('Raspunsul dorit in benzile de interes');
   title('Spectrul filtrului in coordonate liniare - metoda CMMP');
   
   hold on;

   
   %Spectrul filtrului in dB
   subplot(3, 1, 2);
   h = firls(M(i)-1,W1,A); %functia pondere a FTJ
   [H,omega] = freqz(h,1,1000); %raspunsul in frecventa cu o rezulutie de peste 1000 de puncte
   plot(omega, 20*log(abs(H))); %trasarea caracteristicii de frecventa
   xlabel('Vectorul de frecvente');
   ylabel('Amplitudinea masurata in dB');
   title('Caracteristica de frecventa a FTJ - metoda CMMP');
   hold on;

   legend(legendString);
   
   %Faza filtrului
   subplot(3, 1, 3);
   [faza, omega] = phasez(h,1,1000); %faza filtrului cu o rezolutie de peste 1000 de puncte
   plot(omega, faza); %trasarea graficului fazei
   xlabel('Vectorul de frecvente');
   ylabel('Faza');
   title('Faza filtrului - metoda CMMP');
   hold on;
   legend(legendString);
end


%Matricea numarul 3
% figure('Name', 'Faza 1 - a - Secventele pondere suprapuse - metoda CMMP');
% for i = 1:1:7
%     
%     subplot(7, 1, i);
%     h = firls(M(i)-1,W,A);
% 
%     t = 0:1:(M(i)-1);
%     stem(t, h);
%  
%     hold on;
%     h = firls(M(i)-1,W1,A);
%   
%     stem(t, h);
%  
%     hold on;
% end
% 



