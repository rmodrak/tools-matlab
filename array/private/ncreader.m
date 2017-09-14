function [x,y,Z,fobj] = ncreader(file,schema)
%NCREADER Reads netCDF file.
%   Reads 2-D array from netCDF file based on chosen schema.
%
%   NOTE: There appears to be a bug in the MATLAB function "ncread" that
%   causes a 2-D array to be transposed as compared with the command line
%   utility ncdump.

switch schema
    case 'grid'
        try 
            % read 1-D coordinate arrays
            x = ncread(file,'nx');
            y = ncread(file,'ny');

            % read 2-D data array
            Z = ncread(file,'Z');

            % bug workaround
            Z = transpose(Z);
            
        catch
            error('schema mismatch')
            
        end
        
    case 'coards'
        % reads COARDS netCDF file
        fobj = ncinfo(file);
        vars = {fobj.Variables.Name};
        dims = {fobj.Dimensions.Name};

        % 1-D variables whose dimension names are identical to their
        % variable names are "coordinate variables"
        c = intersect(vars,dims);
        
        % variables that are not coordinate variables are "data variables"
        d = setdiff(vars,dims);

        if 0
            % print variable names
            fprintf('coordinate variables:\n')
            cellstrdisp(c)
            fprintf('\n')
            fprintf('data variables:\n')
            cellstrdisp(d)
            fprintf('\n')
        end
        
        % read 2-D data array
        Z = ncread(file,cell2mat(d));

        % bug workaround
        Z = transpose(Z);
        
        % read 1-D coordinate arrays
        obj = ncinfo(file,cell2mat(d));
        x = ncread(file,obj.Dimensions(1).Name);
        y = ncread(file,obj.Dimensions(2).Name);
        
    otherwise
        badopt()

end
