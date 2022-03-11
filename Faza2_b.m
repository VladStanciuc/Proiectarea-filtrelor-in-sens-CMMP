

%subpunctul b

%Parametrii utilizati pentru apelarea functiei firls_FTJ_c.m sunt:
omega_p = 0.3920;
omega_s = 0.5316;

%trasarea secventei pondere si a raspunsului in frecventa pentru valori diferite ale intarzierii de grup si ale ordinului filtrului
for M = 10 : 20 : 100

    figure();
    [h pr] = firls_FTJ_c(M,omega_p,omega_s,M/2); %functia pondere a FTJ;
    
    %secventa pondere
    subplot(3,1,1);
    stem(h); %trasarea secventei pondere a FTJ
    xlabel('Timp'); 
    ylabel('Amplitudine');
    title(['Secventa pondere pentru M=',num2str(M),' si K=',num2str(M/2)]); 
    legend(['Performanta Relativa = ',num2str(pr)]); %performanta relativa
    
    %raspunsul in frecventa
    subplot(3,1,2);
    [H,omega] = freqz(h,1,130); %raspunsul in frecventa cu 130 de linii spectrale
    plot(omega,20*log(abs(H))); %trasarea caracteristicii de frecventa
    xlabel('Vectorul frecventelor'); 
    ylabel('Amplitudinea (dB)');
    title(['Caracteristica de frecventa pentru M=',num2str(M),' si K=',num2str(M/2)]); 
    
    %faza
    subplot(3,1,3);
    [faza, omega] = phasez(h,1,130); %faza filtrului cu rezolutia 130 de linii spectrale
    plot(omega, faza); %trasarea graficului fazei
    xlabel('Frecventa'); 
    ylabel('Faza');
    title(['Faza pentru M=',num2str(M),' si K=',num2str(M/2)]); 
    
    
end



%Folosim perechea de pulsatii {pi-omega_s, pi-omega_p};

%%
pi_minus_omega_p = 0.8752;
pi_minus_omega_s = 0.8307;

for M = 10 : 20 : 100

    figure();
    [h pr] = firls_FTJ_c(M,pi_minus_omega_p,pi_minus_omega_s,M/2); %functia pondere a FTJ;
    
    %secventa pondere
    subplot(3,1,1);
    stem(h); %trasarea secventei pondere a FTJ
    xlabel('Timp'); 
    ylabel('Amplitudine');
    title(['Secventa pondere pentru M=',num2str(M),' si K=',num2str(M/2)]); 
    legend(['Performanta Relativa = ',num2str(pr)]); %performanta relativa
    
    %raspunsul in frecventa
    subplot(3,1,2);
    [H,omega] = freqz(h,1,130); %raspunsul in frecventa cu 130 de linii spectrale
    plot(omega,20*log(abs(H))); %trasarea caracteristicii de frecventa
    xlabel('Vectorul frecventelor');
    ylabel('Amplitudinea (dB)');
    title(['Caracteristica de frecventa pentru M=',num2str(M),' si K=',num2str(M/2)]); 
    
    %faza
    subplot(3,1,3);
    [faza, omega] = phasez(h,1,130); %faza filtrului cu rezolutia 130 de linii spectrale
    plot(omega, faza); %trasarea graficului fazei
    xlabel('Frecventa'); 
    ylabel('Faza');
    title(['Faza pentru M=',num2str(M),' si K=',num2str(M/2)]); 
    
    
end
