function n = CV03_dataAintNobody_framecount(i)
  b = [Fixtures_dir_matlab() '/dataAintNobody_frames/frame'];
  n = 1;
  while isfile([b num2str(n) '.jpg'])
    n = n + 1;
  end
  n = n - 1;