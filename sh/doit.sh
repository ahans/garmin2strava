#!/bin/bash

# your Strava login details go here
EMAIL=my@email.com
PASSWORD=myverysecurepassword


rm -f cookies.txt myactivity.tcx upload.html


garmin_id=$1
echo ${garmin_id}
# get file from Garmin
curl "http://connect.garmin.com/proxy/activity-service-1.1/tcx/activity/${garmin_id}?full=true" > myactivity.tcx

echo "got activity"

# get login page
AUTH=$(curl --cookie cookies.txt --cookie-jar cookies.txt -k https://www.strava.com/login | grep 'name="authenticity_token"' | sed 's/.*value="\(.*\)".*/\1/g')
echo "AUTH=$AUTH"

# login
curl --cookie cookies.txt --cookie-jar cookies.txt -k --data-urlencode "utf8=&#x2713;" --data-urlencode "authenticity_token=$AUTH" --data-urlencode "plan=" --data-urlencode email="${EMAIL}" --data-urlencode password="${PASSWORD}" --data-urlencode "remember_me=on" https://www.strava.com/session

# go to upload page
curl --cookie cookies.txt --cookie-jar cookies.txt http://www.strava.com/upload/select | grep "authenticity_token"

# send file
curl --cookie cookies.txt --cookie-jar cookies.txt -F "_method=post" -F "authenticity_token=$AUTH" -F "files[]=@myactivity.tcx" http://www.strava.com/upload/files > upload.html


sleep 10

# logout
curl --cookie cookies.txt --cookie-jar cookies.txt --data-urlencode "_method=delete" --data-urlencode "authenticity_token=$AUTH" http://www.strava.com/session


