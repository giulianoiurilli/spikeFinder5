function I0 = loadimg()

options.Resize='on';
options.WindowStyle='normal';


[filename, pathname] = uigetfile( ...
{  '*.tif'; ...
'All Files (*.*)'}, ...
   'Pick a file');

I0 = imread(fullfile(pathname, filename));