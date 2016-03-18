/**
 * @module supervisionNotificationController
 * @class supervisionNotificationController
 *
 * Notifications for supervision are dealt with here.
 */

angular.module('chemGeno')
.controller('supervisionNotificationController', ['$scope', '$stateParams', 'viewService', '$q', 'verificationService', '$state',
function($scope, $stateParams, viewService, $q, verificationService, $state) {

  /**
   * Loads the data upon entry of this controller from the services which gets the object desired from the backend
   * of the application :)
   *
   * @method loadData
   */
  $scope.loadData = function() {
    var promises = {
      supervisorPromise: viewService.getPerson($stateParams.supervisorId),
      supervisedPromies: viewService.getPerson($stateParams.supervisedId)
    }
    $q.all(promises).then(function(values) {
      $scope.supervisor = values.supervisorPromise.data;
      $scope.supervised = values.supervisedPromies.data;
    });
  }

  //This method is called when this controller first invoked at all by the application.
  $scope.loadData();

  /**
   * Verifies the supervision notification.
   *
   * @method verifySupervision
   */
  $scope.verifySupervision = function() {
    var paramObj = {supervision: $stateParams.supervisionId};
    var promise = verificationService.verifyInfo(paramObj);
    promise.then(function(resp) {
      console.log(resp);
      $state.go('main.admin');
    }, function(error){
      alert(error);
    });
  };

  /**
   * Rejects the supervision notification
   *
   * @method rejectSupervision
   */
  $scope.rejectSupervision = function() {
    var paramObj = {supervision: $stateParams.supervisionId};
    var promise = verificationService.deleteInfo(paramObj);
    promise.then(function(resp) {
      console.log(resp);
      $state.go('main.admin');
    }, function(error){
      alert(error);
    });
  };
  // ui booleans for mentor info
  $scope.supervisor_mentorVisibility = false;
  $scope.supervisor_mentoredVisibility = false;
  $scope.supervisor_supervisedVisibility = false;
  $scope.supervisor_supervisorVisibility = false;
  // ui booleans for mentee info
  $scope.supervised_mentorVisibility = false;
  $scope.supervised_mentoredVisibility = false;
  $scope.supervised_supervisedVisibility = false;
  $scope.supervised_supervisorVisibility = false;
}]);
