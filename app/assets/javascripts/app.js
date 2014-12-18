'use strict';

/* App Module */
angular.module('voteMe', [
  'ngRoute',
  'ngAnimate',
  'ngResource',
  'ui.bootstrap',
  'infinite-scroll',
  'angucomplete'
])

.config(['$routeProvider', '$locationProvider',
  function($routeProvider,$locationProvider) {
    $locationProvider.html5Mode(true);
    // $locationProvider.html5Mode({
    //   enabled: true,
    //   requireBase: false
    // });
    $routeProvider.
      when('/', {
        templateUrl: '/assets/polls.html',
        controller: 'PollsCtrl'
      }).
      when('/polls/:id', {
        templateUrl: '/assets/polls-detail.html',
        controller: 'PollsDetailCtrl'
      }).
      otherwise({
        redirectTo: '/'
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
