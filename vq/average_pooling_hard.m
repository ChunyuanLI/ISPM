function [beta1,beta2] = average_pooling_hard(PHI, desc, B, pyramid)


dSize = size(B', 2);
nSmp = size(desc, 1);
idxBin = zeros(nSmp, 1);
FVs = desc;
interestingpionts = 1:nSmp;

vq_codes = zeros(dSize, nSmp);

% compute the codes for each local feature
DD = pdist2(B,FVs,'euclidean');


for iter1 = 1:nSmp,
    [~,idx] = min(DD(:, iter1),[],1);
    vq_codes(idx,iter1) = 1;
end

vq_codes = abs(vq_codes);

% spatial levels
pLevels = length(pyramid);
% spatial bins on each level
pBins = pyramid;
% total spatial bins
tBins = sum(pBins);

beta1 = zeros(dSize, tBins);
beta2 = zeros(dSize, tBins);

bId = 0;
eigen2 = PHI(:,2);

for iter1 = 1:pLevels,
    
    nBins = pBins(iter1);
    [Element, Index] = sort(eigen2,1);
    levelsets = linspace( min(Index),max(Index),(nBins+1));
  
    for iter2 = 1:nBins
        bId = bId + 1;
        sidxBin = [Index(floor(levelsets(iter2)):ceil(levelsets(iter2+1)))];
        if isempty(sidxBin),
            continue;
        end      
%         [a ~,ib] = intersect(sidxBin,interestingpionts);
%         sidxBin = ib;
        beta1_sum = sum(vq_codes(:, sidxBin), 2);
        beta1_sum = beta1_sum./(sum(beta1_sum(:))+eps);
        %beta1_max = max(vq_codes(:, sidxBin), [], 2);
        %beta1_min = min(vq_codes(:, sidxBin), [], 2);
        persistence = beta1_sum; %beta1_max - beta1_min;
        beta1(:, bId) = persistence;
        
        if iter1 == 1
            beta2(:, 1) = persistence;
        else
            beta2(:, sum(pyramid(1:iter1-1))+nBins-iter2+1) = persistence;    
        end
        
    end
    
end

if bId ~= tBins,
    error('Index number error!');
end

beta1 = beta1(:);
beta1 = beta1./sqrt(sum(beta1.^2));

beta2 = beta2(:);
beta2 = beta2./sqrt(sum(beta2.^2));