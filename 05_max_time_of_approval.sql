
SELECT
	TIME_FORMAT(
		SEC_TO_TIME(MAX(TIME_TO_SEC(time_of_approval))),
		'%H:%i:00')
        AS max_time_of_approval
FROM
	time_of_approval
;
