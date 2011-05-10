sms2droid
=========

This is a simple Ruby script to convert the SMS's in an iPhone into a format that can be used in a Android phone.

The script extracts the data from the sms.db file, which is the iPhone's sms backup file and creates an xml file which can be used by the 'SMS Backup & Restore' [android app](http://android.riteshsahu.com/apps/sms-backup-restore).


sms2droid is released under the Apache License, Version 2.0


How To
------

### Software needed:

#### On your Mac

- iPhone / iPod Touch Backup Extractor (donationware: http://supercrazyawesome.com/)

#### On your Windows

- coming...

#### On your Android (Android Market)

- SMS Backup and Restore (by Ritesh Sahu) from the Android Market

- File Expert (http://www.appbrain.com/app/file-expert/xcxin.filexpert)

or

- ASTRO File Manager (http://www.appbrain.com/app/com.metago.astro)





### Before using sms2droid

- Sync your iPhone to iTunes.

- Ensure you back up your data on your Android as well. (Very Important!)

- Once your iPhone is done, you need to launch the 'iPhone / iPod Touch Backup Extractor'

- click on the 'Read Backups' button and select which backup you would like to read from.

- From the list displayed select 'iOS Files' and click on 'Extract'

- Select the destination path and let the app do it's work.

- Go to the destination path and open the dir 'Library/SMS' and there you should see a file called `sms.db`.

- Copy the file somewhere simple to find.


You are now ready to use sms2droid!


Using
-----

To use the script just download it and from the command line:

    ruby sms2droid.rb

and then just follow the instructions to convert the `sms.db`.


At this point you should have a file called `sms.xml`

Rename the `sms.xml` file to look like this `sms-YYYYMMDDHHmmSS.xml` for example `sms-20110505235900.xml`

Connect your android to your Mac or Windows, ensure that you can use the phone as an external disk and copy the xml file to the `SMSBackupRestore` directory. You can also use DropBox if you have it installed on your phone, and then using one of the above mentioned File managers copy the file to the destination directory.

At this point on the phone start the SMS Backup & Restore app and click on the `Restore` button, select the file you just uploaded and depending on how many messages you are importing you might have to wait a little. Ensure that your phone does not go to sleep while the data is being imported.

Exit the app and start your `Messages` app and you should see all your imported messages.

That's it!

Hope you find the script useful.


Comments
-----

Feel free to leave any comments or suggestions :)


References
----------

[Android Stuff](http://android.riteshsahu.com/tips/import-sms-iphone-android)


[iPhone Database Details](http://damon.durandfamily.org/archives/000487.html)


[iPhone : Fixing the unread SMS count - the gentle way])http://webcache.googleusercontent.com/search?q=cache:i-sFoBhYToEJ:yadloo.blogspot.com/2008/11/iphone-fixing-unread-sms-count-gentle.html+iphone+sms.db+flags+0&cd=2&hl=da&ct=clnk&gl=dk&source=www.google.dk)

