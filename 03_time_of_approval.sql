CREATE VIEW time_of_approval AS
SELECT 
	c.cnpj AS CNPJs, 
	MAX(s2.data_horario_do_status) AS date_of_purchase, 
	TIME_FORMAT(
		TIMEDIFF(
			MAX(s1.data_horario_do_status),
			MAX(s2.data_horario_do_status)), 
		'%H:%i:00') 
	AS time_of_approval
FROM 
	clientes c
	JOIN `status` s1 ON c.user_id = s1.user_id 
	JOIN `status` s2 ON s1.user_id = s2.user_id
WHERE 
	s1.`status` = 'approved' AND s2.`status` = 'pending_kyc'
GROUP BY 
	c.cnpj
ORDER BY 
	date_of_purchase DESC
;
