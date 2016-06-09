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
	echo "\nUID value is,  " .$UID;
	$accountSid = "";
    $signingKeySid = "";
    $signingKeySecret = "";
	$configurationProfileSid = "";
	
	$token = new Services_Twilio_AccessToken(
    $accountSid,
    $apiKeySid,
    $apiKeySecret,
    $ttl=3600,
    $identity=$UID
	);

	// Grant access to Conversations
	$grant = new Services_Twilio_Auth_ConversationsGrant();
	$grant->setConfigurationProfileSid($configurationProfileSid);
	$token->addGrant($grant);

// Serialize the token as a JWT
	$accessToken =  $token->toJWT();
	header('Content-type: text/plain');
	echo $accessToken;

} else {
	echo "UID parameter missing. Please try again with the correct argument";
	}
?>
