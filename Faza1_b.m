
%subpunctul b

omega_p = 0.3920;
omega_s = 0.5316;

W = [0 omega_p omega_s 1];
A = [1 1 0 0];
w = [1 1];

for i = 1:1:7
    %Spectrul filtrului in coordonate liniare
   subplot(3, 1, 1);
   h = firpm(M(i)-1,W,A,w); %functia pondere a FTJ
   plot(h);
   xlabel('Pulsatiile normalizate');
   ylabel('Raspunsul dorit in benzile de interes');
   title('Spectrul filtrului in coordonate liniare');
   hold on;

   
   %Spectrul filtrului in dB
   subplot(3, 1, 2);
   h = firpm(M(i)-1,W,A,w); %functia pondere a FTJ
   [H,omega] = freqz(h,1,1000); %raspunsul in frecventa cu o rezulutie de peste 1000 de puncte
   plot(omega, 20*log(abs(H))); %trasarea caracteristicii de frecventa
   xlabel('Vectorul de frecvente');
   ylabel('Amplitudinea (dB)');
   title('Caracteristica de frecventa a FTJ - Norma infinit (Algoritmul Parks-McClellan)');
   hold on;

   legend(legendString);
   
   %Faza filtrului
   subplot(3, 1, 3);
   [faza, omega] = phasez(h,1,1000); %faza filtrului cu o rezolutie de peste 1000 de puncte
   plot(omega, faza); %trasarea graficului fazei
   xlabel('Frecventa');
   ylabel('Faza');
   title('Faza FTJ - Norma infinit (Algoritmul Parks-McClellan)'); 

   hold on;
   legend(legendString);
end


% %Matricea numarul 3
% % figure('Name', 'Faza 1 - b - Secventele pondere suprapuse - metoda PM');
% % for i = 1:1:7
% %     
% %     subplot(7, 1, i);
% %     h = firpm(M(i)-1,W,A,w);
% %     t = 0:1:(M(i)-1);
% %     stem(t, h);
% %     hold on;
% %     h = firpm(M(i)-1,W1,A,w);
% %     stem(t, h);
% %     hold on;
% % end



