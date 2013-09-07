App.factory('Event', ['$resource', function($resource) {
  return $resource('/events/:id', { id: '@id' });
}]);
