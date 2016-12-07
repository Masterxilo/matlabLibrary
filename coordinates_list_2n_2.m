function o = coordinates_list_2n_2(axis_limits)
  % same as coordinates_list_2n but takes axis_limits style parameter
  assert(isaxis_limits(axis_limits));
  o = coordinates_list_2n(axis_limits(1:2), axis_limits(3:4));