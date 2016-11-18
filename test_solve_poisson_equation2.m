% trivial 1-pixel hole
data = [1 2 3;1 2 3;1 2 3];
mask = [0 0 0;0 1 0;0 0 0] == 1;
derivatives = forward_differences2_list(data);

mdata = [1 2 3;1 0 3;1 2 3];

best_fit_data = solve_poisson_equation2(mdata, derivatives, mask);

assert(all2(best_fit_data == data));
