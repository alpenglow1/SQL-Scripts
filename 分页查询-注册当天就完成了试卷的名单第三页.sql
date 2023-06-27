/*找到求职方向为算法工程师，且注册当天就完成了算法类试卷的人，
按参加过的所有考试最高得分排名。
排名榜很长，我们将采用分页展示，每页3条，现在需要你取出第3页（页码从1开始）的人的信息。
uid	 level	register_time	max_score */

WITH t1 AS (
SELECT
uid,job,LEVEL,register_time,start_time,exam_id,score,tag
FROM exam_record a
JOIN user_info b using(uid)
JOIN examination_info using(exam_id)
)

SELECT uid,LEVEL,register_time,
max(score) AS max_score
FROM t1
WHERE uid IN (
SELECT DISTINCT uid
FROM t1
WHERE  job ='算法' AND date(start_time)=date(register_time)
AND tag='算法')
GROUP BY uid
ORDER BY max_score DESC
LIMIT 3 offset 6
