/*请统计SQL试卷上未完成率较高的50%用户中，6级和7级用户
在有试卷作答记录的近三个月中，
每个月的答卷数目和完成数目。
按用户ID、月份升序排序。*/
WITH t0 AS (
SELECT uid,
sum(IF(score IS NULL,1,0))/count(exam_id) AS incomplete_rate -- sql未完成率
FROM exam_record 
JOIN examination_info using(exam_id)
WHERE tag = 'SQL'
GROUP BY uid),
t1 AS (
SELECT uid,pr
FROM
    (SELECT uid,-- 未完成率较高的50%用户
     percent_rank() over(ORDER BY incomplete_rate desc) AS pr
    FROM t0) t1
WHERE pr <= 0.5 ),
t2 AS (
SELECT uid
FROM t1
JOIN user_info USING(uid)
WHERE LEVEL IN (6,7)) -- 未完成率较高的50%用户且等级为6或7,完成用户圈选

SELECT uid,date_format(start_time,'%Y%m') AS start_month,
count(exam_id) AS total_cnt,
sum(if(score IS NULL,0,1)) AS complete_cnt
FROM
    (SELECT uid,exam_id,start_time,score,
            dense_rank() OVER(PARTITION BY uid ORDER BY date_format(start_time,'%Y%m') desc) AS dr
     FROM exam_record) t3
WHERE dr <=3 AND uid IN (SELECT * FROM t2)-- 有试卷作答记录的近三个月
GROUP BY uid,start_month
ORDER BY uid,start_month
