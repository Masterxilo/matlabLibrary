function movie_to_avi(F, filename, FrameRateInFPS)
    % takes the same kind of argument as movie
    % and saves the output to a file instead of playing it in a figure
    
     myavi = VideoWriter(filename); myavi.FrameRate = FrameRateInFPS; 
     open(myavi);
    for f=F
 writeVideo(myavi,f);
    end
close(myavi)