% Y = normalize(X,p,dim)
% Lp normalization of a matrix X along dimension dim
%
% (C) Copyright Alex Bronstein, Michael Bronstein, Maks Ovsjanikov,
% Stanford University, 2009. All Rights Reserved.
function Y = normalize(X,p,dim)

if nargin < 3, dim = 1; end

if ischar(p),
    switch(upper(p)),
        case 'L1', Y = normalize(X,1,dim);
        case 'L2', Y = normalize(X,2,dim);
        case {'none', ''}, Y = X;
    end
    return;
end

n = (sum(abs(X).^p,dim)).^(1/p);
n(n<=0) = 1;
sz = size(X)*0+1;
sz(dim) = size(X,dim);
Y = X./repmat(n,sz);


