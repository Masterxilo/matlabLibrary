o = cpstruct_10_face_1_2_1000();
close all
figure()
hold on
imshow(face1_1000());
scatter(o.inputPoints(:,1),o.inputPoints(:,2))
rectangle('Position', bounding_box_to_rectangle(bounding_box(o.inputPoints)),'EdgeColor','red')