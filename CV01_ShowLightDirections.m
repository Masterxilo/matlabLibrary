function CV01_ShowLightDirections(L)
  figure('Name', 'Orthographic projection of light directions');
  plot(L(1,:), L(2,:), '-*g');