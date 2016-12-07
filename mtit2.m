function mtit(str) 
 % http://www.mathworks.com/matlabcentral/newsreader/view_thread/244434
    set(gcf,'NextPlot','add');
axes;
h = title(str);
set(gca,'Visible','off');
set(h,'Visible','on');