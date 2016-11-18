% trivial test, plotting the values for a given a
a=0.2

close all
f = @(x) fake_gamma_compression(x,a)

c = [0:0.01:sqrt(2)]
plot(c,arrayfun(f, c))
axis equal