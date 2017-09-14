function bytes = sizeof(precision)
%SIZEOF Size of data type in bytes.

switch precision
    
    case 'uint8'
        bytes = 1;
    
    case {'ushort' 'uint16'}
        bytes = 1;
    
    case {'uint' 'uint32'}
        bytes = 4;

    case 'uint64'
        bytes = 8;

    case 'int8'
        bytes = 1;
    
    case {'short' 'int16'}
        bytes = 2;
    
    case 'int32'
        bytes = 4;
    
    case 'int64'
        bytes = 8;
        
    case {'single' 'float' 'float32'}
        bytes = 4;
    
    case {'double' 'float64'}
        bytes = 8;
        
    case 'uchar'
        bytes = 1;
        
    case 'bit8'
        bytes = 1;
    
    case 'bit48'
        bytes = 6;

    otherwise
        error(badname(precision))

end
