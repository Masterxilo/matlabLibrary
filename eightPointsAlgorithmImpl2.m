function [F] = eightPointsAlgorithmImpl2(x1,x2, normalized)

F = estimateFundamentalMatrix(x1([1 2],:)',x2([1 2],:)','Method','Norm8Point');