function B = naiveCircularBoxFilter(A, n)
    % naive implementation of a box filter with circular boundaries
    % O(n^2 * w * h) complexity
    % n must be odd
    assert(oddQ(n));
    k = (n-1)/2; % radius
    
    B = zeros(size(A));
    
    w = matrixWidth(A);
    h = matrixHeight(A);
    
    for x=1:w
        for y=1:h
            
            avg = 0;
            for dx=-k:k
                for dy=-k:k
                    avg = avg + A(wrapN(y+dy, h), wrapN(x+dx, w));
                end
            end
            avg = avg/n^2;
            
            B(y,x) = avg;
            
        end
        
    end