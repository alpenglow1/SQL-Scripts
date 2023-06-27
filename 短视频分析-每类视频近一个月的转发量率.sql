/*问题：统计在有用户互动的最近一个月
 按包含当天在内的近30天算，比如10月31日的近30天为10.2~10.31之间的数据）中，每类视频的转发量和转发率（保留3位小数）。
注：转发率＝转发量÷播放量。结果按转发率降序排序。
输出示例：
示例数据的输出结果如下
tag	retweet_cut	retweet_rate*/

SELECT tag,
sum(if_retweet) AS retweet_cut,
round(avg(if_retweet),3) AS retweet_rate
FROM tb_user_video_log
JOIN tb_video_info using(video_id)
WHERE datediff((SELECT max(start_time) FROM tb_user_video_log),start_time)<=29 -- 筛选出最近一个月
GROUP BY tag
ORDER by retweet_rate desc