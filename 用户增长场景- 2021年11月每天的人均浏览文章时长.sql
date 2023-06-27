/*场景逻辑说明：artical_id-文章ID代表用户浏览的文章的ID，artical_id-文章ID为0表示用户在非文章内容页（比如App内的列表页、活动页等）。
问题：统计2021年11月每天的人均浏览文章时长（秒数），结果保留1位小数，并按时长由短到长排序。
输出示例：
示例数据的输出结果如下
dt	avg_viiew_len_sec */

SELECT 
date_format(in_time,'%Y-%m-%d')  AS dt,
round(sum(timestampdiff(SECOND,in_time,out_time))/count(DISTINCT uid),1) AS avg_viiew_len_sec
FROM tb_user_log
WHERE year(in_time)=2021 AND month(in_time)=11 AND artical_id != 0
GROUP BY dt 
ORDER BY avg_viiew_len_sec 
