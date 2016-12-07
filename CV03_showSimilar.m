function CV03_showSimilar(ids, rating, images_f)
  % Find and show M most similar images
  M = 6;
  ids = ids(1:M);
  figure()
  i = 1;
  hold on
  for imId = [ids]
      subplot(2, 3, i); i = i + 1;
      imshow(images_f(imId));
      title(['image' num2str(imId) ' score ' num2str(rating(imId))]);
  end
  mtit('Most similar images');