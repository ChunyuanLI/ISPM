% evaluate ispm

% load settings
% setting_up;

fprintf('Display the distances...\n');
% pLevels is the level of partition
[~,num_shapes,pLevels] = size(D_multi_level);

% Single level partition
for p = 1: pLevels
    D = D_multi_level(:,:,p);
    fprintf('Single level partition %dth level performace.\n', p);
    display_distance( D );
end

% Linear combined level partition
for p = 1: pLevels
    D = sum(D_multi_level(:,:,1:p),3);
    fprintf('Linear combined level partition %dth level performace.\n', p);
    display_distance( D );
end

% Weighted combined level partition
for p = 1: pLevels
    if p == 1
        D = D_multi_level(:,:,p);
    else
        D = zeros(num_shapes,num_shapes);
        for pp = 1:p-1
            D =  D + (D_multi_level(:,:,pp) - D_multi_level(:,:,pp+1))./2^(p-pp);
        end
    end
    D = sum(D_multi_level(:,:,1:p),3);
    
    fprintf('Weighted combined level partition %dth level performace.\n', p);
    display_distance( D );
end