enum RouteNames {
  root('/'),
  auth('/auth'),
  users('/users'),
  ;

  const RouteNames(this.path);

  final String path;
}
