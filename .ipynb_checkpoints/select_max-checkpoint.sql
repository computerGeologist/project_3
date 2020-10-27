

SELECT p1.page_id, p1.normal_measurement, p1.units_uri, p1.units_name, p1.pred_name
FROM pantheria p1 
INNER JOIN (SELECT page_id, MAX(normal_measurement) AS MaxPredicate FROM pantheria  WHERE pred_name ='body mass' GROUP BY page_id) p2
ON p1.page_id = p2.page_id
AND p1.pred_name = 'body mass'
AND p1.normal_measurement = MaxPredicate;