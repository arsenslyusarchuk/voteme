'use strict';

angular.module('voteMe')
  .factory('Poll', ['$resource', function ($resource) {
    return $resource(
      '/api/v1/polls/:id/:action',
      {
        id: '@id'
      },
      {
        'update': { method: 'PUT' },
        'endVoting': {
          method: 'GET',
          params: { action: 'stop' }
        }
      }
    );
  }
]);
