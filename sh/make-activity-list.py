#!/usr/bin/env python3

import json
import sys

activityList = json.load(sys.stdin)["activityList"]

for a in activityList:
    if a["activityType"]["typeKey"] != "cycling": continue

    id = a["activityId"]
    time = a["startTimeLocal"]
    length = float(a["distance"]) / 1000.0
    duration = float(a["duration"]) / 60.0

    # print("%d %s (%06.2f km, %05.1f min)" % (id, time, length, duration))
    print("<a href=\"?id=%d\">%d</a> %s (%06.2f km, %05.1f min)<br/>" % (id, id, time, length, duration))
