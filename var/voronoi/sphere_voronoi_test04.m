function sphere_voronoi_test04 ( )

%*****************************************************************************80
%
%% SPHERE_VORONOI_TEST04 demonstrates the computation of a Voronoi diagram.
%
%  Discussion:
%
%    Because of the regularity of the data, some Voronoi vertices are repeated.
%    This caused problems with a previous version of the code, which broke
%    down over the simple task of computing the area of degenerate triangles.
%
%    This example was supplied by Mark Bydder.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    07 October 2015
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'SPHERE_VORONOI_TEST04\n' );
  fprintf ( 1, '  Compute the area of each Voronoi polygon on a sphere.\n' );
%
%  load points
%
  n = 34;
  d_xyz = [ ...
     0.0,                0.0,                1.0; ...
     0.293892626146237,  0.509036960455127,  0.809016994374947; ...
    -0.293892626146236,  0.509036960455127,  0.809016994374947; ...
    -0.587785252292473,  0.0,                0.809016994374947; ...
    -0.293892626146237, -0.509036960455127,  0.809016994374947; ...
     0.293892626146237, -0.509036960455127,  0.809016994374947; ...
     0.587785252292473,  0.0,                0.809016994374947; ...
     0.769420884293813,  0.559016994374947,  0.309016994374947; ...
     0.293892626146237,  0.904508497187474,  0.309016994374947; ...
    -0.293892626146236,  0.904508497187474,  0.309016994374947; ...
    -0.769420884293813,  0.559016994374948,  0.309016994374947; ...
    -0.951056516295154,  0.0,                0.309016994374947; ...
    -0.769420884293813, -0.559016994374947,  0.309016994374947; ...
    -0.293892626146237, -0.904508497187474,  0.309016994374947; ...
     0.293892626146236, -0.904508497187474,  0.309016994374947; ...
     0.769420884293813, -0.559016994374948,  0.309016994374947; ...
     0.951056516295154,  0.0,                0.309016994374947; ...
     0.559016994374947,  0.769420884293813, -0.309016994374947; ...
     0.0,                0.951056516295154, -0.309016994374947; ...
    -0.559016994374947,  0.769420884293813, -0.309016994374947; ...
    -0.904508497187474,  0.293892626146237, -0.309016994374947; ...
    -0.904508497187474, -0.293892626146236, -0.309016994374947; ...
    -0.559016994374948, -0.769420884293813, -0.309016994374947; ...
     0.0,               -0.951056516295154, -0.309016994374947; ...
     0.559016994374947, -0.769420884293814, -0.309016994374947; ...
     0.904508497187474, -0.293892626146237, -0.309016994374947; ...
     0.904508497187474,  0.293892626146236, -0.309016994374947; ...
     0.0,                0.587785252292473, -0.809016994374947; ...
    -0.509036960455127,  0.293892626146237, -0.809016994374947; ...
    -0.509036960455127, -0.293892626146236, -0.809016994374947; ...
     0.0,               -0.587785252292473, -0.809016994374947; ...
     0.509036960455127, -0.293892626146236, -0.809016994374947; ...
     0.509036960455127,  0.293892626146237, -0.809016994374947; ...
     0.0,                0.0,               -1.0 ]';
%
%  Compute the Voronoi faces.
%
  [ face_num, face ] = sphere_delaunay ( n, d_xyz );
%
%  Report FACE information.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, '  Number of faces = %d\n', face_num );
  i4mat_transpose_print ( 3, face_num, face, '  Faces:' );
%
%  Compute Voronoi vertices.
%
  v_xyz = voronoi_vertices ( n, d_xyz, face_num, face );
%
%  Print Voronoi vertices.
%
  r8mat_transpose_print ( 3, n, v_xyz, '  Voronoi vertices:' );
%
%  Compute Voronoi polygons.
%
  [ first, list ] = voronoi_polygons ( n, face_num, face );
%
%  Print Voronoi polygons.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, '  Voronoi polygons:\n' );
  fprintf ( 1, '\n' );
  for i = 1 : n
    jlo = first(i);
    jhi = first(i+1)-1;
    fprintf ( 1, '  %2d:  ', i );
    for j = jlo : jhi
      fprintf ( 1, '  %2d', list(j) );
    end
    fprintf ( 1, '\n' );
  end
%
%  Compute Voronoi areas.
%
  list_num = length ( list );

  area = voronoi_areas ( n, first, list_num, list, d_xyz, n, v_xyz );
  r8vec_print ( n, area, '  Voronoi areas:' );

  return
end
