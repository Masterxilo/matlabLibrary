function out = bfilt(im, sigma_s, sigma_r)
    % Bilateral filter with spatial smoothing kernel of size sigma_s
    % and value range smoothing kernel of size sigma_r
    %
    % im a 2d grayscale image in double format, values from 0 to x (can be
    % hdr/log domain)
    
    assert(ismatrix(im))
    assert(isreal(sigma_s));
    assert(sigma_s > 0);
    assert(isreal(sigma_r));
    assert(sigma_r > 0);
    
    out = im;
    dim = size(im);
    
    % Kernel side length, an uneven integral number
    % derived from the spatial sigma_s
    w = ceil(1.5 * sigma_s);
    len = 2*w + 1;
    
    %  construct gaussian filter mask
    distances2 = repmat(-w:w, len, 1).^2;
    distances2 = distances2 + repmat((-w:w)', 1, len).^2;
    
    gauss = exp(-distances2 / (2*sigma_s^2));
    
    assert(all(size(gauss) == [len len]));
    
    clampy = @(y) clip(y, 1, dim(1));
    clampx = @(x) clip(x, 1, dim(2));
    
    hb = waitbar_start('bfilt (Bilateral filter) in progress...');
    for y=1:dim(1)
        waitbar(y / dim(1));
        for x=1:dim(2)
            % xi == (y,x)
            
            % reduce gauss to not overlap the boundaries
            rgauss = gauss((clampy(y-w):clampy(y+w)) - y + w + 1, (clampx(x-w):clampx(x+w))-x + w + 1);
            
            
            value = im(y,x); % f(xi)
            
            % Find differences of value at x,y to w-neighborhood
            valuesN = im(clampy(y-w):clampy(y+w), clampx(x-w):clampx(x+w));
            diff = value - valuesN;
            
            % apply range-gaussian to obtain value-difference based weights
            diffweight = exp(- (diff.^2) / (2 * sigma_r^2));
            
            
            assert(all(size(valuesN) == size(rgauss)));
            
            % combine to final weight matrix
            weights = rgauss .* diffweight;
            
            % Compute normalization term
            nor = total(weights);
            
            % apply weights and sum up to obtain final new value
            out(y, x) = total(weights .* valuesN) / nor;
            %assert(0 <= out(y, x) ); % sanity check %&& out(y, x) <= 1);
        end
    end
    
    close(hb);