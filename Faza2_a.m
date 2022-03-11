

%subpunctul a

M = 20; %ordinul filtrului
omega_p = 0.3920;
omega_s = 0.5316;
K = [5 7 10 13 15];

for i = 1:1:length(K)

    h= firls_FTJ_c(M,omega_p,omega_s,i); %functia pondere a FTJ; 
    
    %secventa pondere
    subplot(3,1,1);
    stem(h); %trasarea secventei pondere a FTJ
    xlabel('Timp'); 
    ylabel('Amplitudinea liniara');
    title('Secventa pondere'); 
    hold on;
    legend('K=5','K=7','K=10','K=13','K=15'); %legenda
    
    %raspunsul in frecventa
    subplot(3,1,2);
    [H,omega] = freqz(h,1,120); %raspunsul in frecventa cu rezolutia 120 de linii spectrale
    plot(omega,20*log(abs(H))); %trasarea caracteristicii de frecventa
    xlabel('Vectorul frecventelor'); 
    ylabel('Amplitudinea (dB)');
    title('Caracteristica de frecventa '); 
    hold on;
    legend('K=5','K=7','K=10','K=13','K=15'); 
    
    %faza
    subplot(3,1,3);
    [faza, omega] = phasez(h,1,120); %faza filtrului cu rezolutia 120 de linii spectrale
    plot(omega, faza); %trasarea graficului fazei
    xlabel('Frecventa'); 
    ylabel('Faza');
    title('Faza'); %titlul figurii
    legend('K=5','K=7','K=10','K=13','K=15'); 
    hold on;

end
saveas(gcf,'Faza2-A1.png'); 

figure();
for i = 1:1:length(K)
    
    h = firls_FTJ_c(M,omega_p,omega_s,i); %functia pondere a FTJ; 
    
    %deviatia de la liniaritate
    grpdelay(h,1000);
    title('Deviatia de la liniaritate'); 
    hold on;
    legend('K=5','K=7','K=10','K=13','K=15'); 
    
end
saveas(gcf,'Faza2-A2.png'); 

figure();
%intarzierea = M/2
    h = firls_FTJ_c(M,omega_p,omega_s,M/2); 
    
%secventa pondere
    subplot(4,1,1);
    stem(h); %trasarea secventei pondere a FTJ
    xlabel('Timp'); 
    ylabel('Amplitudinea liniara');
    title('Secventa pondere'); 
    legend('K=10');
    
%raspunsul in frecventa
    subplot(4,1,2);
    [H,omega] = freqz(h,1,120); %raspunsul in frecventa cu rezolutia 120 de linii spectrale
    plot(omega,20*log(abs(H))); %trasarea caracteristicii de frecventa
    xlabel('Vectorul frecventelor');
    ylabel('Amplitudinea (dB)');
    title('Caracteristica de frecventa '); 
    hold on;
    legend('K=10'); %legenda
    
%faza
    subplot(4,1,3);
    [faza, omega] = phasez(h,1,120); %faza filtrului cu rezolutia 120 de linii spectrale
    plot(omega, faza); %trasarea graficului fazei
    xlabel('Frecventa'); 
    ylabel('Faza');
    title('Faza'); 
    legend('K=10'); 
    

    subplot(4,1,4)
    grpdelay(h,1000);
    title('Deviatia de la liniaritate'); %titlul figurii
    hold on;
    legend('K=10'); 
saveas(gcf,'Faza2-A-K=10.png'); 
