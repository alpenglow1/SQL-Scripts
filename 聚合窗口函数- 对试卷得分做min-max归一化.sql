/*在物理学及统计学数据计算时，有个概念叫min-max标准化，也被称为离差标准化，是对原始数据的线性变换，使结果值映射到[0 - 1]之间。
请你将用户作答高难度试卷的得分
在每份试卷 group by 作答记录内执行min-max归一化后缩放到[0,100]区间， （min(score) max(score) 聚合窗口函数）
并输出用户ID、试卷ID、归一化后分数平均值；
最后按照试卷ID升序、归一化分数降序输出。*/

SELECT
	uid,
	exam_id,
	round(avg(gyh_score)) AS avg_new_score
FROM
	(
	SELECT
		uid,
		exam_id,
		IF(min_score=max_score,score,100*(score-min_score)/(max_score-min_score)) AS gyh_score -- 得到每行归一化的分数
	FROM
		(
		SELECT
			uid,
			exam_id,score,
			min(score) OVER(PARTITION BY exam_id) AS min_score,
			max(score) OVER(PARTITION BY exam_id) AS max_score
		FROM
			exam_record
		JOIN examination_info
				USING(exam_id)
		WHERE
			difficulty = 'hard'
			AND score IS NOT NULL ) t1
) t2
GROUP BY
	uid,
	exam_id
ORDER BY exam_id , avg_new_score DESC 