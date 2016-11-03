function prod = arrayProduct(array)
    % gives the product of all variables in array
    
    prod = 1;
    values = array(:)';
    for s=values
        prod = prod * s;
    end