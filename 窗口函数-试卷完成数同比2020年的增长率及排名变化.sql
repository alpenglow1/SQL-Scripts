/*请计算2021年上半年各类试卷的做完次数
 相比2020年上半年同期的增长率（百分比格式，保留1位小数），（2021-2020）/2020
以及做完次数排名变化，按增长率和21年排名降序输出
tag   exam_cnt_20	 exam_cnt_21	
growth_rate	     exam_cnt_rank_20  exam_cnt_rank_21  rank_delta*/

#写法一
-- 上半年各类试卷的做完次数
WITH t1 AS (
SELECT tag,
 sum(if(YEAR(submit_time)=2020 AND MONTH(submit_time)<=06,1,0 )) AS exam_cnt_20,
 sum(if(YEAR(submit_time)=2021 AND MONTH(submit_time)<=06,1,0 )) AS exam_cnt_21
FROM exam_record
JOIN examination_info using(exam_id)
GROUP BY tag 
),
t2 AS (
-- 增长率
SELECT tag,concat(round(100*((exam_cnt_21-exam_cnt_20)/exam_cnt_20),1),'%') AS growth_rate
FROM t1
),
-- 排名
t3 AS (
SELECT tag,
rank() OVER(ORDER BY exam_cnt_20 desc) AS exam_cnt_rank_20,
rank() OVER(ORDER BY exam_cnt_21 desc) AS exam_cnt_rank_21
FROM t1
),
-- 排名变化
t4 AS (
SELECT tag,CAST(exam_cnt_rank_21 AS signed)-CAST(exam_cnt_rank_20 AS signed) AS rank_delta
FROM t3
)

SELECT tag,exam_cnt_20,exam_cnt_21,growth_rate,
exam_cnt_rank_20,exam_cnt_rank_21,rank_delta
FROM t1
JOIN t2 using(tag)
JOIN t3 using(tag)
JOIN t4 using(tag)
WHERE exam_cnt_20 !=0 AND exam_cnt_21 !=0
ORDER BY growth_rate DESC,exam_cnt_rank_21 DESC


#写法二
/*请计算2021年上半年各类试卷的做完次数
 相比2020年上半年同期的增长率（百分比格式，保留1位小数），（2021-2020）/2020
以及做完次数排名变化，按增长率和21年排名降序输出
tag   exam_cnt_20	 exam_cnt_21	
growth_rate	     exam_cnt_rank_20  exam_cnt_rank_21  rank_delta*/

SELECT
	tag,
	exam_cnt_20,
	exam_cnt_21,
	growth_rate,
	exam_cnt_rank_20,
	exam_cnt_rank_21,
	CAST(exam_cnt_rank_21 AS signed)- CAST(exam_cnt_rank_20 AS signed) AS rank_delta
FROM
	(
	SELECT
		tag,
		exam_cnt_20,
		exam_cnt_21,
		concat(round(100*(exam_cnt_21-exam_cnt_20)/ exam_cnt_20,1),'%') AS growth_rate,
		RANK() OVER(
		ORDER BY exam_cnt_20 DESC) AS exam_cnt_rank_20,
		RANK() OVER(
		ORDER BY exam_cnt_21 DESC) AS exam_cnt_rank_21
	FROM
		(
		SELECT
			tag,
			sum(IF(YEAR(submit_time)= 2020 AND MONTH(submit_time) <= 6, 1, 0)) AS exam_cnt_20,
			sum(IF(YEAR(submit_time)= 2021 AND MONTH(submit_time) <= 6, 1, 0)) AS exam_cnt_21
		FROM
			exam_record
		JOIN examination_info
				USING(exam_id)
		GROUP BY
			tag) t1

) t2
WHERE
		exam_cnt_20 != 0
		AND exam_cnt_21 != 0
ORDER BY
	growth_rate DESC,
	exam_cnt_rank_21 DESC

