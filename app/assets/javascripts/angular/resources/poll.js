'use strict';

angular.module('voteMe')
  .factory('Poll', ['$resource', function ($resource) {
    return $resource(
      '/api/v1/polls/:id',
      {
        id: '@id'
      },
      {
        'update': { method: 'PUT' }
      }
    );
  }
]);
