function n = computer_name()
  [~, n] = system('hostname');
  n = string_most(n);