sms2droid
=========

sms2droid converts format of iPhone SMS to Android. it's a simple Ruby script to convert the iPhone sms database to Android. It does so by converting the sms database into a format that can be used by an Android phone.

The script extracts the data from the iphone sms database file, which is the iPhone's sms backup file and creates an xml file which can be used by the `SMS Backup & Restore` [android app](http://android.riteshsahu.com/apps/sms-backup-restore).


sms2droid is released under the Apache License, Version 2.0

Very Important
------

#### It's only for iOS 6!!

How To
------

### Software needed:

#### On your Mac OR Windows

- iTunes

#### On your Android (Android Market)

- `SMS Backup & Restore` (by Ritesh Sahu) from the Android Market

- A file management





### Before using sms2droid

- Sync your iPhone to iTunes.

- Ensure you back up your data on your Android as well. (Very Important!)

- Once your iPhone is done, you need to find out iphone sms database file, which is in "~/Library/Application Support/MobileSync/Backup/`random characters`/" on Mac or "C://[Users]/[Username]/AppData/Roaming/Apple Computer/Mobile Sync/`random characters`/" on Windows. sms database file's name is "3d0d7e5fb2ce288813306e4d4636395e047a3d28".

- Make sure you have ruby(2.0.0) and Gem sqlite3 installed.


You are now ready to use sms2droid!


Using
-----

To use the script just download it and from the command line:

    ruby sms2droid.rb

and then just follow the instructions to convert the iphone sms database file.


At this point you should have a file called `sms.xml`

Put the `sms.xml` file into your Android phone and use `SMS Backup & Restore` to restore your sms.

Connect your android to your Mac or Windows, ensure that you can use the phone as an external disk and copy the xml file to the `SMSBackupRestore` directory. You can also use DropBox if you have it installed on your phone, and then using one of the above mentioned File managers copy the file to the destination directory.

At this point on the phone start the `SMS Backup & Restore` app and click on the `Restore` button, select the file you just uploaded and depending on how many messages you are importing you might have to wait a little. Ensure that your phone does not go to sleep while the data is being imported.

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


[iPhone : Fixing the unread SMS count - the gentle way](http://webcache.googleusercontent.com/search?q=cache:i-sFoBhYToEJ:yadloo.blogspot.com/2008/11/iphone-fixing-unread-sms-count-gentle.html+iphone+sms.db+flags+0&cd=2&hl=da&ct=clnk&gl=dk&source=www.google.dk)
