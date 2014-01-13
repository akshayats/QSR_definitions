function hndl = drawPlane(Vertices, varargin)
    if nargin == 1
        colr = 'b';
        hndl = figure;
    elseif nargin == 2
        colr = varargin{1};
        hndl = figure;
    elseif nargin == 3
        colr = varargin{1};
        hndl = varargin{2};
    end
    [r,c]   = size(Vertices);
    if r > 2
        figure(hndl);
        hold on;
        plot(Vertices([1:end,1], 1),Vertices([1:end,1], 2), colr);
    elseif c > 2
        figure(hndl);
        hold on;
        plot(Vertices(1, [1:end,1]),Vertices(2, [1:end,1]), colr);
    elseif r == c && r == 2
        warning('TSA:: Plotting only a line assuming points are specified along rows!');
    else
        error('TSA:: Wrong dimensions for input arguments!');
    end
    axis equal;
end