var controllers = angular.module('twilioAppControllers', []);
controllers.config(['$httpProvider', function ($httpProvider) {
    $httpProvider.interceptors.push(function ($q) {
        var loadingCount = 0;
        return {
            'request': function (config) {
                loadingCount++;
                return config;
            },

            'response': function (response) {
                if (!(--loadingCount)) {
                }
                return response;
            },
            'responseError': function (response) {
                if (!(--loadingCount)) {
                }
            }
        };
    });
}]);

controllers.controller('headerCtrl', ['$scope', '$http', '$rootScope', '$timeout', '$window', 'CommonService', function ($scope, $http, $rootScope, $timeout, $window, commonService) {

    $scope.agent = $rootScope.agent;
    $scope.activeUser = $rootScope.activeUser;
	$scope.selectUserName = "";
    $scope.userList = commonService.getUsers();

    $scope.selectUser = function (user) {
		if($scope.selectUserName != user.name){
			commonService.queueDestroy();   
			$scope.selectUserName = user.name;
			$scope.Queues = commonService.getQueue(user);
		}
    }


    $scope.reomveUser = function (user) {
        $rootScope.activeUser.splice(($rootScope.activeUser.length - 1), 1);
        $rootScope.activeUser[$rootScope.activeUser.length - 1].active = 1;
        $(".calling-list").hide();
        $(".chat-list").slideDown();
        $(".navbar-nav a").first().addClass("action");
    }
}]);

controllers.controller('HomeCtrl', ['$scope', '$rootScope', '$http', '$timeout', '$window', 'CommonService', function ($scope, $rootScope, $http, $timeout, $window, commonService) {
    $scope.tickets = $rootScope.tickets;

    $scope.openCall = function () {

    }

    Date.prototype.addDays = function (days) {
        this.setDate(this.getDate() + parseInt(days));
        return this;
    };

}]);


controllers.controller('page2Ctrl', ['$scope', '$rootScope', '$http', '$timeout', '$window', 'CommonService', function ($scope, $rootScope, $http, $timeout, $window, commonService) {

    $scope.user = $rootScope.user;
    $scope.user.flight.departure = new Date();
    $scope.user.flight.arrival = new Date();

    commonService.conversationStart();

    $scope.callMuted = function () {
        commonService.callMuted();
    }

    $scope.disconnect = function () {
        //commonService.disconnect();
        commonService.setState(8);
    }

    $scope.openFlightSerach = function () {
        commonService.setState(3);
    }

    function setsidescroll() {
        if ($(window).width() >= 975) {
            var leftHeight = $(window).height() - ($("header").height() + 1);
            var rightHeight = $("#right").height()
            if (leftHeight < rightHeight)
                leftHeight = rightHeight;
            $("#left").css('min-height', leftHeight + 'px');

        } else {
            $("#left").css('min-height', '100%');
        }

    }

    $timeout(function () {
        setsidescroll();
        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            setsidescroll();
        })

        $(window).resize(function () {
            setsidescroll();
        });
    }, 0);


}]);
// Model Controllers
controllers.controller('CallingWindowInstanceCtrl', function ($scope, $timeout, $rootScope, $modalInstance, user, CommonService) {

    $scope.user = user;

    $timeout(function () {
        CommonService.centerModals();
    }, 0);

    $scope.ok = function () {
        $.each($rootScope.activeUser, function (index, user) {
            user.active = 0;
        })
        $rootScope.activeUser.push({
            name: user.name,
            count: 2,
            status: "call",
            active: 1
        });
        $modalInstance.close();
        if (location.hash == "#/page2") {
            $scope.user = $rootScope.user;
            $scope.user.flight.departure = new Date();
            $scope.user.flight.arrival = new Date();

            CommonService.conversationStart();
        } else {
            location.href = "#/page2"
        }


    };

    $scope.cancel = function () {
        $rootScope.callActive = false;
        $modalInstance.dismiss('cancel');
    };
});
controllers.controller('FlightSearchWindowInstanceCtrl', function ($scope, $rootScope, $timeout, $modalInstance, searchFrom, CommonService) {

    $scope.searchFrom = searchFrom;

    $timeout(function () {
        CommonService.centerModals();
    }, 0);

    $scope.ok = function () {
        var startDate = new Date();
        startDate.setDate(startDate.getDate() + 2);
        $scope.searchFrom.startDate = startDate;
        var endDate = new Date();
        endDate.setDate(endDate.getDate() + 2);
        $scope.searchFrom.endDate = endDate;
        $modalInstance.close($scope.searchFrom);
    };

    $scope.cancel = function () {
        CommonService.setState(2);
        $("body").removeClass("model-ative");
        $modalInstance.dismiss('cancel');
    };
});

