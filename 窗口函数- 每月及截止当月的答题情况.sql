/*请输出自从有用户作答记录以来，每月的试卷作答记录中月活用户数、新增用户数、截止当月的单月最大新增用户数、截止当月的累积用户数。
 结果按月份升序输出。
 start_month	mau--答过题的人 	month_add_uv	max_month_add_uv  cum_sum_uv */


SELECT
	start_month,
	count(DISTINCT uid) AS mau,
	sum(new_day) AS month_add_uv,
	max(sum(new_day)) OVER(
	ORDER BY start_month) AS max_month_add_uv,
	sum(sum(new_day)) OVER(
	ORDER BY start_month) AS cum_sum_uv
FROM
	(
	SELECT
		uid,
		start_time,
        date_format(start_time,'%Y%m') AS start_month,
		IF(start_time=min(start_time) OVER(PARTITION BY uid) ,1,0) AS new_day-- 每个用户第一天登录时间
	FROM
		exam_record
		) t1
GROUP BY
	start_month
ORDER BY start_month

