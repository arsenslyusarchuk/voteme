'use strict';

/* App Module */
angular.module('voteMe', [
  'ngRoute',
  'ngAnimate',
  'ngResource',
  'ui.bootstrap',
  'infinite-scroll',
  'angucomplete',
  'templates'
])

.config(['$routeProvider', '$locationProvider',
  function($routeProvider,$locationProvider) {

    $routeProvider.
      when('/', {
        templateUrl: 'polls.html',
        controller: 'PollsCtrl'
      }).
      when('/polls/:id', {
        templateUrl: 'polls-detail.html',
        controller: 'PollsDetailCtrl'
      }).
      otherwise({
        redirectTo: '/'
      });
    // $locationProvider.html5Mode(true);
    $locationProvider.html5Mode({
      enabled: true,
      requireBase: false
    });
  }])

.config(["$httpProvider", function($httpProvider) {
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = document.getElementsByName("csrf-token")[0].content;
  $httpProvider.defaults.headers.common['Accept'] = "application/json";

  $httpProvider.interceptors.push(['$q', '$location', '$rootScope', function($q, $location, $rootScope) {
    return {
      'responseError': function(response) {
        switch(response.status){
          case 400:
          case 401:
          case 403:
          case 404:
          case 500:
          case 501:
          case 503:
          case 502:
            $rootScope.message = response;
            break;
        }
        return $q.reject(response);
      }
    };
  }]);
}]);
