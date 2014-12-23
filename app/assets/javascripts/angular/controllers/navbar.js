'use strict';

angular.module('voteMe')
  .controller('NavBarCtrl', ['$scope', '$rootScope', 'Poll', '$modal', '$http', '$location', '$routeParams', function ($scope, $rootScope, Poll, $modal, $http, $location, $routeParams) {
    $scope.testObj = '';

    $scope.$watch('testObj', function (nV,oV) {
      if (nV) {
        if ($routeParams.id) {
          $location.path("/").search({search: nV.title});
        } else {
          $rootScope.$emit('search-event', nV.title);
        }
      }
    });

    $scope.signOut = function(){
      $http.delete('/users/sign_out').success(function(data, status, headers, config) {
        window.location = '/users/sign_in';
      });
    };

    $scope.openPollModal = function() {
      var PollFormCtrl = ['$rootScope', '$scope', '$modalInstance', 'Poll', function ($rootScope, $scope, $modalInstance, Poll) {
        $scope.errorMessage = null;
        $scope.cancel = function () {
          $modalInstance.close();
          resetPoll();
          $scope.pollForm.submitted = false;
        };
        resetPoll();
        function resetPoll() {
          $scope.poll = new Poll({
            answers_attributes: [
              {title: ''},
              {title: ''}
            ],
            poll_type: 'radio'
          });
        }

        $scope.savePoll = function() {
          if($scope.pollForm.$valid) {
            // $scope.showLoading();
            $scope.poll.$save(function (data) {
              // $scope.hideLoading();
              $modalInstance.close();
              resetPoll();
              $rootScope.$emit('new-poll-added', data);
              $scope.errorMessage = null;
            }, function(error){
              // $scope.hideLoading();
              $scope.errorMessage = error.data.message;
            });
          } else {
            $scope.pollForm.submitted = true;
          }
        };
        $scope.addAnswer = function(){
          $scope.poll.answers_attributes.push({title: ''});
        };

        $scope.removeAnswer = function(index){
          $scope.poll.answers_attributes.splice(index,1);
        };
      }];

      $scope.modalInstance = $modal.open({
        templateUrl: 'polls_form.html',
        controller: PollFormCtrl,
        // backdrop: 'static'
      });
    };


  }]);
