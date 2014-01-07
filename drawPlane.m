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
    figure(hndl);
    hold on;
    plot(Vertices([1:end,1], 1),Vertices([1:end,1], 2), colr);
    axis equal;

end