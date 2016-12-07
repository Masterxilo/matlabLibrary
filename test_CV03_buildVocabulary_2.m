% uses CV03_buildVocabulary

% 1. build 'image iterator' returning an image or [] for a small test
% dataset (two images)
image1 = CV03_dataAintNobody_frame(5);
image2 = CV03_dataAintNobody_frame(6);
images = {image1, image2, []}
images_f = @(i) cell2mat(images(i))

%%
CV03_buildVocabulary(images_f, 100)