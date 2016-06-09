var twilioApp = angular.module('twilioApp', ['ngRoute', 'ui.bootstrap', 'firebase', 'twilioAppServices', 'twilioAppControllers']);
twilioApp.config(['$routeProvider', '$locationProvider', '$httpProvider',
    function ($routeProvider, $locationProvider, $httpProvider) {

        $routeProvider.when('/home', {
            templateUrl: 'templates/home.html',
            controller: 'HomeCtrl'
        })
        .when('/page2', {
            templateUrl: 'templates/page2.html',
            controller: 'page2Ctrl'
        })
        .otherwise({
            redirectTo: '/home'
        });
    }]);
twilioApp.run(function ($rootScope, $http) {
    $rootScope.agent = {
        avatar: "images/avatar.png",
        name: "Karen Fitzgerald"
    };

    $.ajax('data/user.json', { async: false })
    .success(function (response) {
        $rootScope.user = response;
    });

    $.ajax('data/tickets.json', { async: false })
    .success(function (response) {
        $rootScope.tickets = response;
    });

    $rootScope.callActive = false;

    $rootScope.activeUser = [
        {
            name: "Jenny Chen",
            count: 2,
            status: "chat",
            active: 0
        }, {
            name: "Diego Li",
            count: 2,
            status: "chat",
            active: 0
        }
    ]
})



