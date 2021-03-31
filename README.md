# PrescriptionTracker

## Installation Instructions 
Ensure that you have git and node installed on your computer. Node can be downloaded by following the instructions on this site: https://nodejs.org/en/download/ . Then, clone the git repository by running 

```git clone https://github.com/ElkaRavenwood/PrescriptionTracker.git```

in the shell. Alternate ways of doing so can be found by clicking the green "Code" button.

### Backend Set Up and Connection

Follow the instructions in this video to install and set up Postges (https://youtu.be/qw--VYLpxG4 @ 10:55).
Take note of the password used in your set up process.

Start up the Postgres Terminal and log in using the default information (simply press Enter till you are prompted for your password).

Once logged in, type the following command:

```\i 'remainderFilePath/PrescriptionTracker/src/db_setup_commands.sql'```

Replace ```remainderFilePath``` with the file path to the PrescriptionTracker folder.

Note: If you are on Windows, you must change all backslashes ```\``` in the file path to forward slashes ```/```. This is a special requirement for the postgres terminal.

Press ```Enter``` on your keyboard. to execute the command. It may take a few seconds for file to be parsed.
This will be followed by several ```CREATE TABLE``` and ```INSERT 0 1``` outputs terminal.

When you are presented with the terminal ```meditrack_db=#```, the database set up is complete.

Navigate to PrescriptionTracker/src/db_connect.js:

If you are on Windows, Change the username on line 14 from ```me``` to ```postgres```.

For both Windows and MacOS, Change the password on line 15 from ```password``` to the password you used in your set up process.

Optional Test:

Perform a test call using Postman to verify if the database is connected GET http://localhost:8000/meditrack/test
This will return the information for the first user in the system (Todd Peters).


## Starting the Project
In the shell, navigate to the PrescriptionTracker folder in the repository. Run

```npm run setup```

This may take a few minutes. A web browser will be opened, but disregard it for now. The shell terminal should look like this:
```
Compiled successfully!

You can now view prescription-tracker-client in the browser.

  Local:            http://localhost:3000
  On Your Network:  http://192.168.2.11:3000

Note that the development build is not optimized.
To create a production build, use npm run build.
```
Once this is complete, open a new shell terminal. Navigate to the PrescriptionTracker directory and run.

```npm run dev```

Navigate back to the web browser that was opened, or use the link provided in the first shell window.

Have fun!

## Notes on Testing
For the purposes of [a patient] contacting the pharmacies, an email was created. The email credentials are below:

Username: jwtesting2021@outlook.com

Password: testPassword


For simulated patients and pharmacies, the following credentials can be used:

Patient Credentials:

Username: tpetters0@walmart.com

Password: epfHyxOLpN7


Pharmacy Credentials:

Username: bsladea@google.co.jp

Password: nVYn0e