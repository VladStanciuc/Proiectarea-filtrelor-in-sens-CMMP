%
%	File FIRLS_FTB_C.M
%
%	Function: FIRLS_FTB_C


function [h pr] = firls_FTB_c(M,wsl,wpl,wpr,wsr,K)

%
% BEGIN
%
% Constants & Messages 
% ~~~~~~~~~~~~~~~~~~~~
	FN = '<FIRLS_FTB_C>: ' ;
	E1 = [FN 'Missing, empty or inconsistent input data => empty output. Exit.'] ; 
%
% Faults preventing
% ~~~~~~~~~~~~~~~~~
	h = [] ; 
	if (nargin < 3)
	   war_err(E1) ;
	   return ; ; 
	end ; 
	M = round(abs(M(1))) ; 
	if ~M
	   war_err(E1) ;
	   return ; ; 
	end ;
%
% pulsatiile FTB
%
    wsl = abs(wsl(1)) ; 
	if ~wsl || wsl>=1
	   war_err(E1) ;
	   return ; ; 
	end ;
    wpl = abs(wpl(1)) ; 
	if ~wpl || wpl>=1
	   war_err(E1) ;
	   return ; ; 
	end ;
    wpr = abs(wpr(1)) ; 
	if ~wpr || wpr>=1
	   war_err(E1) ;
	   return ; ; 
	end ;
    wsr = abs(wsr(1)) ; 
	if ~wsr || wsr>=1
	   war_err(E1) ;
	   return ; ; 
	end ;
	if wsl>wpl
	   FN = wsl ; 
	   wsl = wpl ; 
	   wpl = FN ; 
	end ;
    if wpl>wpr
	   FN = wpl ; 
	   wpl = wpr ; 
	   wpr = FN ; 
	end ; 
    if wpr>wsr
	   FN = wpr ; 
	   wpr = wsr ; 
	   wsr = FN ; 
	end ; 
	if (nargin < 4)
	   K = 0 ;
	end ; 
	K = round(abs(K(1))) ; 
%
% Filter design
% 
	M = (0:M)';		% This is the filter support.
	R = wsl*sinc(M*wsl) + wpr*sinc(M*wpr) - wpl*sinc(M*wpl) + eye(size(M)) - wsr*sinc(M*wsr);
	R = toeplitz(R);	% This is the matrix to invert.
	r = wpr*sinc((K-M)*wpr) - wpl*sinc((K-M)*wpl);	% This is the free vector.
	h = R\r;
    Vid = wpr - wpl; 
    pr = 100*(Vid-r'*h)/Vid;  %performanta relativa

