
function [h pr] = firls_FTS_c(M,ws,wp,K)

%
% BEGIN
%
% Constants & Messages 
% ~~~~~~~~~~~~~~~~~~~~
	FN = '<FIRLS_FTS_C>: ' ;
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
	ws = abs(ws(1)) ; 
	if ~ws || ws>=1
	   war_err(E1) ;
	   return ; ; 
	end ; 
	wp = abs(wp(1)) ; 
	if ~wp || wp>=1
	   war_err(E1) ;
	   return ; ; 
	end ; 
	if ws>wp
	   FN = ws ; 
	   ws = wp ; 
	   wp = FN ; 
	end ; 
	if (nargin < 4)
	   K = 0 ;
	end ; 
	K = round(abs(K(1))) ; 
%
% Filter design
% ~~~~~~~~~~~~~
	M = (0:M)';		% This is the filter support.
	R = ws*sinc(M*ws) + eye(size(M)) - wp*sinc(M*wp); %
	R = toeplitz(R);	% This is the matrix to invert.
	r = double(K==M) - wp*sinc((K-M)*wp);	% This is the free vector.
	h = R\r;
    Vid = pi - wp;
    pr = 100*(Vid - r'*h)/Vid; %performanta relativa
%

