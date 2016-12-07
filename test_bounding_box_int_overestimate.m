
o = cpstruct_10_face_1_2_1000();
close all
figure()
hold on

i = face1_1000();
aabbi = bounding_box_int_overestimate(o.inputPoints)
i(aabbi(1,2):aabbi(2,2), aabbi(1,1):aabbi(2,1), 1) = 1;

imshow(i);

scatter(o.inputPoints(:,1),o.inputPoints(:,2))
