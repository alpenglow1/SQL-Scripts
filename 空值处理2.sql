-- 请输出每个0级用户所有的高难度试卷考试平均用时和平均得分，未完成的默认试卷最大考试时长和0分处理

SELECT uid,
round(sum(if(score IS NOT NULL,score,0))/count(exam_id)) AS avg_score,
round(sum(if(submit_time IS NOT NULL,
       timestampdiff(MINUTE,start_time,submit_time),duration))/count(exam_id),1) AS avg_time_took
FROM exam_record
JOIN user_info using(uid)
JOIN examination_info using(exam_id)
WHERE LEVEL=0 AND difficulty='hard'
GROUP BY uid 
