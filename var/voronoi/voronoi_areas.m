function area = voronoi_areas ( n, first, list_num, list, xyz, v_num, v_xyz )

%*****************************************************************************80
%
%% VORONOI_AREAS computes the area of each polygon in a Voronoi diagram.
%
%  Discussion:
%
%    Thanks to Mark Bydder for pointing out a problem that can occur if
%    two consecutive Voronoi vertices are essentially equal.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    08 October 2015
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer N, the number of data points and Voronoi polygons.
%
%    Input, integer FIRST(N+1), for each polygon, points to the location
%    in LIST of the index.
%
%    Input, integer LIST_NUM, the number of items in LIST.
%
%    Input, integer LIST(LIST_NUM), the indices of vertices that form 
%    each polygon.
%
%    Input, real XYZ(3,N), the coodinates of the data points.
%
%    Input, integer V_NUM, the number of Voronoi vertices.
%
%    Input, real V_XYZ(3,V_NUM), the coordinates of the Voronoi vertices.
%
%    Output, real AREA(N), the area of each Voronoi polygon.
%
  area = zeros ( n, 1 );

  r = 1.0;

  for poly = 1 : n
%
%  Compute the area of each triangle formed by one side of the polygon
%  and the Delaunay point.
%
    v3 = list(first(poly+1)-1);

    for l = first(poly) : first(poly+1) - 1

      v2 = v3;
      v3 = list(l);
      if ( sqrt ( eps ) < norm ( v_xyz(1:3,v2) - v_xyz(1:3,v3) )  )
        t = stri_vertices_to_area ( r, xyz(1:3,poly), v_xyz(1:3,v2), v_xyz(1:3,v3) );
        area(poly) = area(poly) + stri_vertices_to_area ( r, ...
          xyz(1:3,poly), v_xyz(1:3,v2), v_xyz(1:3,v3) );
      end

    end

  end

  return
end
