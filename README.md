# Owl Air
### Learn how to add context to your agent and customer experience.
The purpose of Owl Air is to provide inspiration around a seamless, cross-channel experience to your customers. Give agents the context they need to provide great services. Impact to business: reduces call duration and faster time to resolution for higher customer satisfaction.

Watch the following video to see Owl Air in action:
[![Owl Air Demo](https://github.com/jonedavis/owl-air/blob/master/Images/owlair-youtube.png)](http://bit.ly/2a5enyc)

### Requirements:

Services:
 - Firebase API and Key
 - Flurry for analytics
 - Hockeyapp for enterprise distribution
 - Twitter for simulating multi tenanted app.
 - Twilio SID and Token
 - XCode with latest version
 - iOS which configured with provisioning profile to run the application

[Conversations SDK](https://www.twilio.com/docs/api/video/sdks):

 - Uncomment line : source 'https://github.com/twilio/cocoapod-specs'
                    pod 'TwilioConversationsClient'
 - Terminal: Goto path/for/OwlAir/Mobile
 - Terminal: pod update

Build Project

### Conversations SDK
[Conversations SDK](https://www.twilio.com/video) is a real-time video infrastructure and SDKs to create rich multi-party video and HD audio experiences in mobile and web apps. Take advantage of Twilio's amazing [Guides](https://www.twilio.com/docs/api/video/guide/conversations) on on the Conversations SDK. Owl Air uses the Audio Channel of this Video SDK.
