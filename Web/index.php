<!DOCTYPE html>
<html ng-app="twilioApp">
<head>
    <title>Twilio</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link href="css/fontawesome/font-awesome.min.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />

</head>
<body>
    <header class="navbar navbar-static-top" id="top" role="banner" ng-controller="headerCtrl">
        <div class="row full-width">
            <div class="col-xs-12">
                <div class="navbar-header">
                    <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".bs-navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <i class="fa fa-bars"></i>
                    </button>
                    <a href="javascript:void(0);" class="navbar-brand">
                        Owl Air
                    </a>
                </div>
                <nav class="collapse navbar-collapse bs-navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li ng-repeat="user in activeUser">
                            <a href="javascript:void(0)" ng-class="{'action': user.active ==1}">
                                <i class="fa fa-comment margin-r-5" ng-if="user.status == 'chat'"></i>
								<i class="fa fa-comment margin-r-5" ng-if="user.status == 'end' && user.active == 0"></i>
                                <i class="fa fa-phone margin-r-5" ng-if="user.status == 'call'"></i>
                                <i class="fa fa-times margin-r-5 cursor" ng-if="user.status == 'end' && user.active == 1" ng-click="reomveUser(user)"></i>
                                <span class="badge">{{user.count}}</span>
                                {{user.name}}
                            </a>
                        </li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <img class="avatar" ng-src="{{agent.avatar}}" />
                        </li>
                        <li>
                            <div class="user-name" id="agent_name">{{agent.name}}</div>
                        </li>
                        <li id="setting">
                            <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-cogs"></i>
                            </a>
                            <ul class="dropdown-menu" id="userlist">
                                <li ng-repeat="user in userList | filter : {mobile: 1}">
                                    <a href="javascript:void(0);" ng-click="selectUser(user)" ng-class="{'active': user.name == selectUserName}">
                                        {{user.name}}
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </header>
    <section>
        <div ng-view autoscroll="true"></div>
    </section>

    <!-- Model -->
    <script type="text/ng-template" id="callingWindow.html">
        <div class="modal-content" id="callingWindow">
            <div class="modal-header modal-top">
                <div class="label label-warning premiere pull-right">{{user.accountStatus}}</div>
                <div class="clearfix"></div>
                <h4 class="modal-title"><span class="modalh4">Incoming Call...</span> </h4>
            </div>
            <div class="modal-body">
                <img class="avatar" ng-src="{{user.avatar}}"/>
                <div class="name agent-name">{{user.name}}</div>
                <div class="ac-no">Account Number: {{user.accountNumber}}</div>
                <div class="phone-no">Phone Number: {{user.phoneNumber}}</div>
            </div>
            <div class="modal-footer modal-foot">
                <a href="javascript:void(0);" ng-click="ok()" class="btn btn-default btn-change" id="call-con">
                    <i class="fa fa-phone fa-2x white"></i>
                </a>
                <a href="javascript:void(0);" ng-click="cancel()" class="btn btn-primary btn-callend" id="calling-window-endcall">
                    <i class="fa fa-phone fa-2x phonecall"></i>
                </a>
            </div>
        </div>
    </script>

    <script type="text/ng-template" id="flightSearchWindow.html">
        <div class="modal-content" id="flightSearchWindow">
            <div class="modal-header modal-head ">
                <button type="button" class="close" ng-click="cancel()" aria-hidden="true">
                    <i class="fa fa-times"></i>
                </button>
                <h4 class="modal-title">
                    <span class="modaltitle tite-size">Change Flight</span>
                </h4>
            </div>
            <div class="modal-body bodycontent">
                <form class="form-inline" role="form">
                    <div class="row">
                        <div class="col-xs-12 radio">
                            <label><input type="radio" name="trip" ng-model="searchFrom.trip" value="Round trip"> Round trip</label>
                            <label><input type="radio" name="trip" ng-model="searchFrom.trip" value="One Way"> One Way</label>
                        </div>
                    </div>
                    <div class="row margin-top-20">
                        <div class="form-group col-xs-12 col-sm-6 col-md-4 col-lg-2 padding-lr-10">
                            <input type="text" class="form-control inputinfo full-width" id="from" ng-model="searchFrom.from" placeholder="">
                            <div class="margin-top-10">
                                <span>{{serachFrom.fromFull}}</span>
                            </div>
                        </div>
                        <div class="form-group col-xs-12 col-sm-6 col-md-4 col-lg-2 padding-lr-10">
                            <input type="text" class="form-control inputinfo full-width" id="to" ng-model="searchFrom.to" placeholder="">
                            <div class="margin-top-10">
                                <span>{{serachFrom.toFull}}</span>
                            </div>
                        </div>
                        <div class="form-group col-xs-12 col-sm-6 col-md-4 col-lg-2 padding-lr-10">
                            <div class="input-group controls input-append date form_date full-width">
                                <input type="text" class="form-control inputinfo right-border-none" id="win-startDate" name="startDate" datepicker-popup="dd/MM" ng-model="searchFrom.startDate" is-open="s_date_opened" />
                                <span class="input-group-addon input-icon-color">
                                    <span class="glyphicon glyphicon-calendar" ng-click="s_date_opened= true"></span>
                                </span>
                            </div>
                            <div class="margin-top-10">
                                <span>Depart <span class="today-f4-p2">{{serachFrom.startDate | date : "EEE, MMMM dd yyyy"}}</span></span>
                            </div>
                        </div>
                        <div class="form-group col-xs-12 col-sm-6 col-md-4 col-lg-2 padding-lr-10">
                            <div class="input-group controls input-append date form_date full-width">
                                <input type="text" class="form-control inputinfo right-border-none" name="endtDate" datepicker-popup="dd/MM" ng-model="searchFrom.entDate" is-open="e_date_opened" />
                                <span class="input-group-addon input-icon-color">
                                    <span class="glyphicon glyphicon-calendar" ng-click="e_date_opened = true"></span>
                                </span>
                            </div>
                            <div class="margin-top-10">
                                <span>Return date <span class="today-f4-p2">{{searchFrom.entDate | date : "EEE, MMMM dd yyyy"}}</span></span>
                            </div>
                        </div>
                        <div class="form-group col-xs-12 col-sm-6 col-md-4 col-lg-2 padding-lr-10">
                            <div class='input-group date full-width'>
                                <input type='text' class="form-control inputinfo right-border-none" name="adults" ng-model="searchFrom.adults" />
                                <span class="input-group-addon input-icon-color">
                                    <i class="fa fa-user"></i>
                                </span>
                            </div>
                            <div class="margin-top-10">
                                <span>Adults</span>
                            </div>
                        </div>
                        <div class="form-group col-xs-12 col-sm-6 col-md-4 col-lg-2 padding-lr-10">
                            <div class='input-group date full-width'>
                                <input type='text' class="form-control inputinfo right-border-none" name="children" ng-model="searchFrom.children" />
                                <span class="input-group-addon input-icon-color">
                                    <i class="fa fa-user"></i>
                                </span>
                            </div>
                            <div class="margin-top-10 font14">
                                <span>Children</span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 alignbox">
                            <button type="button" class="btn btn-default searchbtn goto-confirm-window" ng-click="ok()" id="serach">Search</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </script>

    <script type="text/ng-template" id="findFlightWindow.html">
        <div class="modal-content">
            <div class="modal-header modal-head ">
                <button type="button" class="close"  ng-click="cancel()" aria-hidden="true"><i class="fa fa-times"></i></button>
                <h4 class="modal-title">
                    <span class="modaltitle tite-size">Confirm</span>
                </h4>
                <div class="pull-left back">
                    <a href="javascript:void(0);" ng-click="back()" id="flight-details-back" class="goto-change-flight-window white">
                        <i class="fa fa-angle-left"></i>
                        Back
                    </a>
                </div>
            </div>
            <div class="modal-body bodycontent">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="flight-trip-details col-xs-12">
                            <div class="pull-left">
                                <div class="flight-name">
                                    {{searchFrom.from}} <i class="fa fa-long-arrow-right gray"></i> {{searchFrom.to}}
                                </div>
                            </div>
                            <div class="pull-left trip-details" id="flight-date">
                                to
                            </div>
                            <div class="pull-left trip-details" id=" flight-cabin">
                                Economy Cabin
                            </div>
                            <div class="pull-left trip-details" id="flight-traveler">
                                1 traveler
                            </div>
                            <div class="pull-left trip-details" id="flight-trip">
                                {{searchFrom.trip}}
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12 align">
                        <ul class="nav nav-tabs" role="tablist" id="calendar">
                            <li role="presentation" class="width-5p">
                                <a href="javascript:void(0);" id="previous" role="tab">
                                    <i class="fa fa-chevron-left"></i>
                                </a>
                            </li>
                            <li role="presentation" ng-repeat="cal in calendar" ng-class="{'active': cal.active}">
                                <a href="javascript:void(0);" data-target="#flight-list-tab" aria-controls="flight-list-tab" role="tab" data-toggle="tab">
                                    <span class="month">{{cal.date | date : "MMM"}}</span>
                                    <span class="date">{{cal.date | date : "dd"}}</span>
                                    <span class="rate">{{cal.amount | currency}}</span>
                                </a>
                            </li>
                            <li role="presentation" class="width-5p">
                                <a href="javascript:void(0);" id="next" role="tab">
                                    <i class="fa fa-chevron-right"></i>
                                </a>
                            </li>
                        </ul>

                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="flight-list-tab">
                                <div class="col-xs-12 padding-10-30">
                                    <div class="col-xs-4">
                                        <span class="pull-left">sort by : </span>
                                        <div class="dropdown pull-left">
                                            <button class="dropdown-toggle" type="button" id="order-by-flight" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                <span ng-if="!orderRevers">Price (low to high)</span>
                                                <span ng-if="orderRevers">Price (high to low)</span>
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu" aria-labelledby="order-by-flight">
                                                <li><a href="javascript:void(0);" ng-click="orderRevers=false">Price (low to high)</a></li>
                                                <li><a href="javascript:void(0);" ng-click="orderRevers=true">Price (high to low)</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-xs-4 text-center">
                                        {{flights.length}} of {{flightList.length}} fights
                                    </div>
                                    <div class="col-xs-4 text-right">
                                        {{searchFrom.trip}} trip
                                    </div>
                                </div>
                                <div class="col-xs-12">
                                    <div class="table-responsive" id="flight-table">
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Flight #</th>
                                                    <th>Depart</th>
                                                    <th>Arrive</th>
                                                    <th>Routing</th>
                                                    <th>Travel time</th>
                                                    <th>Price</th>
                                                    <th>Type</th>
                                                    <th>Select</th>
                                                </tr>
                                            </thead>

                                            <tr ng-repeat="flight in flights = (flightList | orderBy : 'price' : orderRevers)">
                                                <td class="">{{flight.flightNumber}}</td>
                                                <td class="">{{flight.depart}}</td>
                                                <td class="">{{flight.arrive}}</td>
                                                <td class="">{{flight.routing}}</td>
                                                <td class="">{{flight.travelTime}}</td>
                                                <td class="text-bold">{{flight.price | currency}}</td>
                                                <td class="">{{flight.type | currency}}</td>
                                                <td class=""><button type="button" ng-click="ok(flight)" class="btn btn-default btn-xs btn-color goto-flight-details-window">Select</button></td>
                                                <td></td>
                                            </tr>

                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </script>
    <script type="text/ng-template" id="flightDetails.html">
        <div class="modal-content">
            <div class="modal-header modal-head ">
                <button type="button" class="close" ng-click="cancel()" aria-hidden="true"><i class="fa fa-times"></i></button>
                <h4 class="modal-title">
                    <span class="modaltitle tite-size">Confirm</span>
                </h4>
                <div class="pull-left back">
                    <a href="javascript:void(0);" ng-click="back()" class="goto-confirm-window " id="flight-details-back white">
                        <i class="fa fa-angle-left"></i>
                        Back
                    </a>
                </div>
            </div>
            <div class="modal-body bodycontent">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="col-xs-8 col-sm-offset-2 win-flight-box">
                            <div class="col-xs-12">
                                <div class="col-xs-6 title">
                                    Owl Air
                                </div>
                                <div class="col-xs-6">
                                    <div class="pull-right">
                                        <div class="light-title">GATE</div>
                                        <div class="text-right font-14">{{user.flight.gate}}</div>
                                    </div>
                                    <div class="pull-right">
                                        <div class="light-title">FLIGHT</div>
                                        <div class="text-right font-14">{{user.flight.number}}</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12">
                                <div class="col-xs-5">
                                    <div class="light-title">{{user.flight.from}}</div>
                                    <div class="font-35">{{user.flight.fromShort}}</div>
                                </div>
                                <div class="col-xs-2">
                                    <div class="plane-icon">
                                        <i class="fa fa-plane fa-rotate-45"></i>
                                    </div>
                                </div>
                                <div class="col-xs-5">
                                    <div class="light-title text-right">{{user.flight.to}}</div>
                                    <div class="font-35 text-right">{{user.flight.toShort}}</div>
                                </div>
                            </div>
                            <div class="col-xs-12">
                                <div class="col-xs-6">
                                    <div class="light-title">Departure</div>
                                    <div class="font-18 today-f1-p2">{{user.flight.departure | date : 'EEE, MMM dd'}}</div>
                                </div>
                                <div class="col-xs-6">
                                    <div class="light-title text-right">arrival</div>
                                    <div class="font-18 text-right today-f1-p2">{{user.flight.arrival | date : 'EEE, MMM dd'}}</div>
                                </div>
                            </div>
                            <div class="col-xs-12">
                                <div class="col-xs-3">
                                    <div class="light-title">boards</div>
                                    <div class="font-14">{{user.flight.boards}}</div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="light-title">departs</div>
                                    <div class="font-14">{{user.flight.departs}}</div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="light-title text-right">group</div>
                                    <div class="font-14 text-right">{{user.flight.group}}</div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="light-title text-right">position</div>
                                    <div class="font-18 text-right">{{user.flight.position}}</div>
                                </div>
                            </div>
                            <div class="col-xs-12">
                                <div class="col-xs-6">
                                    <div class="light-title">Passenger</div>
                                    <div class="font-14 agent-name">{{user.name}}</div>
                                </div>
                                <div class="col-xs-6">
                                    <div class="light-title text-right">Passenger</div>
                                    <div class="font-14 text-right">{{user.flight.passenger}}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12 user-confrim">
                        <span>Do you wish to send this card to <span class="agent-name">{{user.name}}</span>?</span>
                    </div>

                </div>
                <div class="row">
                    <div class="col-xs-12 alignbox">
                        <button type="button" ng-click="ok()" class="btn btn-default searchbtn disable goto-verify-passenger-window margin-top-15" id="verify">Confirm & Send</button>
                    </div>
                </div>
            </div>
        </div>
    </script>

    <script type="text/ng-template" id="touchId.html">
        <div class="modal-dialog modelbox">
            <div class="modal-content">
                <div class="modal-header modal-head ">
                    <button type="button" class="close" ng-click="ok()" aria-hidden="true"><i class="fa fa-times"></i></button>
                    <h4 class="modal-title">
                        <span class="modaltitle tite-size">Confirm</span>
                    </h4>
                    <div class="pull-left back">
                        <a href="javascript:void(0);" ng-click="back()" id="flight-details-back" class="goto-verify-passenger-window white">
                            <i class="fa fa-angle-left"></i>
                            Back
                        </a>
                    </div>
                </div>
                <div class="modal-body bodycontent">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="tickicon">
                                <i class="fa fa-check"></i>
                            </div>
                            <div class="col-xs-12 flightconfirmation">
                                <span>Verified</span>
                            </div>

                            <div class="col-xs-12 passenger">
                                <span>Verified Passenger Touch ID</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 alignbox">
                                <button type="button" ng-click="ok()" class="btn btn-default searchbtn goto-verified-window" id="finished">Ok</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </script>

    <script type="text/ng-template" id="verifiedDOB.html">
        <div class="modal-dialog modelbox">
            <div class="modal-content">
                <div class="modal-header modal-head ">
                    <button type="button" class="close" ng-click="cancel()" aria-hidden="true"><i class="fa fa-times"></i></button>
                    <h4 class="modal-title">
                        <span class="modaltitle tite-size">Confirm</span>
                    </h4>
                    <div class="pull-left back">
                        <a href="javascript:void(0);" ng-click="back()" id="flight-details-back" class="goto-flight-details-window white">
                            <i class="fa fa-angle-left"></i>
                            Back
                        </a>
                    </div>
                </div>
                <div class="modal-body bodycontent">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="tickicon">
                                <i class="fa fa-check"></i>
                            </div>
                            <div class="col-xs-12 flightconfirmation">
                                <span>Flight confirmed</span>
                            </div>

                            <div class="col-xs-12 passenger">
                                <span>Verified Passenger Date of Birth</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 alignbox">
                                <button type="button" ng-click="ok()" class="btn btn-default searchbtn goto-verified-window">Ok</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </script>

        <script type="text/ng-template" id="verified.html">
            <div class="modal-dialog modelbox">
                <div class="modal-content">
                    <div class="modal-header modal-head ">
                        <button type="button" class="close" ng-click="cancel()" aria-hidden="true"><i class="fa fa-times"></i></button>
                        <h4 class="modal-title">
                            <span class="modaltitle tite-size">Complete</span>
                        </h4>
                        <div class="pull-left back">
                            <a href="javascript:void(0);" ng-click="back()" id="flight-details-back" class="goto-nexttuch-window white">
                                <i class="fa fa-angle-left"></i>
                                Back
                            </a>
                        </div>
                    </div>
                    <div class="modal-body bodycontent">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="tickicon">
                                    <i class="fa fa-check"></i>
                                </div>
                                <div class="col-xs-12 flightconfirmation">
                                    <span>Verified</span>
                                </div>
                                <div class="col-xs-12 ask-help">
                                    <span>Ask: Is there anything else i can help you with ?</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12 alignbox">
                                    <button type="button" ng-click="ok()" class="btn btn-default searchbtn" id="verified-finished">Finish</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </script>

        
 <?php
                require_once('lib/Services/Twilio.php');

                $accountSid = "ACCOUNT_SID_HERE";
                $signingKeySid = "SIGNING_KEY_HERE";
                $signingKeySecret = "SIGNING_SECRET_HERE";
                $configurationProfileSid = "PROFILE_SID_HERE";

                $token = new Services_Twilio_AccessToken($accountSid,$signingKeySid,$signingKeySecret,$ttl=3600,$identity="Agent".time());

        // Grant access to Conversations
        $grant = new Services_Twilio_Auth_ConversationsGrant();
        $grant->setConfigurationProfileSid($configurationProfileSid);
        $token->addGrant($grant);

