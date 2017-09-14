function ncwriter(file,schema,varargin)
%NCWRITER Writes netCDF file.
%   Writes 2-D array to netCDF file based on a number of available schema.
%
%   NOTE: There appears to be a bug in the MATLAB function "ncread" that
%   causes a 2-D array to be transposed as compared with the command line
%   utility ncdump.

% bug workaround
varargin{3} = transpose(varargin{3});

switch schema
    case 'grid'
        x = varargin{1};
        y = varargin{2};
        Z = varargin{3};
        
        nx = length(x);
        ny = length(y);

        nccreate(file,'nx',...
            'Dimensions',{'nx' nx},...
            'Format','classic');
        nccreate(file,'ny',...
            'Dimensions',{'ny' ny},...
            'Format','classic');
        nccreate(file,'Z',...
            'Dimensions',{'nx' nx 'ny' ny},...
            'Format','classic');

        ncwrite(file,'nx',x);
        ncwrite(file,'ny',y);
        ncwrite(file,'Z',Z);

    case 'map'
        lon = varargin{1};
        lat = varargin{2};
        Z = varargin{3};
        
        nlon = length(lon);
        nlat = length(lat);
        
        nccreate(file,'lon',...
            'Dimensions',{'lon' nlon},...
            'Format','classic');
        nccreate(file,'lat',...
            'Dimensions',{'lat' nlat},...
            'Format','classic');
        nccreate(file,'Z',...
            'Dimensions',{'lon' nlon 'lat' nlat},...
            'Format','classic');
        
        ncwrite(file,'lon',lon);
        ncwrite(file,'lat',lat);
        ncwrite(file,'Z',Z);
        
    case 'default'
        x1 = varargin{1};
        x2 = varargin{2};
        d1 = varargin{3};
        
        n1 = length(x1);
        n2 = length(x2);

        nccreate(file,'n1',...
            'Dimensions',{'n1' n1},...
            'Format','classic');
        nccreate(file,'n2',...
            'Dimensions',{'n2' n1},...
            'Format','classic');
        nccreate(file,'Z',...
            'Dimensions',{'n1' n1 'n2' n2 },...
            'Format','classic');

        ncwrite(file,'x',x1);
        ncwrite(file,'x2',x2);
        ncwrite(file,'d1',d1);

    otherwise
        error(badopt())
        
end
