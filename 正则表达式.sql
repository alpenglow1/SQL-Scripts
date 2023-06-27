/*找到昵称以"牛客"+纯数字+"号"或者纯数字组成的用户
对于字母c开头的试卷类别（如C,C++,c#等）的已完成的试卷ID和平均得分，按用户ID、平均分升序排序 */

SELECT
	uid,
	exam_id,
	round(avg(score)) AS avg_score
FROM
	exam_record
JOIN examination_info
		USING(exam_id)
JOIN user_info
		USING(uid)
WHERE
	(nick_name REGEXP '^牛客[0-9]+号$'
	OR nick_name REGEXP '^[0-9]+$')
	AND tag REGEXP '^c'
	AND score IS NOT NULL
GROUP BY
	uid,
	exam_id
ORDER BY
	uid,
	avg_score