// Serialize the token as a JWT
        $accessToken =  $token->toJWT();

              #  $token = new Services_Twilio_AccessToken($signingKeySid, $accountSid, $signingKeySecret);
              #  $token->addEndpointGrant("Agent".time());
              #  $token->enableNTS();
              #  $accessToken =  $token->toJWT();
            ?>

				
        <input type="hidden" id="access-token" value="<?php echo $accessToken; ?>" />
        <div id="remote-media"></div>
        <div id="local-media"></div>


        <script src="scripts/jquery/jquery-2.1.4.min.js"></script>
        <script src="scripts/bootstrap/bootstrap.min.js"></script>
        <script src="scripts/angular/angular.min.js"></script>
        <script src="scripts/angular/angular-route.min.js"></script>
        <script src="scripts/angular/ui-bootstrap-tpls-0.13.4.min.js"></script>

        <script src='scripts/firebase/firebase.js'></script>
        <script src="scripts/angular/angularfire.min.js"></script>
		<script src="scripts/twilio/twilio-common.js"></script>
        <script src="scripts/twilio/twilio-conversations.js"></script>
		

        <script src="scripts/app/controllers.js"></script>
        <script src="scripts/app/service.js"></script>
        <script src="scripts/app/app.js"></script>
</body>
</html>
