/*请你筛选表中的数据，当有任意一个0级用户未完成试卷数大于2时，
 输出每个0级用户的试卷未完成数和未完成率（保留3位小数）；
 若不存在这样的用户，则输出所有有作答记录的用户的这两个指标。结果按未完成率升序排序*/

WITH t1 AS (
SELECT uid,LEVEL,
count(exam_id)-count(submit_time) AS incomplete_cnt,
ROUND( IFNULL(1 - COUNT(submit_time) / COUNT(start_time), 0), 3) as incomplete_rate
FROM user_info
LEFT JOIN exam_record USING(uid)
GROUP BY uid
ORDER BY incomplete_rate)

SELECT uid,incomplete_cnt,incomplete_rate
FROM t1
WHERE EXISTS (SELECT * FROM t1
                  WHERE LEVEL=0 AND incomplete_cnt >2) AND LEVEL=0
UNION ALL 
SELECT uid,incomplete_cnt,incomplete_rate
FROM t1
WHERE NOT EXISTS (SELECT uid FROM t1
                  WHERE LEVEL=0 AND incomplete_cnt >2) 
AND incomplete_rate IS NOT NULL





