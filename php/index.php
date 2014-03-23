<?php
// ini_set('display_errors',1);
// ini_set('display_startup_errors',1);
// error_reporting(-1);

header('Content-Type: text/html; charset=UTF-8');
$id = $_GET['id'];
if (is_numeric($id)) {
    # set this to the correct path to the shell script
	passthru("/home/axr/g2s/doit.sh $id");
} else {
?>
<html>
<head>
<title>axr's garmin-2-strava</title>
</head>
<body>
<?php
	# set this to the correct path to the shell script
	passthru("/home/axr/g2s/get-activitylist.sh", $err);
?>
</body>
</html>
<?php
}
?>
