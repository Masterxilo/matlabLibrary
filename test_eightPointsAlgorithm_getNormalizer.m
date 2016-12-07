close all;
p = rand(2,100);
figure('Name', ['before normalizing. mean squared norm: ' num2str(meansqr_norm(p))]);
scatter2(p);

p = cartesian_to_homogeneous_dn(p);
T = eightPointsAlgorithm_getNormalizer(p);
p2 = homogeneous_to_cartesian_dn(T * p);

figure('Name', ['after normalizing mean squared norm: ' num2str(meansqr_norm(p2))]);
scatter2(p2);