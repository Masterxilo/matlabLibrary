function t = crossmat_vector(tx)
% approximate inverse of crossmat
    t = [mean([tx(3,2),-tx(2,3)]);mean([tx(1,3),-tx(3,1)]);mean([tx(2,1),-tx(1,2)])];