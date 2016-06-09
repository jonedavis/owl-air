<?php
require_once('lib/Services/Twilio.php');
$authorized = false;

if (isset($_GET['Authorization'])) {
    if (preg_match('/Basic\s+(.*)$/i', $_GET['Authorization'], $auth)) {
        list($authName, $authPassword) = explode(':', base64_decode($auth[1]));
		if ( $authName == "AUTH_NAME_HERE" && $authPassword == "AUTH_PASSWORD_HERE" ) {
        $authorized = true;
		}
    }
}

if ($authorized) {
	//echo "\nAuthorized successfully\n";
} else {
    header('WWW-Authenticate: Basic realm="owlair"');
    header('HTTP/1.0 401 Unauthorized');
    echo "authorization failed";
	exit;
}

if ( $authorized && isset($_GET['UID']) ) {
	$UID =  $_GET['UID'] ;
	//echo "\nUID value is,  " .$UID;
	$accountSid = "ACCOUNT_SID_HERE";
    $signingKeySid = "SIGNING_KEY_HERE";
    $signingKeySecret = "KEY_SECRET_HERE";

    $token = new Services_Twilio_AccessToken($signingKeySid, $accountSid, $signingKeySecret);
    $token->addEndpointGrant($UID);
    $token->enableNTS();
    $accessToken =  $token->toJWT();
	header('Content-type: text/plain');
	echo $accessToken;
} else {
	echo "UID parameter missing. Please try again with the correct argument";
	}
?>
