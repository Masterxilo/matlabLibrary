function diff = forward_differences(list)
    % computes the list of successive differences between elements of list
    % returns a list that is one element shorter
    
    diff = list(2:end) - list(1:end-1)