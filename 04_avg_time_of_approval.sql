SELECT
	TIME_FORMAT(
		SEC_TO_TIME(AVG(TIME_TO_SEC(time_of_approval))),
		'%H:%i:00')
        AS avg_time_of_approval
FROM
	time_of_approval
;