controllers.controller('FindFlightWindowInstanceCtrl', function ($scope, $rootScope, $timeout, $modalInstance, searchForm, CommonService) {

    $scope.searchFrom = searchForm;

    $timeout(function () {
        CommonService.centerModals();
    }, 0);

    //$scope.searchFrom.startDate = new Date($scope.searchFrom.startDate);
    //$scope.searchFrom.endDate = new Date($scope.searchFrom.endDate);
    $scope.calendar = [{
        date: new Date(), amount: 350, active: false
    }, {
        date: new Date(), amount: 356, active: false
    }, {
        date: new Date(), amount: 411, active: false
    }, {
        date: new Date(), amount: 456, active: false
    }, {
        date: new Date(), amount: 456, active: true
    }, {
        date: new Date(), amount: 456, active: false
    }, {
        date: new Date(), amount: 456, active: false
    }, {
        date: new Date(), amount: 420, active: false
    }, {
        date: new Date(), amount: 480, active: false
    }];
    var j = -2;
    for (var i = 0; i < 9; i++, j++) {
        var today = new Date();
        today.setDate(today.getDate() + j);
        $scope.calendar[i].date = today;
    }

    $scope.orderRevers = false;
    $scope.flightList = [{
        flightNumber: 947,
        boards: "3.30 PM",
        depart: "4:00 PM",
        arrive: "8.30 PM",
        routing: "0 stop",
        travelTime: "6h 00min",
        price: 456,
        type: "Economy"
    }, {
        flightNumber: 943,
        boards: "3.00 PM",
        depart: "3:00 PM",
        arrive: "9.30 PM",
        routing: "0 stop",
        travelTime: "5h 30min",
        price: 480,
        type: "Economy"
    }]


    $scope.back = function () {
        CommonService.openFlightSearchWindow(searchForm);
        $modalInstance.close();
    }

    $scope.ok = function (flight) {
        $modalInstance.close(flight);
    };

    $scope.cancel = function () {
        CommonService.setState(2);
        $("body").removeClass("model-ative");
        $modalInstance.dismiss('cancel');
    };
});

controllers.controller('FlightDetailsWindowInstanceCtrl', function ($scope, $rootScope, $timeout, $modalInstance, searchForm, flight, CommonService) {

    $scope.user = $rootScope.user;
    $scope.user.flight.number = flight.flightNumber;
    $scope.user.flight.fromShort = searchForm.from;
    $scope.user.flight.toShort = searchForm.to;
    $scope.user.flight.departs = flight.depart;
    $scope.user.flight.boards = flight.boards;
    $scope.user.flight.departure = searchForm.startDate;
    $scope.user.flight.arrival = searchForm.endDate;

    $timeout(function () {
        CommonService.centerModals();
    }, 0);

    $scope.back = function () {
        CommonService.openFindFlightWindow(searchForm);
        $modalInstance.close();
    }

    $scope.ok = function () {
        $("body").removeClass("model-ative");
        CommonService.setState(4);
        $modalInstance.close();
    };

    $scope.cancel = function () {
        CommonService.setState(2);
        $("body").removeClass("model-ative");
        $modalInstance.dismiss('cancel');
    };
});

controllers.controller('TouchIdWindowInstanceCtrl', function ($scope, $rootScope, $timeout, $modalInstance, CommonService) {

    $timeout(function () {
        CommonService.centerModals();
    }, 0);

    $scope.back = function () {
        CommonService.setState(3);
        $modalInstance.close();
    }

    $scope.ok = function () {
        CommonService.openVerifiedWindow();
        $modalInstance.close();
    };

    $scope.cancel = function () {
        CommonService.setState(2);
        $("body").removeClass("model-ative");
        $modalInstance.dismiss('cancel');
    };
});

controllers.controller('VerifiedDOBWindowInstanceCtrl', function ($scope, $rootScope, $timeout, $modalInstance, CommonService) {

    $timeout(function () {
        CommonService.centerModals();
    }, 0);

    $scope.back = function () {
        CommonService.setState(3);
        $modalInstance.close();
    }

    $scope.ok = function () {
        CommonService.openVerifiedWindow();
        $modalInstance.close();
    };

    $scope.cancel = function () {
        CommonService.setState(2);
        $("body").removeClass("model-ative");
        $modalInstance.dismiss('cancel');
    };
});

controllers.controller('VerifiedWindowInstanceCtrl', function ($scope, $rootScope, $timeout, $modalInstance, CommonService) {

    $timeout(function () {
        CommonService.centerModals();
    }, 0);

    $scope.back = function () {
        if ($rootScope.currentState == 5)
            CommonService.openTouchIDWindow();
        else if ($rootScope.currentState == 6)
            CommonService.openVerifiedDOBWindow();
        $modalInstance.close();
    }

    $scope.ok = function () {
        $("body").removeClass("model-ative");
        $modalInstance.close();
    };

    $scope.cancel = function () {
        CommonService.setState(2);
        $("body").removeClass("model-ative");
        $modalInstance.dismiss('cancel');
    };
});
