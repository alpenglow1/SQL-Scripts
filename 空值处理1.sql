-- 请统计有未完成状态的试卷的未完成数incomplete_cnt和未完成率incomplete_rate


SELECT exam_id,
sum(IF(score IS NULL,1,0)) AS incomplete_cnt,
sum(IF(score IS NULL,1,0))/count(exam_id) AS incomplete_rate
FROM exam_record
WHERE exam_id IN (SELECT DISTINCT exam_id -- 得到试卷号
    FROM exam_record
    WHERE score IS NULL)
GROUP BY exam_id