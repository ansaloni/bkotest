SELECT
	TIME_FORMAT(
		SEC_TO_TIME(MIN(TIME_TO_SEC(time_of_approval))),
		'%H:%i:00')
        AS min_time_of_approval
FROM
	time_of_approval
;