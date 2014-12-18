'use strict';

angular.module('voteMe')
  .controller('PollsDetailCtrl', function ($scope, $rootScope, Poll, $routeParams, $location) {
    $scope.selectedAnswers = [];
    $scope.max = 0;
    Poll.get({id: $routeParams.id}, function(data){
      $scope.poll = data;
      setMax();
    }, function(error){
      console.warn(error)
    });

    function setMax(){
      if ($scope.poll.user_voted) {
        for(var i=0;i<$scope.poll.voting_results.length;i++){
          $scope.max += $scope.poll.voting_results[i][1];
        }
      }
    }

    $scope.toggleSelection = function (answerId) {
      var answerIndex = $scope.selectedAnswers.indexOf(answerId);
      if( answerIndex > -1) {
        $scope.selectedAnswers.splice(answerIndex, 1);
      }else{
        $scope.selectedAnswers.push(answerId);
      }
    };

    $scope.destroyPoll = function(){
      $scope.poll.$remove(function(data){
        $location.path('/');
      }, function(error){
        console.warn(error);
      });
    };

    $scope.checkDisabled = function(){
      if (!$scope.selectedAnswers.length) {
        return true;
      }
      return false;
    };

    $scope.vote = function(){
      $scope.poll.$update({'answer_ids[]': $scope.selectedAnswers}, function(data){
        setMax();
      }, function(error){
        console.warn(error);
      });
    };

    $scope.calculatePercentage = function(index) {
      return ($scope.poll.voting_results[index][1]/$scope.max * 100).toFixed(2);
    };

    $scope.showAnswerTitle = function(id) {
      for(var i=0;i<$scope.poll.answers.length;i++){
        var answer = $scope.poll.answers[i];
        if (id == answer.id) {
          return answer.title;
        }
      }
    };
  });
