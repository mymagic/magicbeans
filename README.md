#Facebook Set Up

1. https://developers.facebook.com/
2. Log in to your account.
3. Under the My Apps tab, click 'create new app'.
4. Select website.
5. Choose a name for your application.
6. Create Application.
7. Select a suitable category.
8. Create App ID.
9. Scroll down and enter your site url, then click next. (http://localhost:3000 if on local machine)
10. Click on the Facebook Developers Logo to refresh the page.
11. Go to your app under the My Apps tab.
12. Go to Settings and enter your contact email, then save changes.
13. Go to Status & Reviews.
14. Do you want to make this app and all its live features available to the general public?
15. Click on No to change to YES and confirm.
16. Head back to Dashboard to copy your App Id and App Secret to the settings page on Magicbeans, then save them.
17. Head over to https://developers.facebook.com/tools/explorer/.
18. Select your app, Click on Get Access Token, Extended Permissions, then tick "Publish_action" and "Manage_pages", Get Access Token.
19. Accept all consent on Pop Up.
20. Copy the Access Token to settings page.
21. Change the GET url to "me/accounts" and submit.
22. Find the facebook page and copy the page id to setting page.
23. Click on Save button first.
24. Then click on Generate button on Page Access Token field.

**You are good to go for posting to Facebook!**

> P.S. One more thing, you gotta create event on eventbrite first, get to eventbrite to make the event live then only posting to facebook will work.

**What will Magicbeans post to Facebook?**
1. Your status update. (Pre-populated message can be customized)
2. Link to Eventbrite event .
3. Name of Activity as the name for link.
4. Description of Activity as the description for link.
5. Picture of Activity as the image for link.

#Google Calendar Set Up

**Create the service account and its credentials**

The service account will do the communication between the application and Google Calendar (through the v3 API).

1. Sign in to the account of which you want to share the Google Calendar.
2. Visit the Google Developers Console.
3. Set up your project if you haven't already done so and enable the 'Google Calendar API'.
4. Select your project and go to "APIs & auth", make sure "Google Calender API" is enabled.
5. Click on 'credentials'.
6. Click on "Create new client ID". Specify that your application type is service account, and proceed with the setup of the service account.

> You should now have:
>
> * Client ID (xxx.apps.googleusercontent.com)
> * email address (xxx@developer.gserviceaccount.com)
> * A private key file

**Share your calendar with the service account**

Your service account will need to have access to the Google Calendar of the calendar user, to do this:

Sign in to the account of which you want to share the Google Calendar.

1. Visit Google Calendar.
2. Click on settings/calendars and 'edit settings' of the calendar you want to share.
3. In the field 'Share with specific people' add the developer email address: xxxxxx@developer.gserviceaccount.com.
4. select proper permissions and click on save.

**Configure Setting**

calendarID is usually your email address if you are using your own calendar.However, the ID might change if you created another calendar using the same email.

1. Go to Google Calendar.
2. On your left there are a few calendar listed if you have few of them.
3. Click on the small down arrow beside the calendar.
4. Select calendar settings.
5. Scroll down and you will see the calendarID option.
6. Copy the email address (xxx@developer.gserviceaccount.com) and calendarID into setting page and save.

In the following code, place your secret keyfile at ~/keyfile.p12 and change the name of the keyfile.p12 file to yours.

````
def create_gcal
.
key = Google::APIClient::KeyUtils.load_from_pkcs12( File.join(Rails.root, '..', '..', 'keyfile.p12').to_s , 'notasecret')
.
end
````

This should be sufficient enough to make Google Calendar work.

#Twitter Set Up

1. Go to apps.twitter.com.
2. Sign in.
3. Create a new application:
 * https://apps.twitter.com/
 * Create new app.
 * Fill in all necesarry informations.
 * Provide suitable permission for the app. (Read and Write for this instance)
 * Generate your Apps Key, Secret and Access Token and Access Token Secret from the Keys and Access Tokens tab. (Need this for later config.)
 * You will have to regenerate App Key and Secret if you change permissions.
4. Copy all these env vars to the settings page.
 * Twitter Consumer Key
 * Twtter Consumer Key Secret
 * Twitter Access Token
 * Twitter Acces Token Secret

**What will Magicbeans tweet?**
1. Your tweet. (Pre-populated message can be customized)
2. Link to Eventbrite event within the tweet. 
3. Picture of Activity as the image.