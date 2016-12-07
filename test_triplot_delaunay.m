o = cpstruct_10_face_1_2_1000()
d = delaunay(o.inputPoints)
figure()
hold on
imshow(face1_1000())
triplot(d, o.inputPoints(:,1), o.inputPoints(:,2))
