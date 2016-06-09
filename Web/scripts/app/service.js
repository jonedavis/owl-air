'use strict';
(function () {
    var injectParams = ['$http', '$q', '$location', '$window', '$rootScope', '$firebaseObject', '$firebaseArray', '$modal'];
    var twilioAppServices = angular.module('twilioAppServices', []);
    var commonFactory = function ($http, $q, $location, $window, $rootScope, $firebaseObject, $firebaseArray, $modal) {
        var serviceFactory = {};

        // common Functions
        serviceFactory.openCallingWindow = function (_user) {
            var user = $rootScope.user;
            user.name = _user.name;
            user.userName = _user.login;
            user.email = _user.login + "@mail.com";
            user.avatar = _user.profileimage;
            user.endpoint = _user.endpoint;
            $modal.open({
                animation: true,
                templateUrl: 'callingWindow.html',
                controller: 'CallingWindowInstanceCtrl',
                size: null,
                windowClass: "calling-window",
                resolve: {
                    user: function () {
                        return user;
                    }
                }
            });
        }

        serviceFactory.openFlightSearchWindow = function (searchFrom) {
            var flightSearchWindow = $modal.open({
                animation: true,
                templateUrl: 'flightSearchWindow.html',
                controller: 'FlightSearchWindowInstanceCtrl',
                size: 'lg',
                windowClass: "flight-search-window",
                resolve: {
                    searchFrom: function () {
                        return searchFrom;
                    }
                }
            });

            flightSearchWindow.result.then(function (searchForm) {
                serviceFactory.openFindFlightWindow(searchForm);
            });
        }

        serviceFactory.openFindFlightWindow = function (searchForm) {
            var findFlightWindow = $modal.open({
                animation: true,
                templateUrl: 'findFlightWindow.html',
                controller: 'FindFlightWindowInstanceCtrl',
                size: 'lg',
                windowClass: "find-flight-window",
                resolve: {
                    searchForm: function () {
                        return searchForm;
                    }
                }
            });
            findFlightWindow.result.then(function (flight) {
                serviceFactory.openFlightDetailWindow(flight, searchForm);
            });
        }

        serviceFactory.openFlightDetailWindow = function (flight, searchForm) {
            $modal.open({
                animation: true,
                templateUrl: 'flightDetails.html',
                controller: 'FlightDetailsWindowInstanceCtrl',
                size: null,
                windowClass: "flight-details-window",
                resolve: {
                    flight: function () {
                        return flight;
                    },
                    searchForm: function () {
                        return searchForm;
                    }
                }
            });
        }

        serviceFactory.openTouchIDWindow = function () {
            $modal.open({
                animation: true,
                templateUrl: 'touchId.html',
                controller: 'TouchIdWindowInstanceCtrl',
                size: null,
                windowClass: "touch-Id-window"
            });
        }

        serviceFactory.openVerifiedDOBWindow = function () {
            $modal.open({
                animation: true,
                templateUrl: 'verifiedDOB.html',
                controller: 'VerifiedDOBWindowInstanceCtrl',
                size: null,
                windowClass: "verified-dob-window"
            });
        }

        serviceFactory.openVerifiedWindow = function () {
            $modal.open({
                animation: true,
                templateUrl: 'verified.html',
                controller: 'VerifiedWindowInstanceCtrl',
                size: null,
                windowClass: "verified-window"
            });
        }

        serviceFactory.centerModals = function () {
            centerModals();
        }

        function centerModals() {
            $('.modal').each(function (i) {
                var $clone = $(this).clone().css('display', 'block').appendTo('body');
                var top = Math.round(($clone.height() - $clone.find('.modal-content').height()) / 2);
                top = top > 0 ? top : 0;
                $clone.remove();
                $(this).find('.modal-content').css("margin-top", top);
            });
        }

        // $('.modal').on('show.bs.modal', centerModals);
        $(window).on('resize', centerModals);


        /* Twilio */

        var endpoint;
        var activeConversation;
        var endpointAddress;
        var userAgent;
        var timeInterval;

        if (!navigator.webkitGetUserMedia && !navigator.mozGetUserMedia) {
            alert('WebRTC is not available in your browser.');
        }

        function endpointConnected() {
            log("Connected to Twilio. Listening as '" + endpoint.identity + "'");
           /* setTimeout(function () {
                log("Twilio token is expired, so automatically page should be refersh and create new token")
                location.reload();
            }, endpoint.token.expires - Date.now()); */
        }

        function conversationStarted(conversation) {
            log('In an active Conversation');
            activeConversation = conversation;
            min = 0;
            sec = 0;
            timeInterval = setInterval(function () { timer() }, 1000);
            serviceFactory.setState(2);
            serviceFactory.stateWatch();
            conversation.on('participantConnected', function (participant) {
                log("Participant '" + participant.identity + "' connected");
                participant.media.attach('#remote-media');
            });

            conversation.on('participantDisconnected', function (participant) {
                log("Participant '" + participant.identity + "' disconnected");
				 disconnect();
            });

            conversation.on('ended', function (conversation) {
                log("conversation ended");
                disconnect();
            });
        }

        function disconnect() {
            if (activeConversation && $rootScope.callActive) {
                $rootScope.callActive = false;
                clearInterval(timeInterval);
                if (activeConversation.localMedia)
                    activeConversation.localMedia.stop();
                activeConversation.disconnect();
                activeConversation = null;
                log("Conversation disconnected");
            }
            $("#person-details").slideUp();
            $rootScope.$apply(function () {
                $rootScope.activeUser[$rootScope.activeUser.length - 1].status = 'end';
            });


        }

        function callMuted() {
            if (activeConversation && activeConversation.localMedia)
                if ($("#call-muted .fa").hasClass("fa-microphone-slash")) {
                    $("#call-muted .fa").removeClass("fa-microphone-slash").addClass("fa-microphone");
                    activeConversation.localMedia.muted = false;
                } else {
                    $("#call-muted .fa").removeClass("fa-microphone").addClass("fa-microphone-slash");
                    activeConversation.localMedia.muted = true;
                }
        }

        function log(message) {
            console.log(message);
        }

        function conversation(inviteTo) {
            window.accessToken = $("#access-token").val();
            if (accessToken) {
               var accessTokenManager = new Twilio.AccessManager(accessToken);
			    endpoint = new Twilio.Conversations.Client(accessTokenManager);
                endpoint.listen().then(
                    endpointConnected,
                    function (error) {
                        log('Could not connect to Twilio: ' + error.message);
                    }
                );
            }

            if (activeConversation) {
                activeConversation.invite(inviteTo);
            } else {
                log("inviting participant " + inviteTo)
                var myConstraints = { audio: true };
                endpoint.inviteToConversation(inviteTo, { localStreamConstraints: myConstraints }).then(
                conversationStarted,
                function (error) {
                    log('Unable to create conversation');
                    console.error('Unable to create conversation', error);
                });
            }
        }

        var min = 0;
        var sec = 0;

        function timer() {
            if ($rootScope.callActive) {
                sec++;
                if (sec % 60 == 0) {
                    min++;
                    sec = 0;
                }
                $("#call-timer").html((min > 9 ? "" + min : "0" + min) + ":" + (sec > 9 ? "" + sec : "0" + sec))
            }
        }



        /* firebase */
        var myDataRef = new Firebase('URL_HERE');
        var userListRef = myDataRef.child('names');
        var queueRef = null;
        var queuelist = null;
        var endpointRef = null;
        var stateObj = null;
        var QueueforAgentRef;

        serviceFactory.getUsers = function () {
            var array = $firebaseArray(userListRef);
            return array;
        }

        serviceFactory.queueDestroy = function () {
            if (queuelist)
                queuelist.$destroy();
        }

        serviceFactory.getQueue = function (user) {
            queueRef = userListRef.child(user.$id).child('queue');
            queuelist = $firebaseArray(queueRef);
            queuelist.$watch(function (event) {
                if (!$rootScope.callActive) {
                    $rootScope.callActive = true;
                    var queueItemRef = queueRef.child(event.key);
                    var queue = $firebaseObject(queueItemRef);
                    queue.$loaded().then(function () {
                        user.endpoint = queue.$value;
                        serviceFactory.openCallingWindow(user);
                        queue.$remove();
                    });
                }
            });
        }

        serviceFactory.conversationStart = function () {
            if ($rootScope.user.endpoint) {
                $("#call-timer").html("00:00");
                $("#person-details").show();
                $(".calling-list").show();
                $(".chat-list").hide();
                var endpointRef = myDataRef.child($rootScope.user.endpoint);
                var endpointObj = $firebaseObject(endpointRef);
                endpointObj.$loaded().then(function (data) {
                    conversation($rootScope.user.endpoint);
                    //serviceFactory.setState(2);
                    //serviceFactory.stateWatch();
                });
            }
        }

        serviceFactory.setState = function (val) {
            if ($rootScope.user.endpoint) {
                var endpointRef = myDataRef.child($rootScope.user.endpoint);
                var stateRef = endpointRef.child("state");
                var stateObj = $firebaseObject(stateRef);
                stateObj.$value = val;
                stateObj.$save();
            }
        }

        serviceFactory.getState = function () {
            if ($rootScope.user.endpoint) {
                var endpointRef = myDataRef.child($rootScope.user.endpoint);
                var stateRef = endpointRef.child("state");
                var stateObj = $firebaseObject(stateRef);
                stateObj.$loaded().then(function (data) {
                });
                return stateObj.$value;
            }
            return null;
        }

        serviceFactory.stateWatch = function () {
            if ($rootScope.user.endpoint) {
                if (stateObj)
                    stateObj.$destroy();
                var endpointRef = myDataRef.child($rootScope.user.endpoint);
                var stateRef = endpointRef.child('state');
                var stateObj = new $firebaseObject(stateRef);
                stateObj.$loaded().then(function (data) {
                });
                stateObj.$watch(function (event) {
                    if (event.key == "state") {
                        $rootScope.currentState = stateObj.$value;
                        switch (stateObj.$value) {
                            case 3:
                                //filght search
                                $("body").addClass("model-ative");
                                var startDate = new Date();
                                startDate.setDate(startDate.getDate() + 2);
                                var searchFrom = {
                                    trip: "One Way",
                                    from: "DAL",
                                    fromFull: "Dallas. TX-DAL",
                                    to: "LAS",
                                    toFull: "Las Vegas. NV-LAS",
                                    startDate: startDate,
                                    endDate: null,
                                    adults: "1",
                                    children: "0"
                                }
                                serviceFactory.openFlightSearchWindow(searchFrom);
                                break;
                            case 5:
                                $("body").addClass("model-ative");
                                serviceFactory.openTouchIDWindow();
                                break;
                            case 6:
                                $("body").addClass("model-ative");
                                serviceFactory.openVerifiedDOBWindow();
                                break;
                            case 7:
                                serviceFactory.setState(3);
                                break;
                        }
                    }
                });
            }
        }

        serviceFactory.callMuted = function () {
            callMuted();
        }

        serviceFactory.disconnect = function () {
            disconnect();
        }

        return serviceFactory;
    }
    commonFactory.$inject = injectParams;
    twilioAppServices.service('CommonService', commonFactory);



}());
