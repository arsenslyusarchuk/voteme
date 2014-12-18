'use strict';

angular.module('voteMe')
  .factory('Poll', function ($resource) {
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
);
