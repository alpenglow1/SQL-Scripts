/*请输出每份试卷每月作答数和截止当月的作答总数
exam_id	start_month	month_cnt	cum_exam_cnt */

SELECT exam_id,date_format(start_time,'%Y%m') AS start_month,
Count(start_time) AS month_cnt,
sum(Count(start_time)) over(PARTITION BY exam_id ORDER BY date_format(start_time,'%Y%m')) AS 
cum_exam_cnt
FROM exam_record
GROUP BY exam_id,start_month