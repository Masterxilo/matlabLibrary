%% Creates a plot as in Peter Bertholet's Masterthesis "DEC in a week"
close all

s=ezsurf('-x^2+y^2', [-1 1 -1 1], 30)
s.FaceColor = 'r'
s.FaceLighting = 'gouraud'
h=light
h.Position = [0 -1 0 ]

s.BackFaceLighting = 'unlit'
hold on

% Tangent plane at x = 0, y = 0.5
% Note that the intersection curves in Peter's Thesis are probably wrong
% maybe the whole plane was faked/hacked in e.g. Inkscape
s=ezsurf('y-0.25', [-1 1 -1 1], 2)
s.LineStyle='none'
s.FaceAlpha=0.5
s.FaceLighting = 'none'
s.FaceColor = 'w'


a = gca

a.XLabel = []
a.YLabel = []


a.XTickLabelMode = 'manual'
a.XTickLabels = []

a.YTickLabelMode = 'manual'
a.YTickLabels = []

a.ZTickLabelMode = 'manual'
a.ZTickLabels = []
title('')

a.CameraPosition = [-5.6506 -9.5929 12.2683]
