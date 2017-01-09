%% Creates a plot as in Peter Bertholet's Masterthesis "DEC in a week"
s=ezsurf('-x^2-y^2', [-1 1 -1 1], 30)
s.FaceColor = 'r'
s.FaceLighting = 'gouraud'
h=light
h.Position = [0 -1 0 ]
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