function im = CV03_dataAintNobody_frame(i)
  % if the frame does not exist, [] is returned
  % making this suitable as an image_f passed to CV03_buildVocabulary
  assert(i > 0);
  n = CV03_dataAintNobody_framecount();
  if i > n
    im = [];
  else
    im = imreaddouble([Fixtures_dir_matlab() '/dataAintNobody_frames/frame' num2str(i) '.jpg']);
  end