'use strict';

angular.module('voteMe')
  .controller('PollsCtrl', ['$scope', '$rootScope', 'Poll', '$timeout', '$window', '$location', '$routeParams', function ($scope, $rootScope, Poll, $timeout, $window, $location, $routeParams) {
    $scope.busy = false;
    $scope.polls = [];
    $scope.lastPoll = '';
    $scope.filterCriteria = {
      page: 1,
      per_page: 10,
      order_by_id: 'desc',
      search: $routeParams.search || ''
    };
    $scope.isLastEmpty = false;

    function dividePolls(data){
      if ($scope.filterCriteria.page == 1){
        $scope.lastPoll = data.splice(0,1)[0];
      }

      $scope.polls = $scope.polls.concat(data);
    }
    // infinite scroll (load next page)
    $scope.load_data = function() {
      if ($scope.busy || $scope.isLastEmpty) return;
      $scope.busy = true;
      Poll.query($scope.filterCriteria, function(data){
        $scope.busy = false;
        $scope.isLastEmpty = data.length == 0;
        dividePolls(data);
        $scope.filterCriteria.page +=1;
      }, function(err){
        console.warn(JSON.stringify(err));
      });
    };


    $scope.addCreatedPoll = function(e, poll) {
      if ($scope.lastPoll) {
        $scope.polls.unshift($scope.lastPoll);
      }
      $scope.lastPoll = poll;
    };

    $scope.search = function(e, search) {
      if (search !== $scope.filterCriteria.search){
        $scope.filterCriteria = {
          page: 1,
          per_page: 10,
          order_by_id: 'desc',
          search: search
        };
        Poll.query($scope.filterCriteria, function(data){
          if ($scope.lastPoll && $scope.lastPoll.id == data[0].id) {
            for(var i=0;i<data.length;i++){
              if (data[i].id === $scope.lastPoll.id) {
                data.splice(0,1)[i];
              }
            }
          }
          $scope.polls = data;
          $scope.isLastEmpty = data.length == 0;
          $scope.filterCriteria.page +=1;

        }, function(err){
          console.warn(JSON.stringify(err));
        });
      }
    };

    $rootScope.$on('new-poll-added', $scope.addCreatedPoll);
    $rootScope.$on('search-event', $scope.search);
  }]);
