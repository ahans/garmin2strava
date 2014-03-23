#!/bin/sh

# your Garmin Connect username goes here
GARMIN_USERNAME=garmin_user

curl -s "http://connect.garmin.com/proxy/activitylist-service/activities/${GARMIN_USERNAME}?start=1&limit=10" | python /home/axr/g2s/make-activity-list.py
