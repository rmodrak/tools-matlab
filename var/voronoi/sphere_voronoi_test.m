function sphere_voronoi_test ( )

%*****************************************************************************80
%
%% SPHERE_VORONOI_TEST tests the SPHERE_VORONOI library.
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
  timestamp ( );
  fprintf ( 1, '\n' );
  fprintf ( 1, 'SPHERE_VORONOI_TEST\n' );
  fprintf ( 1, '  MATLAB version:\n' );
  fprintf ( 1, '  Test the SPHERE_VORONOI library.\n' );

  sphere_voronoi_test01 ( );
  sphere_voronoi_test02 ( );
  sphere_voronoi_test03 ( );
  sphere_voronoi_test04 ( );
%
%  Terminate.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'SPHERE_VORONOI_TEST:\n' );
  fprintf ( 1, '  Normal end of execution.\n' );
  fprintf ( 1, '\n' );
  timestamp ( );

  return
end
